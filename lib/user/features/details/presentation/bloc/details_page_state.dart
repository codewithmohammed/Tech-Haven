part of 'details_page_bloc.dart';

sealed class DetailsPageState extends Equatable {
  const DetailsPageState();

  @override
  List<Object> get props => [];
}

final class DetailsPageInitial extends DetailsPageState {}

final class DetailsPageLoadingState extends DetailsPageState {}

final class DetailsGetAllCategoryImagesSuccessState extends DetailsPageState {
  final Map<int, List<Image>> mapOfListOfImages;
  const DetailsGetAllCategoryImagesSuccessState(
      {required this.mapOfListOfImages});
}

final class DetailsGetAllCategoryImagesFailedState extends DetailsPageState {
  final String message;
  const DetailsGetAllCategoryImagesFailedState({required this.message});
}

final class GetAllBrandRelatedProductsDetailsState extends DetailsPageState {}

final class GetAllBrandRelatedProductsDetailsSuccessState
    extends GetAllBrandRelatedProductsDetailsState {
  final List<Product> listOfBrandedProducts;
  GetAllBrandRelatedProductsDetailsSuccessState(
      {required this.listOfBrandedProducts});
}

final class GetAllBrandRelatedProductsDetailsLoading
    extends GetAllBrandRelatedProductsDetailsState {}

final class GetAllBrandRelatedProductsDetailsFailedState
    extends GetAllBrandRelatedProductsDetailsState {
  final String message;
  GetAllBrandRelatedProductsDetailsFailedState({required this.message});
}

final class GetAllImagesForProductState extends DetailsPageState {}

final class GetAllImagesForProductSuccess extends GetAllImagesForProductState {
  final Map<int, List<model.Image>> allImages;
  final int currentSelectedIndex;
  GetAllImagesForProductSuccess(
      {required this.allImages, required this.currentSelectedIndex});
}

final class GetAllImagesForProductLoading extends GetAllImagesForProductState {}

final class GetAllImagesForProductFailed extends GetAllImagesForProductState {
  final String message;
  GetAllImagesForProductFailed({required this.message});
}

final class CartLoadingDetailsState extends DetailsPageState {}

final class CartLoadedSuccessDetailsState extends CartLoadingDetailsState {
  final Cart cart;
  CartLoadedSuccessDetailsState({required this.cart});
}

final class CartLoadedFailedDetailsState extends CartLoadingDetailsState {
  final String message;
  CartLoadedFailedDetailsState({required this.message});
}

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

final class UpdateProductToCartDetailsState extends DetailsPageState {}

final class UpdateProductToCartDetailsSuccess
    extends UpdateProductToCartDetailsState {}

final class UpdateProductToCartDetailsFailed
    extends UpdateProductToCartDetailsState {
  final String message;
  UpdateProductToCartDetailsFailed({required this.message});
}
