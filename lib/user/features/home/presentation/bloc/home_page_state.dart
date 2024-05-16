part of 'home_page_bloc.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

final class HomePageInitial extends HomePageState {}

final class HomePageLoadingState extends HomePageState {}

final class HorizontalProductListViewState extends HomePageState {}

final class HorizontalProductsListViewSuccess
    extends HorizontalProductListViewState {
  final List<Product> listOfProducts;
  final List<String> listOfFavoritedProducts;

  HorizontalProductsListViewSuccess({
    required this.listOfProducts,
    required this.listOfFavoritedProducts,
  });
}

final class HorizontalProductsListViewFailed
    extends HorizontalProductListViewState {
  final String message;
  HorizontalProductsListViewFailed({required this.message});
}

final class BannerCarouselState extends HomePageState {}

final class GetAllBannerSuccess extends BannerCarouselState {
  final List<Banner> listOfBanners;
  GetAllBannerSuccess({required this.listOfBanners});
}

final class GetAllBannerFailed extends BannerCarouselState {
  final String message;
  GetAllBannerFailed({required this.message});
}

final class ProductCartState extends HomePageState {}

final class CartLoadingState extends ProductCartState{}

final class CartLoadedSuccessState extends ProductCartState {
  final List<Cart> listOfCart;
  CartLoadedSuccessState({required this.listOfCart});
}

final class CartLoadedFailedState extends ProductCartState {
  final String message;
  CartLoadedFailedState({required this.message});
}

final class ProductUpdatedToCartSuccess extends ProductCartState {
  final bool updatedSuccess;
  ProductUpdatedToCartSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToCartFailed extends ProductCartState {
  final String message;
  ProductUpdatedToCartFailed({required this.message});
}

final class UpdateProductToFavoriteState extends HomePageState {}

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

// final class ProductCartState extends HomePageState {}



// final class ProductUpdatedToCartLoading extends UpdateProductToCartState {}

// final class CartLoadedFailedState extends UpdateProductToCartState {
//   final String message;
//   CartLoadedFailedState({required this.message});
// }













final class GetAllSubCategoriesState extends HomePageState {}

final class GetAllSubCategoriesSuccessState extends GetAllSubCategoriesState {
  final List<Category> listOfSubCategories;
  GetAllSubCategoriesSuccessState({required this.listOfSubCategories});
}

final class GetAllSubCategoriesFailedState extends GetAllSubCategoriesState {
  final String message;
  GetAllSubCategoriesFailedState({required this.message});
}

final class GetAllSubCategoriesLoadingState extends GetAllSubCategoriesState {
}

