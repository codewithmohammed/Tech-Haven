import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_haven/core/error/exceptions.dart';
abstract interface class AuthRemoteDataSource {
  Future<String> verifyPhoneNumber({
    required String phonenumber,
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

  @override
  Future<String> verifyPhoneNumber({required String phonenumber}) async {
    try {
      String? potentialVerificationId;
      firebaseAuth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          throw ServerException(error.message!);
        },
        codeSent: (verificationId, forceResendingToken) {
          print('hello how are your');
          potentialVerificationId = verificationId;
          print(potentialVerificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );print(potentialVerificationId);
      return potentialVerificationId ?? 'hello i am the greatest';
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
