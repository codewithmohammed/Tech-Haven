import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart' as model;
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/utils/auth_utils.dart';
import 'package:tech_haven/user/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tech_haven/user/features/auth/data/models/sign_up_model.dart';
import 'package:uuid/uuid.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<bool> createUser({
    required File? image,
    required String username,
    
  required String currency,
  required String currencySymbol,
    required int color,
  }) async {
    User? user = firebaseAuth.currentUser;
    try {
//if image is not null then we upload the image into storage and get the download url and create a user doc

      if (user != null) {
        String? downloadURL;
        if (image != null) {
          String imageID = const Uuid().v1();

          Reference reference = firebaseStorage
              .ref('user')
              .child('usersProfilePicture')
              .child(user.uid)
              .child(imageID);

          UploadTask uploadTask = reference.putFile(image);
          TaskSnapshot taskSnapshot = await uploadTask;

          downloadURL = await taskSnapshot.ref.getDownloadURL();
        }
        final CollectionReference collectionReference =
            firebaseFirestore.collection('users');

        model.UserModel userModel = model.UserModel(
          email: user.email!,
          phoneNumber: user.phoneNumber!,
          uid: user.uid,
          username: username,
          currency: currency,
          vendorID: null,
          currencySymbol: currencySymbol,
          isProfilePhotoUploaded: image != (null),
          color: color,
          profilePhoto: downloadURL ?? '',
          isVendor: false,
        );

        await collectionReference.doc(user.uid).set(userModel.toJson());
      }
      return true;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  String? potentialVerificationId;
  @override
  Future<SignUpModelImpl> sendOTPToPhoneNumber({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      await getVerificationId(phoneNumber);
      if (potentialVerificationId != null) {
        return SignUpModelImpl(
          phoneNumber: phoneNumber,
          email: email,
          password: password,
          verificationID: potentialVerificationId!,
        );
        //
      } else {
        throw const ServerException('The Verification ID is failed to recieve');
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

  Future<void> getVerificationId(String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        firebaseAuth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) async {
        throw ServerException(error.message!);
      },
      codeSent: (verificationId, forceResendingToken) async {
        // print('assigning the verification id');
        assignTheVerificationId(verificationId: verificationId);
        // print(potentialVerificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  assignTheVerificationId({required String verificationId}) {
    potentialVerificationId = verificationId;
  }

  @override
  Future<String> verifyPhoneAndSignUpUser({
    required String phoneNumber,
    required String email,
    required String password,
    required String verificationId,
    required String otpCode,
  }) async {
    try {
      //first we will try to create a new phoneauthCredential with the verificationId and the otp code recieved
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );

      //then ww will try to sign in the user with the phone credential so will get the user credential to check whether the otp is verified to signinwithcredential
      // UserCredential userCredential =
      //     await firebaseAuth.signInWithCredential(phoneAuthCredential);

      //we will get the user data if it's signed in successfully and if not otherwise.
      // User? phoneNumberUser = userCredential.user;

//if the recieved user is null it means that the otp entered is not vaalid. so we will return an error
//if phonenumberuser is not null we will create user with email and password and link the user of it to the phone number
      // if (phoneAuthCredential != null) {
      UserCredential userCredential = await createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await user.linkWithCredential(phoneAuthCredential);
        //sending username to
        return user.displayName ?? AuthUtils.extractNameFromEmail(user.email!);
      } else {
        throw const ServerException(
          'Exception Cauth While Linking Phone Number',
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use') {
        throw const ServerException(
          'its an credential-already-in-use: in use exception',
        );
      }
      throw ServerException(e.message!);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<String> userSignIn({
    required String phoneNumber,
    required String password,
    // required String verificationID,
    // required String otpCode,
  }) async {
    try {
      UserCredential userCredential;
      // Fetch the user document from Firestore based on the provided phone number
      //check if there is a user with this number with email.
      final User? currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        // Sign out the current user before signing in with a different email
        await firebaseAuth.signOut();
      }

      // Fetch the user document from Firestore based on the provided phone number
      final QuerySnapshot snapshot = await firebaseFirestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data() as Map<String, dynamic>;
        final email = userData['email'];
        // Fetch user document based on uid
        // final userDoc =
        //     await FirebaseFirestore.instance.collection('users').doc(uid).get();
        // final userDataFromDoc = userDoc.data();
        // If the user is found, sign in with the user's email and password
        userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        // await firebaseAuth.signInWithCredential(credential);
        return userCredential.user!.email!;
        // Navigate to the next screen or perform any desired action
      } else {
        throw const ServerException(
          "User can't sign in",
        );
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        e.message ?? 'Invalid Exception',
      );
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signUpUserWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw const ServerException('the google user is not initiated');
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return userCredential.user!.email!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> forgotPasswordSendEmail({required String phoneNumber}) async {
    try {
      // firebaseAuth.confirmPasswordReset(code: code, newPassword: newPassword)
      final QuerySnapshot snapshot = await firebaseFirestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data() as Map<String, dynamic>;
        final String email = userData['email'];
        // Fetch user document based on uid
        // final userDoc =
        //     await FirebaseFirestore.instance.collection('users').doc(uid).get();
        // final userDataFromDoc = userDoc.data();
        // If the user is found, sign in with the user's email and password
        await firebaseAuth.sendPasswordResetEmail(email: email);
        // await firebaseAuth.signInWithCredential(credential);
        // return userCredential.user!.email!;
        // Navigate to the next screen or perform any desired action

        return 'Change your Password from the link that is send to your email $email';
      } else {
        throw const ServerException(
          "User doesn't Exist with this phone number",
        );
      }
      // return potentialVerificationId!;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
