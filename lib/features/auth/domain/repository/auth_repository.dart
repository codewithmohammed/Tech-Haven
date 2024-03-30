import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/entities/user.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract interface class AuthRepository {
  //interface for the verification of the user phone number
  //this will return either fauilure or string with verificaitonId in it
  //if it's failure we will display a snackbar telling the issue else we will proceed to create a user with phone number
  Future<Either<Failure, String>> verifyPhoneNumber({
    required String phonenumber,
  });
  //for user sign up using email/password
  // Future<Either<Failure, User>> signUpWithEmailPasswordByPhoneVerification({
  //   required String phonenumber,
  //   required String email,
  //   required String password,
  // });
  // //for sign in using phone number
  // Future<Either<Failure, User>> signInWithPhoneNumberAndPassword({
  //   required String phonenumber,
  //   required String password,
  // });
}
