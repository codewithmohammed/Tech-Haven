part of 'search_page_bloc.dart';

// sealed class SearchPageEvent extends Equatable {
//   const SearchPageEvent();

//   @override
//   List<Object> get props => [];
// }

// // import 'package:equatable/equatable.dart';

abstract class SearchPageEvent extends Equatable {
  const SearchPageEvent();

  @override
  List<Object> get props => [];
}
final class GetAllCartProductsEvent extends SearchPageEvent {}
class SearchProductsEvent extends SearchPageEvent {
  final String? query;
  // final bool isFirstTime;

  const SearchProductsEvent(this.query);

}

final class UpdateProductToFavoriteSearchPageEvent extends SearchPageEvent {
  final bool isFavorited;
  final Product product;

  const UpdateProductToFavoriteSearchPageEvent(
      {required this.product, required this.isFavorited});
}

final class UpdateProductToCartSearchPageEvent extends SearchPageEvent {
  final int itemCount;
  final Product product;
  final Cart? cart;
  const UpdateProductToCartSearchPageEvent(
      {required this.itemCount, required this.product, required this.cart});
}
