import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/rectangular_product_card.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/title_with_count_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> removeProductFromCart(
        {required Product product, required Cart cart}) async {
      final boolean = await showConfirmationDialog(context, 'Remove From Carts',
          'Are You Sure You Want To Remove this Product From Carts', () {
        context.read<CartPageBloc>().add(
              UpdateProductToCartEvent(
                itemCount: 0,
                product: product,
                cart: cart,
              ),
            );
      });
      return boolean!;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartPageBloc>().add(GetAllProductsEvent());
    });
    // context.read<CartPageBloc>().add(GetAllCartEvent());
    List<TextEditingController> controllers = [];
    void generateTextEditingController(int length) {
      for (int i = 0; i < length; i++) {
        controllers.add(TextEditingController());
      }
    }

    return Scaffold(
      appBar: const AppBarSearchBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            color: AppPallete.lightgreyColor,
            height: 50,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<CartPageBloc, CartPageState>(
                  buildWhen: (previous, current) =>
                      current is CartProductListViewState,
                  builder: (context, listState) {
                    if (listState is CartProductsListViewSuccess) {
                      return TitleWithCountBar(
                        title: 'Cart',
                        itemsCount:
                            '${calculateTotalQuantity(listOfCarts: listState.listOfCarts)} Items',
                        totalPrize: calculateTotalPrize(
                          products: listState.listOfProducts,
                          carts: listState.listOfCarts,
                        ).toString(),
                      );
                    }
                    return const TitleWithCountBar(
                      title: 'Cart',
                      itemsCount: '0 Items',
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<CartPageBloc, CartPageState>(
              listener: (context, state) {
                if (state is CartUpdatedSuccess) {
                  Fluttertoast.showToast(msg: 'The Cart Updated Successfully');
                  context.read<CartPageBloc>().add(GetAllProductsEvent());
                }

                if (state is ProductUpdatedToFavoriteCartSuccess) {
                  Fluttertoast.showToast(
                      msg: 'The Favorite Updated Successfully');
                  // context.read<CartPageBloc>().add(GetAllProductsEvent());
                }

                if (state is ProductUpdatedToFavoriteCartFailed) {
                  Fluttertoast.showToast(msg: state.message);
                }
              },
              buildWhen: (previous, current) =>
                  current is CartProductListViewState,
              builder: (context, listState) {
                if (listState is CartProductsListViewSuccess) {
                  generateTextEditingController(
                      listState.listOfProducts.length);
                  return ListView.separated(
                    itemCount: listState.listOfProducts.length,
                    itemBuilder: (context, index) {
                      final currentProduct = listState.listOfProducts[index];
                      bool productIsCarted = false;
                      final cartIndex = checkCurrentProductIsCarted(
                        product: listState.listOfProducts[index],
                        carts: listState.listOfCarts,
                      );

                      if (cartIndex > -1) {
                        productIsCarted = true;
                      }
                      controllers[index].text = listState
                          .listOfCarts[cartIndex].productCount
                          .toString();
                      return RectangularProductCard(
                        isFavorite: listState.listOfFavorites
                            .contains(currentProduct.productID),
                        // items: const [],
                        isLoading: false,
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                              AppRouteConstants.detailsPage,
                              extra: currentProduct);
                        },
                        onTapFavouriteButton: (bool isLiked) async {
                          context.read<CartPageBloc>().add(
                                UpdateProductToFavoriteEvent(
                                  product: currentProduct,
                                  isFavorited: !isLiked,
                                ),
                              );
                          return !isLiked;
                        },
                        onTapRemoveButton: () {
                          removeProductFromCart(
                              product: currentProduct,
                              cart: listState.listOfCarts[cartIndex]);
                        },
                        isFavoriteCard: false,
                        productName: currentProduct.name,
                        productPrize: currentProduct.prize.toString(),
                        vendorName: currentProduct.vendorName,
                        deliveryDate: currentProduct.brandName,
                        productImage: currentProduct.displayImageURL,
                        productQuantity: currentProduct.quantity.toString(),
                        textEditingController: controllers[index],
                        onPressedSaveButton: () {
                          final newCount = int.parse(controllers[index].text);
                          if (currentProduct.quantity >= newCount &&
                              newCount > 0) {
                            if (productIsCarted) {
                              context.read<CartPageBloc>().add(
                                    UpdateProductToCartEvent(
                                      itemCount: newCount,
                                      product: currentProduct,
                                      cart: listState.listOfCarts[cartIndex],
                                    ),
                                  );
                            }
                          } else {
                            showSnackBar(
                                context: context,
                                title: 'Amount',
                                content: 'insufficient Quantity',
                                contentType: ContentType.failure);
                          }
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 10,
                        color: AppPallete.lightgreyColor,
                      );
                    },
                  );
                }
                return ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return RectangularProductCard(
                        isLoading: true,
                        onTap: () {},
                        isFavoriteCard: false,
                        productName:
                            ' Sony PlayStation 5 Console (Disc Version) With Controller',
                        productPrize: '2888',
                        vendorName: 'Mohammed Rayid',
                        deliveryDate: 'Tomorrow 5 March',
                        productImage: null,
                        textEditingController: null,
                        productQuantity: '0');
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 10,
                      color: AppPallete.lightgreyColor,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BlocBuilder<CartPageBloc, CartPageState>(
        buildWhen: (previous, current) => current is CartProductListViewState,
        builder: (context, listState) {
          if (listState is CartProductsListViewSuccess) {
            final double subTotal = calculateTotalPrize(
              products: listState.listOfProducts,
              carts: listState.listOfCarts,
            );

            final double totalShpping = calculateTotalShipping(
              products: listState.listOfProducts,
              carts: listState.listOfCarts,
            );

            final double total = subTotal + totalShpping;
            return Container(
              height: 300,
              decoration: const BoxDecoration(
                boxShadow: [Constants.globalBoxBlur],
                color: AppPallete.whiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalTitleText(
                      title:
                          '${calculateTotalQuantity(listOfCarts: listState.listOfCarts)} Items',
                    ),
                    BottomSheetRowText(
                      title: 'Sub Total',
                      value: subTotal.toString(),
                    ),
                    const Divider(),
                    BottomSheetRowText(
                      title: 'Total Shipping',
                      value: totalShpping.toString(),
                    ),
                    const Divider(),
                    BottomSheetRowText(
                      title: 'Total',
                      value: total.toString(),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Total'),
                            GlobalTitleText(title: total.toString())
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: SizedBox(
                              height: 50,
                              child: RoundedRectangularButton(
                                title: 'CHECKOUT',
                                onPressed: () {
                                  GoRouter.of(context).pushNamed(
                                      AppRouteConstants.checkoutPage,
                                      pathParameters: {
                                        'totalAmount': total.toString()
                                      });
                                  GoRouter.of(context).pushNamed(
                                      AppRouteConstants.googleMapPage);
                                },
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return Container(
            height: 300,
            decoration: const BoxDecoration(
              boxShadow: [Constants.globalBoxBlur],
              color: AppPallete.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GlobalTitleText(title: '0 items'),
                  const BottomSheetRowText(title: 'Sub Total', value: '0'),
                  const Divider(),
                  const BottomSheetRowText(title: 'Total Shipping', value: '0'),
                  const Divider(),
                  const BottomSheetRowText(title: 'Total', value: '0'),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text('Total'), GlobalTitleText(title: '0')],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: SizedBox(
                            height: 50,
                            child: RoundedRectangularButton(
                              title: 'CHECKOUT',
                              onPressed: () {},
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BottomSheetRowText extends StatelessWidget {
  const BottomSheetRowText({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}

//if there is carted product in list of products then it will return true on the index of the product that means that the current product is carted

//then if that product is carted then it will return true at that index ....
