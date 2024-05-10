part of 'details_page_bloc.dart';

sealed class DetailsPageState extends Equatable {
  const DetailsPageState();

  @override
  List<Object> get props => [];
}

final class DetailsPageInitial extends DetailsPageState {}

final class DetailsPageLoadingState extends DetailsPageState {}

final class DetailsGetAllCategoryImagesSuccess extends DetailsPageState {
  final Map<int, List<Image>> mapOfListOfImages;
  const DetailsGetAllCategoryImagesSuccess({required this.mapOfListOfImages});
}

final class DetailsGetAllCategoryImagesFailed extends DetailsPageState {
  final String message;
  const DetailsGetAllCategoryImagesFailed({required this.message});
}

