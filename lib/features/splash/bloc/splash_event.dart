part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent {}

final class IsUserLoggedIn extends SplashEvent{}