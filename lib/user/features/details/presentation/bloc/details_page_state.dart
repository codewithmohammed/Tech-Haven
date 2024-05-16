part of 'details_page_bloc.dart';

sealed class DetailsPageState extends Equatable {
  const DetailsPageState();

  @override
  List<Object> get props => [];
}

final class DetailsPageInitial extends DetailsPageState {}

final class DetailsPageLoadingState extends DetailsPageState {}

// final class DetailsGetAllCategoryImagesSuccessState extends DetailsPageState {
//   final Map<int, List<Image>> mapOfListOfImages;
//   const DetailsGetAllCategoryImagesSuccessState({required this.mapOfListOfImages});
// }

// final class DetailsGetAllCategoryImagesFailedState extends DetailsPageState {
//   final String message;
//   const DetailsGetAllCategoryImagesFailedState({required this.message});
// }

final class GetAllBrandRelatedProductsState extends DetailsPageState {}

final class GetAllBrandRelatedProductsSuccessState
    extends GetAllBrandRelatedProductsState {
  final List<Product> listOfBrandedProducts;
  GetAllBrandRelatedProductsSuccessState({required this.listOfBrandedProducts});
}

final class GetAllBrandRelatedProductsLoading
    extends GetAllBrandRelatedProductsState {}

final class GetAllBrandRelatedProductsFailedState
    extends GetAllBrandRelatedProductsState {
  final String message;
  GetAllBrandRelatedProductsFailedState({required this.message});
}

final class GetAllImagesForProductState extends DetailsPageState {}

final class GetAllImagesForProductSuccess extends GetAllImagesForProductState {
 final Map<int, List<model.Image>> allImages;
  GetAllImagesForProductSuccess({required this.allImages});
}

final class GetAllImagesForProductLoading extends GetAllImagesForProductState {}

final class GetAllImagesForProductFailed extends GetAllImagesForProductState {
  final String message;
  GetAllImagesForProductFailed({required this.message});
}
