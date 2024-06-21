part of 'home_page_bloc.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

final class GetAllProductsEvent extends HomePageEvent {}

final class GetAllBannerHomeEvent extends HomePageEvent {}

final class GetAllCartHomeEvent extends HomePageEvent {}

final class UpdateProductToFavoriteHomeEvent extends HomePageEvent {
  final bool isFavorited;
  final Product product;

  const UpdateProductToFavoriteHomeEvent(
      {required this.product, required this.isFavorited});
}

final class GetUserOwnedProductsEvent extends HomePageEvent {}

final class UpdateProductToCartHomeEvent extends HomePageEvent {
  final int itemCount;
  final Product product;
  final Cart? cart;
  const UpdateProductToCartHomeEvent(
      {required this.itemCount, required this.product, required this.cart});
}

final class GetAllSubCategoriesHomeEvent extends HomePageEvent {}

final class BannerProductNavigateEvent extends HomePageEvent {
  final String productID;
  BannerProductNavigateEvent({required this.productID});
}
