import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/product_card.dart';
import 'package:tech_haven/core/common/widgets/shopping_cart_button.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';

class DetailsGridViewListWidget extends StatelessWidget {
  const DetailsGridViewListWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    void updateProductToFavorite(Product product, bool isLiked) {
      // print('updating the favorite');
      context.read<DetailsPageBloc>().add(
            UpdateProductToFavoriteBrandRelatedDetailsEvent(
              product: product,
              isFavorited: !isLiked,
            ),
          );
    }

    void updateProductToCart(
        {required Product product,
        required Cart? cart,
        required int itemCount}) {
      context.read<DetailsPageBloc>().add(
            UpdateProductToCartBrandRelatedDetailsEvent(
              product: product,
              itemCount: itemCount,
              cart: cart,
            ),
          );
    }

    return BlocConsumer<DetailsPageBloc, DetailsPageState>(
      listener: (context, state) {
        if (state is ProductUpdatedToCartDetailsPageRelatedSuccess) {
          context
              .read<DetailsPageBloc>()
              .add(const GetAllBrandRelatedCartDetailsEvent());
        }
        if (state is GetAllBrandRelatedProductsDetailsSuccessState) {
          context
              .read<DetailsPageBloc>()
              .add(const GetAllBrandRelatedCartDetailsEvent());
        }
      },
      buildWhen: (previous, current) =>
          current is GetAllBrandRelatedProductsDetailsState,
      builder: (context, productState) {
        if (productState is GetAllBrandRelatedProductsDetailsSuccessState) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              mainAxisExtent: 300,
            ),
            itemCount: productState.listOfBrandedProducts.length,
            itemBuilder: (context, index) {
              final currentProduct = productState.listOfBrandedProducts[index];
              return ProductCard(
                onTapCard: () {
                  GoRouter.of(context).pushNamed(AppRouteConstants.detailsPage,
                      extra: currentProduct);
                },
                isHorizontal: false,
                product: productState.listOfBrandedProducts[index],
                onTapFavouriteButton: (bool isLiked) async {
                  updateProductToFavorite(
                      productState.listOfBrandedProducts[index], isLiked);
                  return isLiked ? false : true;
                },
                isFavorited: productState.listOfFavoritedProducts.contains(
                    productState.listOfBrandedProducts[index].productID),
                shoppingCartWidget:
                    BlocBuilder<DetailsPageBloc, DetailsPageState>(
                  buildWhen: (previous, current) =>
                      current is ProductCartDetailsPageRelatedState,
                  builder: (context, cartState) {
                    // print(cartState);
                    if (cartState is CartLoadedSuccessDetailsPageRelatedState) {
                      bool productIsCarted = false;
                      final cartIndex = checkCurrentProductIsCarted(
                          product: productState.listOfBrandedProducts[index],
                          carts: cartState.listOfCart);

                      if (cartIndex > -1) {
                        productIsCarted = true;
                      }

                      // print(productIsCarted);

                      return ShoppingCartButton(
                        onTapPlusButton: () {
                          // print((productIsCarted &&
                          //     cartState.listOfCart[index].productCount <=
                          //         currentProduct.quantity));
                          if (productIsCarted &&
                              cartState.listOfCart[index].productCount <=
                                  currentProduct.quantity) {
                            updateProductToCart(
                              product: currentProduct,
                              cart: cartState.listOfCart[cartIndex],
                              itemCount:
                                  cartState.listOfCart[cartIndex].productCount +
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
                          if (productIsCarted &&
                              cartState.listOfCart[cartIndex].productCount -
                                      1 >=
                                  0) {
                            updateProductToCart(
                              product: currentProduct,
                              cart: cartState.listOfCart[cartIndex],
                              itemCount:
                                  cartState.listOfCart[cartIndex].productCount -
                                      1,
                            );
                          }
                          //if there is no product carted and the user clicks '-' then we show a
                          if (!productIsCarted) {
                            Fluttertoast.showToast(
                              msg: 'Add Product To Cart First',
                            );
                          }
                        },
                        onTapCartButton: () {},
                        currentCount: productIsCarted
                            ? cartState.listOfCart[cartIndex].productCount
                            : 0,
                        isLoading: false,
                      );
                    }
                    return const ShoppingCartButton(
                      currentCount: 0,
                      isLoading: true,
                    );
                  },
                ),
              );
            },
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            mainAxisExtent: 300,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ProductCard(
              isHorizontal: false,
              product: null,
              onTapFavouriteButton: (bool) async {
                return null;
              },
              isFavorited: false,
              shoppingCartWidget: ShoppingCartButton(
                onTapPlusButton: () {},
                onTapMinusButton: () {},
                onTapCartButton: () {},
                currentCount: 0,
                isLoading: false,
              ),
            );
          },
        );
      },
    );
  }
}
