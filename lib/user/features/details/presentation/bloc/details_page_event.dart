part of 'details_page_bloc.dart';

sealed class DetailsPageEvent extends Equatable {
  const DetailsPageEvent();

  @override
  List<Object> get props => [];
}

final class GetAllImagesForProductEvent extends DetailsPageEvent {
  final String productID;
  const GetAllImagesForProductEvent({required this.productID});
}

final class EmitInitial extends DetailsPageEvent {}

final class ChangeProductColorEvent extends DetailsPageEvent {
  final int index;
  const ChangeProductColorEvent({required this.index});
}

final class GetProductCartDetailsEvent extends DetailsPageEvent {
  final String productID;
  const GetProductCartDetailsEvent({required this.productID});
}

final class GetProductFavoriteDetailsEvent extends DetailsPageEvent {}

final class UpdateProductToFavoriteDetailsEvent extends DetailsPageEvent {
  final bool isFavorited;
  final Product product;

  const UpdateProductToFavoriteDetailsEvent(
      {required this.product, required this.isFavorited});
}

final class UpdateProductToCartDetailsEvent extends DetailsPageEvent {
  final int itemCount;
  final Product product;
  final Cart? cart;
  const UpdateProductToCartDetailsEvent(
      {required this.itemCount, required this.product, required this.cart});
}

//for the loading of related products

final class GetAllBrandRelatedProductsDetailsEvent extends DetailsPageEvent {
  final Product product;
  const GetAllBrandRelatedProductsDetailsEvent({required this.product});
}

final class GetAllBrandRelatedCartDetailsEvent extends DetailsPageEvent {
  // final Product product;

  const GetAllBrandRelatedCartDetailsEvent();
}

final class UpdateProductToFavoriteBrandRelatedDetailsEvent
    extends DetailsPageEvent {
  final bool isFavorited;
  final Product product;
  const UpdateProductToFavoriteBrandRelatedDetailsEvent(
      {required this.isFavorited, required this.product});
}

final class UpdateProductToCartBrandRelatedDetailsEvent
    extends DetailsPageEvent {
  final int itemCount;
  final Product product;
  final Cart? cart;

  const UpdateProductToCartBrandRelatedDetailsEvent(
      {required this.itemCount, required this.product, required this.cart});
}
