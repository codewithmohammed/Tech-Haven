import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/common/widgets/rectangular_product_card.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/cart_page_bottom_container.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/title_with_count_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartPageBloc>().add(GetAllProductsEvent());
    });

    final ValueNotifier<bool> showBottomContainer = ValueNotifier(false);

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

    List<TextEditingController> controllers = [];
    void generateTextEditingController(int length) {
      for (int i = 0; i < length; i++) {
        controllers.add(TextEditingController());
      }
    }

    return Scaffold(
      appBar: const AppBarSearchBar(),
      body: Stack(
        children: [
          Column(
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
                          return listState.listOfCarts.isNotEmpty
                              ? TitleWithCountBar(
                                  title: 'Cart',
                                  itemsCount:
                                      '${calculateTotalQuantity(listOfCarts: listState.listOfCarts)} Items',
                                  totalPrize: calculateTotalPrize(
                                    products: listState.listOfProducts,
                                    carts: listState.listOfCarts,
                                  ).toString(),
                                )
                              : const Center(
                                  child: Text('Your Cart is Empty'),
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
                      Fluttertoast.showToast(
                          msg: 'The Cart Updated Successfully');
                      context.read<CartPageBloc>().add(GetAllProductsEvent());
                    }

                    if (state is ProductUpdatedToFavoriteCartSuccess) {
                      Fluttertoast.showToast(
                          msg: 'The Favorite Updated Successfully');
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
                          final currentProduct =
                              listState.listOfProducts[index];
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
                              final newCount =
                                  int.parse(controllers[index].text);
                              if (currentProduct.quantity >= newCount &&
                                  newCount > 0) {
                                if (productIsCarted) {
                                  context.read<CartPageBloc>().add(
                                        UpdateProductToCartEvent(
                                          itemCount: newCount,
                                          product: currentProduct,
                                          cart:
                                              listState.listOfCarts[cartIndex],
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
          ValueListenableBuilder(
              valueListenable: showBottomContainer,
              builder: (context, value, child) {
                return !showBottomContainer.value
                    ? Positioned(
                        bottom: 100,
                        right: 10,
                        child: Container(
                          height: 35,
                          width: 180,
                          color: Colors.white,
                          child: PrimaryAppButton(
                            onPressed: () {
                              showBottomContainer.value = true;
                            },
                            buttonText: 'CHECKOUT',
                          ),
                        ),
                      )
                    : const SizedBox();
              }),
        ],
      ),
      // floatingActionButton:
      bottomNavigationBar: BlocBuilder<CartPageBloc, CartPageState>(
        buildWhen: (previous, current) => current is CartProductListViewState,
        builder: (context, listState) {
          return ValueListenableBuilder<bool>(
            valueListenable: showBottomContainer,
            builder: (context, value, child) {
              if (value && listState is CartProductsListViewSuccess) {
                final double subTotal = calculateTotalPrize(
                  products: listState.listOfProducts,
                  carts: listState.listOfCarts,
                );

                final double totalShpping = calculateTotalShipping(
                  products: listState.listOfProducts,
                  carts: listState.listOfCarts,
                );

                final double total = subTotal + totalShpping;
                return total > 0
                    ? Stack(
                        children: [
                          CartPageBottomContainer(
                              listOfCart: listState.listOfCarts,
                              subTotal: subTotal,
                              totalShpping: totalShpping,
                              total: total),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: CircularButton(
                                onPressed: () {
                                  showBottomContainer.value = false;
                                },
                                circularButtonChild: const SvgIcon(
                                    icon: CustomIcons.angleDownSvg, radius: 16),
                                diameter: 35),
                          )
                        ],
                      )
                    : const SizedBox();
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
