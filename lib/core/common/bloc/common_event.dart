part of 'common_bloc.dart';

sealed class CommonEvent extends Equatable {
  
  const CommonEvent();

  @override
  List<Object> get props => [];
}

final class GetUserLocationDataEvent extends CommonEvent {}

final class UpdateProductToFavoriteEvent extends CommonEvent {
  final bool isFavorited;
  final Product product;

  UpdateProductToFavoriteEvent(
      {required this.isFavorited, required this.product});
}
