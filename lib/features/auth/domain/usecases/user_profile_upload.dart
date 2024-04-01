import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';

class UserProfileUpload implements UseCase<String, UserProfileUploadParams> {
  final AuthRepository authRepository;
  UserProfileUpload({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(UserProfileUploadParams params) async {
    return await authRepository.userProfileUpload(
      uid: params.uid,
        isprofilephotoUploaded: params.isprofilephotoUploaded,
        image: params.image,
        username: params.username,
        color: params.color);
  }
}

class UserProfileUploadParams {
  final String uid;
  final bool isprofilephotoUploaded;
  final File? image;
  final String username;
  final int color;

  UserProfileUploadParams({
    required this.uid,
    required this.isprofilephotoUploaded,
    required this.image,
    required this.username,
    required this.color,
  });
}
