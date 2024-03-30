import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_haven/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tech_haven/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';
import 'package:tech_haven/features/auth/domain/usecases/verify_otp_code.dart';
import 'package:tech_haven/features/auth/domain/usecases/verify_user_phone_number.dart';
import 'package:tech_haven/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
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
    ..registerLazySingleton(
      () => AuthBloc(
        verifyUserPhoneNumber: serviceLocator(),
        verifyUserOTPCode: serviceLocator(),
      ),
    );
}
