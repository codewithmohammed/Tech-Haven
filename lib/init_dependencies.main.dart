import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_haven/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tech_haven/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';
import 'package:tech_haven/features/auth/domain/usecases/current_user.dart';
import 'package:tech_haven/features/auth/domain/usecases/user_profile_upload.dart';
import 'package:tech_haven/features/auth/domain/usecases/user_signup.dart';
import 'package:tech_haven/features/auth/domain/usecases/verify_otp_code.dart';
import 'package:tech_haven/features/auth/domain/usecases/verify_user_phone_number.dart';
import 'package:tech_haven/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initAuth();
  serviceLocator.registerLazySingleton(() =>  FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void>_initAuth()async{
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseStorage: serviceLocator(),
        firebaseAuth: serviceLocator(),
        firebaseFirestore: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    // phonenumberverification
    ..registerFactory(
      () => VerifyUserPhoneNumber(serviceLocator()),
    )
    ..registerFactory(() => VerifyUserOTPCode(serviceLocator()))
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
    ..registerFactory(() => UserProfileUpload(authRepository: serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        currentUser: serviceLocator(),
        userProfileUpload: serviceLocator(),
        verifyUserPhoneNumber: serviceLocator(),
        verifyUserOTPCode: serviceLocator(),
      ),
    );
}
