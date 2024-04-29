import 'package:tech_haven/core/entities/user.dart';

import 'auth_bloc.dart';
//for the otp page
final class AuthOTPPageState extends AuthState {}

final class OTPPageActionState extends AuthOTPPageState {}

final class UserCreationFailed extends OTPPageActionState {
  final String message;
  UserCreationFailed({required this.message});
}

final class UserCreationSuccess extends OTPPageActionState {
  final User user;
  UserCreationSuccess({required this.user});
}