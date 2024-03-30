
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/features/auth/domain/repository/auth_repository.dart';

class VerifyUserPhoneNumber
    implements UseCase<String, VerifyPhoneNumberParams> {
  final AuthRepository authRepository;
  const VerifyUserPhoneNumber(this.authRepository);

  @override
  Future<Either<Failure, String>> call(VerifyPhoneNumberParams params) async {
    return await authRepository.verifyPhoneNumber(
      phonenumber: params.phonenumber,
    );
  }
}

class VerifyPhoneNumberParams {
  final String phonenumber;

  VerifyPhoneNumberParams({
    required this.phonenumber,
  });
}
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   static String verifyId = "";
//   // to sent and otp to user
//   static Future sentOtp({
//     required String phone,
//     required Function errorStep,
//     required Function nextStep,
//   }) async {
//     await _firebaseAuth
//         .verifyPhoneNumber(
//       timeout: Duration(seconds: 30),
//       phoneNumber: "+91$phone",
//       verificationCompleted: (phoneAuthCredential) async {
//         return;
//       },
//       verificationFailed: (error) async {
//         return;
//       },
//       codeSent: (verificationId, forceResendingToken) async {
//         verifyId = verificationId;
//         nextStep();
//       },
//       codeAutoRetrievalTimeout: (verificationId) async {
//         return;
//       },
//     )
//         .onError((error, stackTrace) {
//       errorStep();
//     });
//   }
// }
