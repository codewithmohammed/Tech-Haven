part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class VerifyPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;
  VerifyPhoneNumberEvent({required this.phoneNumber});
}

final class VerifyOTPCodeEvent extends AuthEvent {
  final String verificationId;
  final String otpCode;
  VerifyOTPCodeEvent({required this.verificationId, required this.otpCode});
}

final class NavigateToSignUpPageEvent extends AuthEvent {
  final String userId;
  NavigateToSignUpPageEvent({required this.userId});
}

final class AuthSignUpEvent extends AuthEvent {
  final String phonenumberVerifiedUID;
  final String username;
  final String phoneNumber;
  final String email;
  final String password;
  AuthSignUpEvent({
    required this.phonenumberVerifiedUID,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}

final class SignUpWelcomePageProfileUploadEvent extends AuthEvent {
  final String uid;
  final bool isprofilephotoUploaded;
  final File? image;
  final String username;
  final int color;

  SignUpWelcomePageProfileUploadEvent({
    required this.uid,
    required this.isprofilephotoUploaded,
    required this.image,
    required this.username,
    required this.color,
  });
}

final class AuthIsUserLoggedInEvent extends AuthEvent {}
