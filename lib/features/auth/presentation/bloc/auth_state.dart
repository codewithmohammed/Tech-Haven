part of 'auth_bloc.dart';

//state for the complete auth state
sealed class AuthState {
  const AuthState();
}

// the imitial state of the page

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}

final class NavigateToOTPPage extends AuthState {
  final String verificationId;
  NavigateToOTPPage({required this.verificationId});
}

final class PhoneVerificationFailed extends AuthState {
  final String message;
  PhoneVerificationFailed({required this.message});
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}

//for all the otp failure states in the otp screen
final class OTPPageStates extends AuthState {}

final class OTPVerificationFailed extends OTPPageStates {
  final String message;
  OTPVerificationFailed({required this.message});
}

final class OTPVerificationSuccess extends OTPPageStates {}



// final class 