import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/entities/user_data_model.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tech_haven/features/auth/data/models/user_model.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  // final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    // this.connectionChecker,
  );
  @override
  Future<Either<Failure, UserModel>> currentUser() async {
    try {
      final currentUser = remoteDataSource.currentUser;
      if (currentUser == null) {
        return left(Failure('User not logged in!'));
      }
      print('the current user id is ${currentUser.uid}');
      return right(UserModel(
        signUpUID: currentUser.uid,
        phonenumber: currentUser.phoneNumber ?? '',
        username: currentUser.displayName ?? '',
        email: currentUser.email ?? '',
      ));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> userProfileUpload({
    required String uid,
    required bool isprofilephotoUploaded,
    required File? image,
    required String username,
    required int color,
  }) async {
    try {
      final String hello = await remoteDataSource.userProfileUpload(
          uid: uid,
          isprofilephotoUploaded: isprofilephotoUploaded,
          image: image,
          username: username,
          color: color);
      return right(hello);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserDataModel>> signUpWithEmailPasswordAndCreateUser({
    required String phonenumberVerifiedUID,
    required String phonenumber,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPasswordAndCreateUser(
          phonenumberVerifiedUID: phonenumberVerifiedUID,
          phonenumber: phonenumber,
          username: username,
          email: email,
          password: password);
      print(
        'after returning the username of the user and uid is  ${user.signUpUID}${user.username}',
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> verifyPhoneNumber({
    required String phonenumber,
  }) async {
    try {
      final verificatiionId =
          await remoteDataSource.verifyPhoneNumber(phonenumber: phonenumber);
      return right(verificatiionId);
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, String>> verifyOTPCode(
      {required String verificationId, required String otpCode}) async {
    try {
      final userId = await remoteDataSource.verifyOTPCode(
          verificationId: verificationId, otpCode: otpCode);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
