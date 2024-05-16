import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/rectangular_product_card.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/title_with_count_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartPageBloc>().add(GetAllProductsEvent());
    context.read<CartPageBloc>().add(GetAllCartEvent());
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
            child:  Row(
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
                // if()
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
                        controllers[cartIndex].text = listState
                            .listOfCarts[cartIndex].productCount
                            .toString();
                      }
                      return RectangularProductCard(
                        isFavorite: listState.listOfFavorites
                            .contains(currentProduct.productID),
                        // items: const [],
                        isLoading: false,
                        onTap: () {},
                        onTapFavouriteButton: (bool isLiked) async {
                          return null;
                        },
                        onTapRemoveButton: () {
                          context.read<CartPageBloc>().add(
                                UpdateProductToCartEvent(
                                  itemCount: 0,
                                  product: currentProduct,
                                  cart: listState.listOfCarts[cartIndex],
                                ),
                              );
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
                              int.parse(controllers[cartIndex].text);
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
                                content: 'insufficient Amount',
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
    );
  }

  double calculateTotalPrize(
      {required List<Product> products, required List<Cart> carts}) {
    double sum = 0;
    for (var product in products) {
      final cartIndex =
          checkCurrentProductIsCarted(product: product, carts: carts);
      sum += product.prize * carts[cartIndex].productCount;
    }
    return sum;
  }

  calculateTotalQuantity({required List<Cart> listOfCarts}) {
    int quantity = 0;
    for (var cart in listOfCarts) {
      quantity += cart.productCount;
    }
    return quantity;
  }
}

//if there is carted product in list of products then it will return true on the index of the product that means that the current product is carted

//then if that product is carted then it will return true at that index ....
