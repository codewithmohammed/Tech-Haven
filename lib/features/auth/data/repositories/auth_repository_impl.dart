
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  // final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    // this.connectionChecker,
  );

  // @override
  // Future<Either<Failure, bool>> verifyPhoneNumber(
  //     {required String phonenumber}) async {
  //     try{
  //       if(! await (connectionChecker.isConnected)){
  //         return left(Failure(Constants.noConnectionErrorMessage));
  //       }
  //       // final user = await fn();
  //       return Right(true);
  //     }  on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }

  // Future<Either<Failure, User>> _getUser(
  //   Future<User> Function() fn,
  // ) async {
  //   try {
  //     if (!await (connectionChecker.isConnected)) {
  //       return left(Failure(Constants.noConnectionErrorMessage));
  //     }
  //     final user = await fn();

  //     return right(user);
  //   } on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }

  // @override
  // Future<Either<Failure, User>> signInWithPhoneNumberAndPassword(
  //     {required String phonenumber, required String password}) {
  //   // TODO: implement signInWithPhoneNumberAndPassword
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, User>> signUpWithEmailPasswordByPhoneVerification({
  //   required String phonenumber,
  //   required String email,
  //   required String password,
  // }) async {
  //   return _getUser(() async =>
  //       await remoteDataSource.signUpWithEmailPasswordByPhoneVerification(
  //         phonenumber: phonenumber,
  //         email: email,
  //         password: password,
  //       ));
  // }

  // @override
  // Future<Either<Failure, User>> signInWithPhoneNumberAndPassword({required String phonenumber, required String password}) {
  //   // TODO: implement signInWithPhoneNumberAndPassword
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, User>> signUpWithEmailPasswordByPhoneVerification({required String phonenumber, required String email, required String password}) {
  //   // TODO: implement signUpWithEmailPasswordByPhoneVerification
  //   throw UnimplementedError();
  // }
  @override
  Future<Either<Failure, String>> verifyPhoneNumber({
    required String phonenumber,
  }) async {
    try {
      final verificatiionId =
          await remoteDataSource.verifyPhoneNumber(phonenumber: phonenumber);
      return right(verificatiionId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
