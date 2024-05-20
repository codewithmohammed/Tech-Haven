part of 'common_bloc.dart';

sealed class CommonState extends Equatable {
  const CommonState();

  @override
  List<Object> get props => [];
}

final class CommonInitial extends CommonState {}

final class LocationState extends CommonState {}

final class LocationSuccessState extends LocationState {
  final Location? location;
  LocationSuccessState({required this.location});
}

final class LocationFailedState extends LocationState {
  final String message;
  LocationFailedState({required this.message});
}
