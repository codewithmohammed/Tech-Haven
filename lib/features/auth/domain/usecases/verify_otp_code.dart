import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';

class VerifyUserOTPCode implements UseCase<String, VerifyUserOTPCodeParams> {
  final AuthRepository authRepository;
  const VerifyUserOTPCode(this.authRepository);

  @override
  Future<Either<Failure, String>> call(VerifyUserOTPCodeParams params) async {
    return await authRepository.verifyOTPCode(
      otpCode: params.otpCode,
      verificationId: params.verificationId,
    );
  }
}

class VerifyUserOTPCodeParams {
  final String verificationId;
  final String otpCode;

  VerifyUserOTPCodeParams({
    required this.verificationId,
    required this.otpCode,
  });
}
