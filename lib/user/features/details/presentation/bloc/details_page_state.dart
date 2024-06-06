part of 'details_page_bloc.dart';

sealed class DetailsPageState extends Equatable {
  const DetailsPageState();

  @override
  List<Object> get props => [];
}

final class DetailsPageInitial extends DetailsPageState {}

final class DetailsPageLoadingState extends DetailsPageState {}

final class GetAllImagesForProductState extends DetailsPageState {}



final class GetAllImagesForProductLoading extends GetAllImagesForProductState {}

final class GetAllImagesForProductSuccess extends GetAllImagesForProductState {
  final Map<int, List<model.Image>> allImages;
  final int currentSelectedIndex;
  GetAllImagesForProductSuccess(
      {required this.allImages, required this.currentSelectedIndex});
}

final class GetAllImagesForProductFailed extends GetAllImagesForProductState {
  final String message;
  GetAllImagesForProductFailed({required this.message});
}

final class CartDetailsState extends DetailsPageState {}

final class CartLoadedSuccessDetailsState extends CartDetailsState {
  final Cart cart;
  CartLoadedSuccessDetailsState({required this.cart});
}

final class CartLoadedFailedDetailsState extends CartDetailsState {
  final String message;
  CartLoadedFailedDetailsState({required this.message});
}

final class UpdateProductToCartDetailsSuccess
    extends CartDetailsState {}

final class UpdateProductToCartDetailsFailed
    extends CartDetailsState {
  final String message;
  UpdateProductToCartDetailsFailed({required this.message});
}


//for getting and updating whether the the product is favorited or not

final class GetProductFavoritedDetailsState extends DetailsPageState {}

final class UpdateProductToFavoriteSuccess
    extends GetProductFavoritedDetailsState {}

final class UpdateProductToFavoriteFailed
    extends GetProductFavoritedDetailsState {
  final String message;
  UpdateProductToFavoriteFailed({required this.message});
}

final class GetProductFavoritedDetailsSuccess
    extends GetProductFavoritedDetailsState {
  final List<String> favorited;
  GetProductFavoritedDetailsSuccess({required this.favorited});
}

final class GetProductFavoritedDetailsFailed
    extends GetProductFavoritedDetailsState {
  final String message;
  GetProductFavoritedDetailsFailed({required this.message});
}

//get  related products

final class DetailsPageRelatedProductsState extends DetailsPageState {}

// //for getting all the brand related products

final class GetAllBrandRelatedProductsDetailsState
    extends DetailsPageRelatedProductsState {}

final class GetAllBrandRelatedProductsDetailsSuccessState
    extends GetAllBrandRelatedProductsDetailsState {
  final List<Product> listOfBrandedProducts;
  final List<String> listOfFavoritedProducts;
  GetAllBrandRelatedProductsDetailsSuccessState(
      {required this.listOfBrandedProducts,
      required this.listOfFavoritedProducts});
}

final class GetAllBrandRelatedProductsDetailsLoading
    extends GetAllBrandRelatedProductsDetailsState {}

final class GetAllBrandRelatedProductsDetailsFailedState
    extends GetAllBrandRelatedProductsDetailsState {
  final String message;
  GetAllBrandRelatedProductsDetailsFailedState({required this.message});
}

//for getting all the cart related of the brand related product.

final class ProductCartDetailsPageRelatedState
    extends DetailsPageRelatedProductsState {}

//for related products cart loading

final class CartLoadingDetailsPageRelatedState
    extends ProductCartDetailsPageRelatedState {}

final class CartLoadedSuccessDetailsPageRelatedState
    extends ProductCartDetailsPageRelatedState {
  final List<Cart> listOfCart;
  CartLoadedSuccessDetailsPageRelatedState({required this.listOfCart});
}

final class CartLoadedFailedDetailsPageRelatedState
    extends ProductCartDetailsPageRelatedState {
  final String message;
  CartLoadedFailedDetailsPageRelatedState({required this.message});
}

//for related products cart updation

final class ProductUpdatedToCartDetailsPageRelatedSuccess
    extends ProductCartDetailsPageRelatedState {
  final bool updatedSuccess;
  ProductUpdatedToCartDetailsPageRelatedSuccess({required this.updatedSuccess});
}

final class ProductUpdatedToCartDetailsPageRelatedFailed
    extends ProductCartDetailsPageRelatedState {
  final String message;
  ProductUpdatedToCartDetailsPageRelatedFailed({required this.message});
}

//for related products favorites

final class UpdateProductToFavoriteState
    extends DetailsPageRelatedProductsState {}

final class ProductUpdatedToFavoriteDetailsPageRelatedSuccess
    extends UpdateProductToFavoriteState {
  final bool updatedSuccess;
  ProductUpdatedToFavoriteDetailsPageRelatedSuccess(
      {required this.updatedSuccess});
}

final class ProductUpdatedToFavoriteDetailsPageRelatedFailed
    extends UpdateProductToFavoriteState {
  final String message;
  ProductUpdatedToFavoriteDetailsPageRelatedFailed({required this.message});
}
