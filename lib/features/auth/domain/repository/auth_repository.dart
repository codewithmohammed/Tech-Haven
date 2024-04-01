import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/entities/user.dart';
import 'package:tech_haven/core/common/entities/user_data_model.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract interface class AuthRepository {
  //interface for the verification of the user phone number
  //this will return either fauilure or string with verificaitonId in it
  //if it's failure we will display a snackbar telling the issue else we will proceed to create a user with phone number
  Future<Either<Failure, String>> verifyPhoneNumber({
    required String phonenumber,
  });

  //this is for the verification of the otp code that the user has entered
  //if it's failure we will display a snackbar telling the issue else we will give a second chance for the user to enter the otp again
  Future<Either<Failure, String>> verifyOTPCode({
    required String verificationId,
    required String otpCode,
  });
  //for user sign up using email/password
  Future<Either<Failure, UserDataModel>> signUpWithEmailPasswordAndCreateUser({
    required String phonenumberVerifiedUID,
    required String phonenumber,
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> userProfileUpload({
    required String uid,
    required bool isprofilephotoUploaded,
    required File? image,
    required String username,
    required int color,
  });

  Future<Either<Failure, User>> currentUser();
  // //for sign in using phone number
  // Future<Either<Failure, User>> signInWithPhoneNumberAndPassword({
  //   required String phonenumber,
  //   required String password,
  // });
}
