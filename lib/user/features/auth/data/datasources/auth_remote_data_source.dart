import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_haven/user/features/auth/data/models/sign_up_model.dart';
import 'package:tech_haven/user/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  //this is firebase user to get the current user
  User? get currentUser;
  //for phonenumber verification
  Future<SignUpModelImpl> sendOTPToPhoneNumber({
    required String phoneNumber,
    required String email,
    required String password,
  });
//for otp verification
  Future<UserModel> verifyPhoneAndSignUpUser({
    required String phoneNumber,
    required String email,
    required String password,
    required String verificationId,
    required String otpCode,
  });

  Future<String> createUser({
    required File? image,
    required String username,
    required int color,
  });

  Future<String> userSignIn({
    required String phoneNumber,
    required String password,
    // required String verificationID,
    // required String otpCode,
  });
}
