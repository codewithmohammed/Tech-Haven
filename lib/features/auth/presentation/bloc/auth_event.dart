part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class VerifyPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;
  VerifyPhoneNumberEvent({required this.phoneNumber});
}

final class VerifyOTPCodeEvent extends AuthEvent {
  final String verificationId;
  final String otpCode;
  VerifyOTPCodeEvent({required this.verificationId,required this.otpCode});
}

// final class AuthSignUp extends AuthEvent {
//   final String phoneNumber;
//   final String email;
//   final String password;
//   AuthSignUp({
//     required this.phoneNumber,
//     required this.email,
//     required this.password,
//   });
// }
