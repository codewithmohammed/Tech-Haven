import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/features/auth/data/models/user_data_model_impl.dart'
    as model;
import 'package:tech_haven/features/auth/data/models/user_data_model_impl.dart';
import 'package:uuid/uuid.dart';

abstract interface class AuthRemoteDataSource {
  //this is firebase user to get the current user
  User? get currentUser;
  //for phonenumber verification
  Future<String> verifyPhoneNumber({
    required String phonenumber,
  });
//for otp verification
  Future<String> verifyOTPCode({
    required String verificationId,
    required String otpCode,
  });

  Future<UserDataModelImpl> signUpWithEmailPasswordAndCreateUser({
    required String phonenumberVerifiedUID,
    required String phonenumber,
    required String username,
    required String email,
    required String password,
  });

  Future<String> userProfileUpload({
    required String uid,
    required bool isprofilephotoUploaded,
    required File? image,
    required String username,
    required int color,
  });

//   Future<String> signInWithPhoneNumberAndPassword({
//     required String phoneNumber,
//     required String password,
//   });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  // @override
  // Future<String> signInWithPhoneNumberAndPassword(
  //     {required String phoneNumber, required String password}) {
  //   throw UnimplementedError();
  // }
  @override
  Future<String> userProfileUpload({
    required String uid,
    required bool isprofilephotoUploaded,
    required File? image,
    required String username,
    required int color,
  }) async {
    try {
      String? downloadUrl;
      Reference ref =
          firebaseStorage.ref().child('usersprofilepicure').child(uid);
      String imageId = const Uuid().v1();
      ref = ref.child(imageId);
      if (image != null) {
        UploadTask uploadTask = ref.putFile(image);
        TaskSnapshot snapshot = await uploadTask;
        downloadUrl = await snapshot.ref.getDownloadURL();
      }
      final CollectionReference collectionReference =
          firebaseFirestore.collection('users');

      collectionReference.doc(uid).update({
        'isprofilephotoUploaded': isprofilephotoUploaded,
        'username': username,
        'profilephoto': downloadUrl,
      });
      return 'success';
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserDataModelImpl> signUpWithEmailPasswordAndCreateUser({
    required String phonenumberVerifiedUID,
    required String phonenumber,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      firebaseAuth.currentUser;
      print('creating the user with email and password');
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      //the collection reference for putting the user's data,
      final CollectionReference usersCollection =
          firebaseFirestore.collection('users');
      // if the user is not null the user must be changed to json and put inside the firestore
      if (user != null) {
        // final ConfirmationResult confirmationResult =
        //       await user.linkWithPhoneNumber(phonenumber);
        // await  confirmationResult.confirm(confirmationResult.verificationId);
        //   await user.updateDisplayName(username);
        print('created user with user id: ${user.uid}');
        print('creating model of the user for object');
        model.UserDataModelImpl userDataModelImpl = model.UserDataModelImpl(
          phonenumberVerifiedUID: phonenumberVerifiedUID,
          signUpUID: user.uid,
          phonenumber: phonenumber,
          email: email,
          username: username,
          isprofilephotoUploaded: false,
          profilephoto: 'profilephoto',
          isVendore: false,
        );
        print('uploading the object model to the firestore');
        await usersCollection.doc(user.uid).set(
              userDataModelImpl.toJson(),
            );
        print('uploading completed');
        print('returning user model');
        return userDataModelImpl;
      } else {
        throw const ServerException('The Email And Password is not verified');
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  String? potentialVerificationId;
  @override
  Future<String> verifyPhoneNumber({required String phonenumber}) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (error) async {
          throw ServerException(error.message!);
        },
        codeSent: (verificationId, forceResendingToken) async {
          print('assigning the verification id');
          assignTheVerificationId(verificationId);
          // print(potentialVerificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
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
    } on ServerException catch (e) {
      throw ServerException(e.message);
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
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  User? get currentUser => firebaseAuth.currentUser;
}
