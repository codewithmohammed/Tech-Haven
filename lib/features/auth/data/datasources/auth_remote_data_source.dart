import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_haven/core/error/exceptions.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> verifyPhoneNumber({
    required String phonenumber,
  });

  Future<String> verifyOTPCode({
    required String verificationId,
    required String otpCode,
  });
//   Future<UserModel> signUpWithEmailPasswordByPhoneVerification({
//     required String phonenumber,
//     required String email,
//     required String password,
//   });

//   Future<String> signInWithPhoneNumberAndPassword({
//     required String phoneNumber,
//     required String password,
//   });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  // @override
  // Future<String> signInWithPhoneNumberAndPassword(
  //     {required String phoneNumber, required String password}) {
  //   throw UnimplementedError();
  // }

  // @override
  // Future<UserModel> signUpWithEmailPasswordByPhoneVerification({
  //   required String phonenumber,
  //   required String email,
  //   required String password,
  // }) async {
  //    throw UnimplementedError();
  // try {
  //   await firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: phonenumber,
  //     verificationCompleted: (phoneAuthCredential) {},
  //     verificationFailed: (error) {},
  //     codeSent: (verificationId, forceResendingToken) {},
  //     codeAutoRetrievalTimeout: (verificationId) {},
  //   );
  // } catch (e) {
  //   print(e.toString());
  // }
  // }
  String? potentialVerificationId;
  @override
  Future<String> verifyPhoneNumber({required String phonenumber}) async {
    try {
      firebaseAuth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          throw ServerException(error.message!);
        },
        codeSent: (verificationId, forceResendingToken) {
          print('assigning the verification id');
          assignTheVerificationId(verificationId);
          // print(potentialVerificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
      if (potentialVerificationId != null) {
        print(potentialVerificationId);
        return potentialVerificationId!;
      } else {
        throw const ServerException('The Verification ID is failed to recieve');
      }
      // potentialVerificationId ??= 'The verification id is not assigned';
      // print(potentialVerificationId);
      // return potentialVerificationId!;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  void assignTheVerificationId(String verificationId) {
    potentialVerificationId = verificationId;
  }

  @override
  Future<String> verifyOTPCode(
      {required String verificationId, required String otpCode}) async {
    try {
      //first we will try to create a new phoneauthCredential with the verificationId and the otp code recieved
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      //then ww will try to sign in the user with the phone credential so will get the user credential to check whether the otp is verified to signinwithcredential
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
      //we will get the user data if it's signed in successfully and if not otherwise.
      User? user = userCredential.user;
//if the recieved user is null it means that the otp entered is not vaalid. so we will return an error
      if (user != null) {
        // Mobile number verified successfully
        print("Mobile number verified for user: ${user.uid}");
        return user.uid;
      } else {
        throw const ServerException('The OTP Entered is not Valid');
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
