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

final class OTPSendSuccess extends SignUpPageActionState {
  final AuthSignUpModel authSignUpModel;
  OTPSendSuccess({required this.authSignUpModel});
}

final class OTPSendFailed extends SignInPageActionState {
  final String message;
  OTPSendFailed({required this.message});
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

//for the sign in page
final class AuthSignInPageState extends AuthState {}

final class SignInPageActionState extends AuthSignInPageState {}

final class AuthSignInSuccess extends SignInPageActionState {
  final String message;
  AuthSignInSuccess({required this.message});
}

final class AuthSignInFailed extends SignInPageActionState {
  final String message;
  AuthSignInFailed({required this.message});
}

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

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

//states for signup welcome page.
final class AuthSignUpWelcomPageState extends AuthState {}

//for action states of sign up welcome page
final class SignUpWelcomePageActionState extends AuthSignUpWelcomPageState {}

final class CreateUserSuccess extends SignUpWelcomePageActionState {
  final String message;
  CreateUserSuccess({required this.message});
}

final class CreateUserFailed extends SignUpWelcomePageActionState {
  final String message;
  CreateUserFailed({required this.message});
}

final class AuthIsUserLoggedInFailed extends SignUpWelcomePageActionState {
  final String message;
  AuthIsUserLoggedInFailed({required this.message});
}

final class AuthIsUserLoggedInSuccess extends SignUpWelcomePageActionState {
  final User user;
  AuthIsUserLoggedInSuccess({required this.user});
}
