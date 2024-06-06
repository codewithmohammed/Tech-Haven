part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class ProfileSignOutUserEvent extends ProfileEvent{}

final class GetUserProfileDataEvent extends ProfileEvent{}