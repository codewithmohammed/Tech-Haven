import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/entities/user.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';

// class UserSignUp implements UseCase<User, UserSignUpParams> {
//   final AuthRepository authRepository;
//   const UserSignUp(this.authRepository);

//   @override
//   Future<Either<Failure, User>> call(UserSignUpParams params) async {
//     return await authRepository.signUpWithEmailPasswordByPhoneVerification(
//       phonenumber: params.phonenumber,
//       email: params.email,
//       password: params.password,
//     );
//   }
// }

// class UserSignUpParams {
//   final String phonenumber;
//   final String email;
//   final String password;
//   UserSignUpParams({
//     required this.phonenumber,
//     required this.email,
//     required this.password,
//   });
// }
