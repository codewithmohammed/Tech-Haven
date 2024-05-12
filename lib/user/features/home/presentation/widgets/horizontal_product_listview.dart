import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/shopping_cart_button.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/product_card.dart';
// import 'package:shimmer/shimmer.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    void updateProductToFavorite(Product product, bool isLiked) {
      // print('updating the favorite');
      context.read<HomePageBloc>().add(
            UpdateProductToFavoriteEvent(
              product: product,
              isFavorited: !isLiked,
            ),
          );
    }

    void updateProductToCart(
        {required Product product,
        required Cart? cart,
        required int itemCount}) {
      context.read<HomePageBloc>().add(
            UpdateProductToCartEvent(
              product: product,
              itemCount: itemCount,
              cart: cart,
            ),
          );
    }

    return Container(
      height: 360,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: GlobalTitleText(
              title: 'Recommended for you',
            ),
          ),
          //container for the whole
          SizedBox(
            height: 325,
            child: BlocConsumer<HomePageBloc, HomePageState>(
              buildWhen: (previous, current) =>
                  current is HorizontalProductListViewState,
              listener: (context, state) {
                if (state is HorizontalProductsListViewFailed) {
                  return showSnackBar(
                      context: context,
                      title: 'Oh',
                      content: state.message,
                      contentType: ContentType.failure);
                }
              },
              builder: (context, listState) {
                if (listState is HorizontalProductsListViewSuccess) {
                  // print('object');
                  return ListView.builder(
                    // physics: const BouncingScrollPhysics(),
                    scrollDirection:
                        Axis.horizontal, // Set scroll direction to horizontal
                    itemCount: listState.listOfProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final currentProduct = listState.listOfProducts[index];
                      //column since the container is divided into two
                      return ProductCard(
                        index: index,
                        isFavorited: listState.listOfFavoritedProducts
                            .contains(currentProduct.productID),
                        // index: index,
                        isHorizontal: true,
                        product: currentProduct,
                        onTapFavouriteButton: (bool isLiked) async {
                          updateProductToFavorite(currentProduct, isLiked);
                          return isLiked ? false : true;
                        },
                        shoppingCartWidget:
                            BlocBuilder<HomePageBloc, HomePageState>(
                          buildWhen: (previous, current) =>
                              current is UpdateProductToCartState,
                          builder: (context, cartState) {
                            // print(cartState is CartLoadedSuccessState);
                            if (cartState is CartLoadedSuccessState) {
                              final productIsCarted =
                                  checkCurrentProductIsCarted(
                                      product: listState.listOfProducts[index],
                                      carts: cartState.listOfCart);
                              // print(productIsCarted);
                              print(productIsCarted);

                              return ShoppingCartButton(
                                onTapPlusButton: () {
                                  //if the product is already carted and the current cartedcount is less than the total quantity of the product
                                  if (productIsCarted &&
                                      cartState
                                              .listOfCart[index].productCount <=
                                          currentProduct.quantity) {
                                    updateProductToCart(
                                      product: currentProduct,
                                      cart: cartState.listOfCart[index],
                                      itemCount: cartState
                                              .listOfCart[index].productCount +
                                          1,
                                    );
                                    //if the product is not carted yet . then we increase it by one
                                  } else if (!productIsCarted) {
                                    updateProductToCart(
                                      product: currentProduct,
                                      cart: null,
                                      itemCount: 1,
                                    );
                                  }
                                },
                                onTapMinusButton: () {
                                  //if the product is cared and the carted product count-1 is greater than 0 then we decrease by one
                                  //carted already means there is one product in the cart
                                  if (productIsCarted &&
                                      cartState.listOfCart[index].productCount -
                                              1 >=
                                          0) {
                                    // print('object');
                                    updateProductToCart(
                                      product: currentProduct,
                                      cart: cartState.listOfCart[index],
                                      itemCount: cartState
                                              .listOfCart[index].productCount -
                                          1,
                                    );
                                  }
                                  //if there is no product carted and the user clicks '-' then we show a
                                  if (!productIsCarted) {}
                                },
                                onTapCartButton: () {},
                                currentCount: productIsCarted
                                    ? cartState.listOfCart[index].productCount
                                    : 0,
                                isLoading: false,
                              );
                            }
                            // if (cartState is CartLoadedSuccesscartState) {
                            //   print(cartState.listOfCart[index].productCount);
                            // }
                            return ShoppingCartButton(
                              currentCount: 0,
                              isLoading:
                                  cartState is ProductUpdatedToCartLoading
                                      ? true
                                      : false,
                            );
                          },
                        ),
                      );
                    },
                  );
                }
                return ListView.builder(
                  // physics: const BouncingScrollPhysics(),
                  scrollDirection:
                      Axis.horizontal, // Set scroll direction to horizontal
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    //column since the container is divided into two
                    return ProductCard(
                      index: index,
                      isFavorited: false,
                      // index: index,
                      isHorizontal: true,
                      product: null,
                      onTapFavouriteButton: (bool isLiked) async {
                        return false;
                      },
                      shoppingCartWidget: ShoppingCartButton(
                        onTapPlusButton: () {},
                        onTapMinusButton: () {},
                        onTapCartButton: () {},
                        currentCount: 10,
                        isLoading: false,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool checkCurrentProductIsCarted(
      {required Product product, required List<Cart> carts}) {
    for (var cart in carts) {
      // Check if the product ID in the cart exists in the list of products
      if (product.productID == cart.productID) {
        return true;
      }
    }
    return false;
  }
}
