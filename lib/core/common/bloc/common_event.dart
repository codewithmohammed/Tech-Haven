part of 'common_bloc.dart';

sealed class CommonEvent extends Equatable {
  const CommonEvent();

  @override
  List<Object> get props => [];
}

final class GetUserLocationDataEvent extends CommonEvent{}