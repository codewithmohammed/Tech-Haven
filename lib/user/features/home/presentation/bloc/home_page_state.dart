part of 'home_page_bloc.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

final class HomePageInitial extends HomePageState {}

final class HomePageLoadingState extends HomePageState {}

final class HorizontalProductListViewState extends HomePageState {}

final class HorizontalProductsListViewHomeSuccess
    extends HorizontalProductListViewState {
  final List<Product> listOfProducts;
  final List<String> listOfFavoritedProducts;

  HorizontalProductsListViewHomeSuccess({
    required this.listOfProducts,
    required this.listOfFavoritedProducts,
  });
}

final class HorizontalProductsListViewHomeFailed
    extends HorizontalProductListViewState {
  final String message;
  HorizontalProductsListViewHomeFailed({required this.message});
}

final class BannerCarouselState extends HomePageState {}

final class GetAllBannerHomeSuccess extends BannerCarouselState {
  final List<Banner> listOfBanners;
  GetAllBannerHomeSuccess({required this.listOfBanners});
}

final class GetAllBannerHomeFailed extends BannerCarouselState {
  final String message;
  GetAllBannerHomeFailed({required this.message});
}

final class ProductCartHomeState extends HomePageState {}

final class CartLoadingHomeState extends ProductCartHomeState{}

final class CartLoadedSuccessHomeState extends ProductCartHomeState {
  final List<Cart> listOfCart;
  CartLoadedSuccessHomeState({required this.listOfCart});
}

final class CartLoadedFailedHomeState extends ProductCartHomeState {
  final String message;
  CartLoadedFailedHomeState({required this.message});
}

final class ProductUpdatedToCartHomeSuccess extends ProductCartHomeState {
  final bool updatedSuccess;
  ProductUpdatedToCartHomeSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToCartHomeFailed extends ProductCartHomeState {
  final String message;
  ProductUpdatedToCartHomeFailed({required this.message});
}

final class UpdateProductToFavoriteState extends HomePageState {}

final class ProductUpdatedToFavoriteHomeSuccess
    extends UpdateProductToFavoriteState {
  final bool updatedSuccess;
  ProductUpdatedToFavoriteHomeSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToFavoriteHomeFailed
    extends UpdateProductToFavoriteState {
  final String message;
  ProductUpdatedToFavoriteHomeFailed({required this.message});
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

