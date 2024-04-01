import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/entities/user_data_model.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<UserDataModel, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, UserDataModel>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPasswordAndCreateUser(
      phonenumberVerifiedUID: params.phonenumberVerifiedUID,
      phonenumber: params.phonenumber,
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String phonenumberVerifiedUID;
  final String phonenumber;
  final String username;
  final String email;
  final String password;
  UserSignUpParams({
    required this.phonenumberVerifiedUID,
    required this.phonenumber,
    required this.username,
    required this.email,
    required this.password,
  });
}
