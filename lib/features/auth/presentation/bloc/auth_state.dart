part of 'auth_bloc.dart';

//state for the complete auth state
sealed class AuthState {
  const AuthState();
}

// the imitial state of the page
//for the sign up page
final class AuthSignUpPageState extends AuthState {}

//for the actions states of sign up page
final class SignUpPageActionState extends AuthSignUpPageState {}

final class NavigateToOTPPage extends SignUpPageActionState {
  final String verificationId;
  NavigateToOTPPage({required this.verificationId});
}

final class SignUpPageDisableTextField extends SignUpPageActionState {
  final String verificationId;
  SignUpPageDisableTextField({required this.verificationId});
}

final class SignUpUserSuccess extends SignUpPageActionState {
  final UserDataModel user;
  SignUpUserSuccess({required this.user});
}

final class SignUpUserFailed extends SignUpPageActionState {
  final String message;
  SignUpUserFailed({required this.message});
}

final class StartSigningUpUser extends SignUpPageActionState {
  final String userId;
  StartSigningUpUser({required this.userId});
}

final class SignUpVerificationIDFailed extends SignUpPageActionState {
  final String message;
  SignUpVerificationIDFailed({required this.message});
}

//for the sign in page
final class AuthSignInPageState extends AuthState {}

final class SignInPageActionState extends AuthSignInPageState {}

//for the otp page
final class AuthOTPPageState extends AuthState {}

final class OTPPageActionState extends AuthOTPPageState {}

final class OTPVerificationFailed extends OTPPageActionState {
  final String message;
  OTPVerificationFailed({required this.message});
}

final class OTPVerificationSuccess extends OTPPageActionState {
  final String userId;
  OTPVerificationSuccess({required this.userId});
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

//states for signup welcome page.
final class AuthSignUpWelcomPageState extends AuthState {}

//for action states of sign up welcome page
final class SignUpWelcomePageActionState extends AuthSignUpWelcomPageState {}

final class UserProfileSetSuccess extends SignUpWelcomePageActionState {
  final String message;
  UserProfileSetSuccess({required this.message});
}

final class UserProfileSetFailed extends SignUpWelcomePageActionState {
  final String message;
  UserProfileSetFailed({required this.message});
}

final class AuthIsUserLoggedInFailed extends SignUpWelcomePageActionState {
  final String message;
  AuthIsUserLoggedInFailed({required this.message});
}

final class AuthIsUserLoggedInSuccess extends SignUpWelcomePageActionState {
  final User user;
  AuthIsUserLoggedInSuccess({required this.user});
}
