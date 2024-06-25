import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/custom_like_button.dart';
import 'package:tech_haven/core/common/widgets/shopping_cart_button.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/deals_product_card.dart';

import '../../../../../core/theme/app_pallete.dart';

class DealsGridView extends StatelessWidget {
  const DealsGridView({
    super.key,
  });

  void updateProductToFavorite(
      BuildContext context, Product product, bool isLiked) {
    context.read<HomePageBloc>().add(
          UpdateProductToFavoriteHomeEvent(
            product: product,
            isFavorited: !isLiked,
          ),
        );
  }

  void updateProductToCart(BuildContext context,
      {required Product product, required Cart? cart, required int itemCount}) {
    context.read<HomePageBloc>().add(
          UpdateProductToCartHomeEvent(
            product: product,
            itemCount: itemCount,
            cart: cart,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 670,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Row(
                  children: [
                    Text(
                      'MEGA DEALS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '24 HOURS ONLY',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
                width: 125,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.blackColor,
                    foregroundColor: AppPallete.whiteColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'VIEW ALL',
                    style: TextStyle(
                      color: AppPallete.whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
          // Container for the product card
          Container(
            height: 600,
            margin: const EdgeInsets.only(top: 20),
            child: BlocConsumer<HomePageBloc, HomePageState>(
              buildWhen: (previous, current) =>
                  current is HorizontalProductListViewState,
              listener: (context, state) {
                if (state is HorizontalProductsListViewHomeFailed) {
                  return showSnackBar(
                      context: context,
                      title: 'Oh',
                      content: state.message,
                      contentType: ContentType.failure);
                }

                if (state is CartLoadedFailedHomeState) {
                  showSnackBar(
                      context: context,
                      title: 'Oh',
                      content: state.message,
                      contentType: ContentType.failure);

                  context.read<HomePageBloc>().add(GetAllCartHomeEvent());
                }
                if (state is ProductUpdatedToCartHomeSuccess) {
                  Fluttertoast.showToast(
                      msg: "The Cart is Updated Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  context.read<HomePageBloc>().add(GetAllCartHomeEvent());
                }
                if (state is ProductUpdatedToCartHomeFailed) {
                  Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  context.read<HomePageBloc>().add(GetAllCartHomeEvent());
                }
                if (state is ProductUpdatedToFavoriteHomeSuccess) {
                  Fluttertoast.showToast(
                      msg: "The Favorites is Updated Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                if (state is ProductUpdatedToFavoriteHomeFailed) {
                  Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              builder: (context, listState) {
                if (listState is HorizontalProductsListViewHomeSuccess) {
                  return GridView.builder(
                    itemCount: listState.listOfProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 1 / 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      maxCrossAxisExtent: 300,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final currentProduct = listState.listOfProducts[index];
                      return DealsProductCard(
                        likeButton: CustomLikeButton(
                          isFavorited: listState.listOfFavoritedProducts
                              .contains(currentProduct.productID),
                          onTapFavouriteButton: (bool isLiked) async {
                            updateProductToFavorite(context,
                                listState.listOfProducts[index], isLiked);
                            return isLiked ? false : true;
                          },
                        ),
                        onTapCard: () {
                          GoRouter.of(context).pushNamed(
                              AppRouteConstants.detailsPage,
                              extra: currentProduct);
                        },
                        isHorizontal: true,
                        product: currentProduct,
                        shoppingCartWidget:
                            BlocBuilder<HomePageBloc, HomePageState>(
                          buildWhen: (previous, current) =>
                              current is ProductCartHomeState,
                          builder: (context, cartState) {
                            if (cartState is CartLoadedSuccessHomeState) {
                              bool productIsCarted = false;
                              final cartIndex = checkCurrentProductIsCarted(
                                  product: listState.listOfProducts[index],
                                  carts: cartState.listOfCart);

                              if (cartIndex > -1) {
                                productIsCarted = true;
                              }

                              return ShoppingCartButton(
                                onTapPlusButton: () {
                                  if (productIsCarted &&
                                      cartState.listOfCart[cartIndex]
                                              .productCount <=
                                          currentProduct.quantity) {
                                    updateProductToCart(
                                      context,
                                      product: currentProduct,
                                      cart: cartState.listOfCart[cartIndex],
                                      itemCount: cartState.listOfCart[cartIndex]
                                              .productCount +
                                          1,
                                    );
                                  } else if (!productIsCarted) {
                                    updateProductToCart(
                                      context,
                                      product: currentProduct,
                                      cart: null,
                                      itemCount: 1,
                                    );
                                  }
                                },
                                onTapMinusButton: () {
                                  if (productIsCarted &&
                                      cartState.listOfCart[cartIndex]
                                                  .productCount -
                                              1 >=
                                          0) {
                                    updateProductToCart(
                                      context,
                                      product: currentProduct,
                                      cart: cartState.listOfCart[cartIndex],
                                      itemCount: cartState.listOfCart[cartIndex]
                                              .productCount -
                                          1,
                                    );
                                  }
                                  if (!productIsCarted) {
                                    Fluttertoast.showToast(
                                      msg: 'Add Product To Cart First',
                                    );
                                  }
                                },
                                onTapCartButton: () {},
                                currentCount: productIsCarted
                                    ? cartState
                                        .listOfCart[cartIndex].productCount
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
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 1 / 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    maxCrossAxisExtent: 300,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return DealsProductCard(
                      likeButton: CustomLikeButton(
                        isFavorited: false,
                        onTapFavouriteButton: (bool isLiked) async {
                          return isLiked ? false : true;
                        },
                      ),
                      isHorizontal: true,
                      product: null,
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
}
