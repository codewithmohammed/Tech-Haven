part of 'cart_page_bloc.dart';

sealed class CartPageState extends Equatable {
  const CartPageState();

  @override
  List<Object> get props => [];
}

final class CartPageInitial extends CartPageState {}

final class CartPageLoadingState extends CartPageState {}

final class CartProductListViewState extends CartPageState {}

final class CartProductsListViewSuccess extends CartProductListViewState {
  final List<Product> listOfProducts;
  final List<String> listOFAllFavorites;
  CartProductsListViewSuccess(
      {required this.listOfProducts, required this.listOFAllFavorites});
}

final class CartProductsListViewLoading extends CartProductListViewState {
  CartProductsListViewLoading();
}

final class CartProductsListViewFailed extends CartProductListViewState {
  final String message;
  CartProductsListViewFailed({required this.message});
}

// final class BannerCarouselState extends CartPageState {}

// final class GetAllBannerSuccess extends BannerCarouselState {
//   final List<Banner> listOfBanners;
//   GetAllBannerSuccess({required this.listOfBanners});
// }

// final class GetAllBannerFailed extends BannerCarouselState {
//   final String message;
//   GetAllBannerFailed({required this.message});
// }

final class AddProductToCartState extends CartPageState {}

final class ProductAddedToCartSuccess extends AddProductToCartState {
  final bool addedSuccess;
  ProductAddedToCartSuccess({required this.addedSuccess});
}

final class ProductAddedToCartFailed extends AddProductToCartState {
  final String message;
  ProductAddedToCartFailed({required this.message});
}

final class UpdateProductToFavoriteState extends CartPageState {}

final class ProductUpdatedToFavoriteSuccess
    extends UpdateProductToFavoriteState {
  final bool updatedSuccess;
  ProductUpdatedToFavoriteSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToFavoriteFailed
    extends UpdateProductToFavoriteState {
  final String message;
  ProductUpdatedToFavoriteFailed({required this.message});
}

final class UpdateProductToCartState extends CartPageState {}

final class CartLoadedSuccessState extends UpdateProductToCartState {
  final List<Cart> listOfCart;
  CartLoadedSuccessState({required this.listOfCart});
}

final class CartUpdatedToCartLoading extends UpdateProductToCartState {}

final class CartLoadedFailedState extends UpdateProductToCartState {
  final String message;
  CartLoadedFailedState({required this.message});
}
