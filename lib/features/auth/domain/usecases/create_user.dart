import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';

class CreateUser implements UseCase<String, CreateUserParams> {
  final AuthRepository authRepository;
  CreateUser({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(CreateUserParams params) async {
    return await authRepository.createUser(
        image: params.image,
        username: params.username,
        color: params.color);
  }
}

class CreateUserParams {
  final File? image;
  final String username;
  final int color;

  CreateUserParams({
    required this.image,
    required this.username,
    required this.color,
  });
}
