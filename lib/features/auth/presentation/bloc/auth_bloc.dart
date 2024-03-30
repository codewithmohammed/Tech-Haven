import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/common/entities/user.dart';
import 'package:tech_haven/features/auth/domain/usecases/verify_otp_code.dart';
import 'package:tech_haven/features/auth/domain/usecases/verify_user_phone_number.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final UserSignUp _userSignUp;
  // final AppUserCubit _appUserCubit;
  final VerifyUserPhoneNumber _verifyUserPhoneNumber;
  final VerifyUserOTPCode _verifyUserOTPCode;
  AuthBloc({
    // required UserSignUp userSignUp,
    // required AppUserCubit appUserCubit,
    required VerifyUserPhoneNumber verifyUserPhoneNumber,
    required VerifyUserOTPCode verifyUserOTPCode,
  })  :
        // _userSignUp = userSignUp,
        // _appUserCubit = appUserCubit,
        _verifyUserPhoneNumber = verifyUserPhoneNumber,
        _verifyUserOTPCode = verifyUserOTPCode,
        super(AuthInitial()) {
    // on the first event or in the initial stage we will show the loading state
    on<AuthEvent>((event, emit) {
      emit(
        AuthLoading(),
      );
    });
    //for verifying the phoneNumber and also creating a user with email and password
    // on<AuthSignUp>(_onAuthSignUp);
    on<VerifyPhoneNumberEvent>(_onVerifyPhoneNumberEvent);

    //for verifying the otp pincode
    on<VerifyOTPCodeEvent>(_verifyOTPCodeEvent);
  }

  FutureOr<void> _onVerifyPhoneNumberEvent(
    VerifyPhoneNumberEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _verifyUserPhoneNumber(
      VerifyPhoneNumberParams(
        phonenumber: event.phoneNumber,
      ),
    );
    res.fold(
        (failure) => emit(PhoneVerificationFailed(message: failure.message)),
        (verificationId) {
      print('you are a fool');
      emit(
        NavigateToOTPPage(verificationId: verificationId),
      );
    });
  }

  // FutureOr<void> _onAuthSignUp(
  //   AuthSignUp event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   final res = await _userSignUp(UserSignUpParams(
  //     phonenumber: event.phoneNumber,
  //     email: event.email,
  //     password: event.password,
  //   ));

  //   res.fold(
  //     (failure) => emit(AuthFailure(failure.message)),
  //     (user) => _emitAuthSuccess(user, emit),
  //   );
  // }

  // void _emitAuthSuccess(
  //   User user,
  //   Emitter<AuthState> emit,
  // ) {
  //   _appUserCubit.updateUser(user);
  //   emit(AuthSuccess(user));
  // }

  FutureOr<void> _verifyOTPCodeEvent(
      VerifyOTPCodeEvent event, Emitter<AuthState> emit) async {
    final res = await _verifyUserOTPCode(VerifyUserOTPCodeParams(
      verificationId: event.verificationId,
      otpCode: event.otpCode,
    ));
    res.fold(
      (failure) => emit(
        OTPVerificationFailed(message: failure.message),
      ),
      (userId) => emit(
        OTPVerificationSuccess(),
      ),
    );
  }
}
