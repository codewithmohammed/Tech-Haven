part of 'home_page_bloc.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

final class GetAllProductsEvent extends HomePageEvent {}

final class GetAllBannerEvent extends HomePageEvent {}

final class GetAllCartEvent extends HomePageEvent {}

final class UpdateProductToFavoriteEvent extends HomePageEvent {
  final bool isFavorited;
  final Product product;

  const UpdateProductToFavoriteEvent(
      {required this.product, required this.isFavorited});
}

final class UpdateProductToCartEvent extends HomePageEvent {
  final int itemCount;
  final Product product;  final Cart? cart;
  const UpdateProductToCartEvent(
      {required this.itemCount, required this.product,required this.cart});
}


final class GetAllSubCategoriesEvent extends HomePageEvent{
}