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

final class EmitInitial extends DetailsPageEvent{}