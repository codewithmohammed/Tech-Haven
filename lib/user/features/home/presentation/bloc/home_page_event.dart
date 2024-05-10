part of 'home_page_bloc.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

final class GetAllProductsEvent extends HomePageEvent {}

final class GetAllBannerEvent extends HomePageEvent {}

final class UpdateProductToFavoriteEvent extends HomePageEvent {
  final bool isFavorited;
  final Product product;
  const UpdateProductToFavoriteEvent({required this.product,required this.isFavorited});
}

final class UpdateProductToCart extends HomePageEvent {
  final int count;
  final Product product;
  const UpdateProductToCart({required this.count, required this.product});
}
