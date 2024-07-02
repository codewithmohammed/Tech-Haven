import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/custom_like_button.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/product_card.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/user/features/search/presentation/bloc/search_page_bloc.dart';
// import '../bloc/product_search_bloc.dart';
// import '../bloc/product_search_event.dart';
// import '../bloc/product_search_state.dart';
// import '../../core/common/widgets/appbar_searchbar.dart';
// import '../../domain/entities/product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    context.read<SearchPageBloc>().add(const SearchProductsEvent(''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void updateProductToFavorite(Product product, bool isLiked) {
      // print('updating the favorite');
      context.read<SearchPageBloc>().add(
            UpdateProductToFavoriteSearchPageEvent(
              product: product,
              isFavorited: !isLiked,
            ),
          );
    }

    // void updateProductToCart(
    //     {required Product product,
    //     required Cart? cart,
    //     required int itemCount}) {
    //   context.read<SearchPageBloc>().add(
    //         UpdateProductToCartSearchPageEvent(
    //           product: product,
    //           itemCount: itemCount,
    //           cart: cart,
    //         ),
    //       );
    // }

    // context.read<SearchPageBloc>().add(const SearchProductsEvent(null,));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: AppBarSearchBar(
          backButton: true,
          favouriteIconNeeded: false,
          deliveryPlaceNeeded: false,
          enabled: true,
          onChanged: (query) {
            context.read<SearchPageBloc>().add(SearchProductsEvent(
                  query,
                ));
          },
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<SearchPageBloc, SearchPageState>(
          buildWhen: (previous, current) => current is GetProductsState,
          builder: (context, state) {
            if (state is ProductSearchError) {
              return Center(child: Text(state.message));
            } else if (state is ProductSearchLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisExtent: 300,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final currentProduct = state.products[index];
                  return state.products.isNotEmpty
                      ? ProductCard(
                          onTapCard: () {
                            GoRouter.of(context).pushNamed(
                                AppRouteConstants.detailsPage,
                                extra: currentProduct);
                          },
                          likeButton: CustomLikeButton(
                            isFavorited: state.listOfFavoritedProducts
                                .contains(currentProduct.productID),
                            onTapFavouriteButton: (bool isLiked) async {
                              updateProductToFavorite(currentProduct, isLiked);
                              return isLiked ? false : true;
                            },
                          ),
                          isHorizontal: false,
                          product: state.products[index],
                          // onTapFavouriteButton:
                          // isFavorited:
                          shoppingCartWidget: Container()
                          //     BlocBuilder<SearchPageBloc, SearchPageState>(
                          //   buildWhen: (previous, current) =>
                          //       current is ProductCartProductsState,
                          //   builder: (context, cartState) {
                          //     if (cartState is CartLoadedSuccessProductsState) {
                          //       ///if index =  0, then it will return -1 if the product is not carted
                          //       ///if index = 1, then it will return -1
                          //       ///if index = 2 , then it will return -1
                          //       ///
                          //       ///if there is product it will return the cart index

                          //       // final Product product =
                          //       //     listState.listOfProducts[index];
                          //       // final Cart cart = cartState.listOfCart.firstWhere(
                          //       //   (cart) => cart.productID == product.productID,
                          //       // );
                          //       bool productIsCarted = false;
                          //       final cartIndex = checkCurrentProductIsCarted(
                          //           product: state.products[index],
                          //           carts: cartState.listOfCart);

                          //       if (cartIndex > -1) {
                          //         productIsCarted = true;
                          //       }
                          //       return ShoppingCartButton(
                          //         onTapPlusButton: () {
                          //           if (productIsCarted &&
                          //               cartState.listOfCart[cartIndex]
                          //                       .productCount <=
                          //                   currentProduct.quantity) {
                          //             updateProductToCart(
                          //               product: currentProduct,
                          //               cart: cartState.listOfCart[cartIndex],
                          //               itemCount: cartState
                          //                       .listOfCart[cartIndex]
                          //                       .productCount +
                          //                   1,
                          //             );
                          //             //if the product is not carted yet . then we increase it by one
                          //           } else if (!productIsCarted) {
                          //             updateProductToCart(
                          //               product: currentProduct,
                          //               cart: null,
                          //               itemCount: 1,
                          //             );
                          //           }
                          //         },
                          //         onTapMinusButton: () {
                          //           if (productIsCarted &&
                          //               cartState.listOfCart[cartIndex]
                          //                           .productCount -
                          //                       1 >=
                          //                   0) {
                          //             updateProductToCart(
                          //               product: currentProduct,
                          //               cart: cartState.listOfCart[cartIndex],
                          //               itemCount: cartState
                          //                       .listOfCart[cartIndex]
                          //                       .productCount -
                          //                   1,
                          //             );
                          //           }
                          //           //if there is no product carted and the user clicks '-' then we show a
                          //           if (!productIsCarted) {
                          //             Fluttertoast.showToast(
                          //               msg: 'Add Product To Cart First',
                          //             );
                          //           }
                          //         },
                          //         onTapCartButton: () {},
                          //         currentCount: productIsCarted
                          //             ? cartState
                          //                 .listOfCart[cartIndex].productCount
                          //             : 0,
                          //         isLoading: false,
                          //       );
                          //     }
                          //     return const ShoppingCartButton(
                          //       currentCount: 0,
                          //       isLoading: true,
                          //     );
                          //   },
                          // ),
                          )
                      : const Center(
                          child: Text(
                            'No Data Found',
                          ),
                        );
                },
              );
              //   ListView.builder(
              //     itemCount: state.products.length,
              //     itemBuilder: (context, index) {
              //       final product = state.products[index];
              //       return ListTile(
              //         title: Text(product.name),
              //         subtitle: Text(product.overview),
              //       );
              //     },
              //   );
            }
            return const Loader();
          },
        ),
      ),
    );
  }
}
