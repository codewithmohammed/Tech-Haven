part of 'map_page_bloc.dart';

sealed class MapPageState extends Equatable {
  const MapPageState();

  @override
  List<Object> get props => [];
}

final class MapPageInitial extends MapPageState {}

final class GetLocationDetailsSuccess extends MapPageState {
  final Location? location;
  GetLocationDetailsSuccess({required this.location});
}

final class GetLocationDetailsFailed extends MapPageState {
  final String message;
  GetLocationDetailsFailed({required this.message});
}

final class UpdateLocationDetailsSuccess extends MapPageState {}

final class UpdateLocationDetailsFailed extends MapPageState {
  final String message;
  UpdateLocationDetailsFailed({required this.message});
}

final class UpdateLocationDetailsLoading extends MapPageState {}

final class GetCurrentUserDataSuccess extends MapPageState {
  final User? user;
  GetCurrentUserDataSuccess({required this.user});
}

final class GetCurrentUserDataFailed extends MapPageState {
  final String message;
  GetCurrentUserDataFailed({required this.message});
}
