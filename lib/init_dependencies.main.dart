import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_haven/core/common/cubits/app_cubit/app_user_cubit.dart';
import 'package:tech_haven/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tech_haven/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:tech_haven/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';
import 'package:tech_haven/features/auth/domain/usecases/current_user.dart';
import 'package:tech_haven/features/auth/domain/usecases/send_otp_to_phone_number.dart';
import 'package:tech_haven/features/auth/domain/usecases/create_user.dart';
import 'package:tech_haven/features/auth/domain/usecases/user_signin.dart';
import 'package:tech_haven/features/auth/domain/usecases/verify_phone_number_and_sign_up.dart';
import 'package:tech_haven/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseStorage.instance);
}

_initAuth() {
  //for user cubit

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
      () => SendOTPToPhoneNumber(serviceLocator()),


      
    )
    ..registerFactory(() => VerifyPhoneAndSignUpUser(serviceLocator()))
    ..registerFactory(() => CreateUser(authRepository: serviceLocator()))
    ..registerFactory(() => UserSignIn(authRepository: serviceLocator()))
    // ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
    // ..registerFactory(() => UserProfileUpload(authRepository: serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
          currentUser: serviceLocator(),
          sendOTPToPhoneNumber: serviceLocator(),
          verifyPhoneAndSignUpUser: serviceLocator(),
          createUser: serviceLocator(),
          userSignIn: serviceLocator(),
          // userProfileUpload: serviceLocator(),
          appUserCubit: serviceLocator()),
    );
}
