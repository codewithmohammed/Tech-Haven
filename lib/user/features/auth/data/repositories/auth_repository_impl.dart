import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/auth_sign_up_model.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tech_haven/user/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  // final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    // this.connectionChecker,
  );

  @override
  Future<Either<Failure, AuthSignUpModel>> sendOTPToPhoneNumber({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      final signUpModel = await remoteDataSource.sendOTPToPhoneNumber(
        phoneNumber: phoneNumber,
        email: email,
        password: password,
      );
      return right(signUpModel);
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    }
  }

  @override
  Future<Either<Failure, String>> verifyPhoneAndSignUpUser({
    required String phoneNumber,
    required String email,
    required String password,
    required String verificationId,
    required String otpCode,
  }) async {
    try {
      final username = await remoteDataSource.verifyPhoneAndSignUpUser(
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        verificationId: verificationId,
        otpCode: otpCode,
      );
      return right(username);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> createUser({
    required File? image,
    required String username,
    required int color,
  }) async {
    try {
      final bool result = await remoteDataSource.createUser(
          image: image, username: username, color: color);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }



  @override
  Future<Either<Failure, String>> userSignIn(
      {required String phoneNumber, required String password}) async {
    try {
      final result = await remoteDataSource.userSignIn(
          phoneNumber: phoneNumber, password: password);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signUpUserWithGoogle() async {
    try {
      final result = await remoteDataSource.signUpUserWithGoogle();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPasswordSendEmail(
      {required String phoneNumber}) async {
    try {
      final result = await remoteDataSource.forgotPasswordSendEmail(
          phoneNumber: phoneNumber);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
