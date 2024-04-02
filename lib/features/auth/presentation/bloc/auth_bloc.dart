import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/common/entities/user.dart';
import 'package:tech_haven/core/common/entities/user_data_model.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/features/auth/domain/usecases/current_user.dart';
import 'package:tech_haven/features/auth/domain/usecases/user_profile_upload.dart';
import 'package:tech_haven/features/auth/domain/usecases/user_signup.dart';
import 'package:tech_haven/features/auth/domain/usecases/verify_otp_code.dart';
import 'package:tech_haven/features/auth/domain/usecases/verify_user_phone_number.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  // final AppUserCubit _appUserCubit;

  final CurrentUser _currentUser;
  final UserProfileUpload _userProfileUpload;
  final VerifyUserPhoneNumber _verifyUserPhoneNumber;
  final VerifyUserOTPCode _verifyUserOTPCode;
  AuthBloc({
    required UserSignUp userSignUp,
    // required AppUserCubit appUserCubit,
    required CurrentUser currentUser,
    required UserProfileUpload userProfileUpload,
    required VerifyUserPhoneNumber verifyUserPhoneNumber,
    required VerifyUserOTPCode verifyUserOTPCode,
  })  : _userSignUp = userSignUp,
        // _appUserCubit = appUserCubit,
        _currentUser = currentUser,
        _userProfileUpload = userProfileUpload,
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
    on<NavigateToSignUpPageEvent>(_onNavigateToSignUpPageEvent);
    on<AuthSignUpEvent>(_onAuthSignUpEvent);
    //sending the phonenumber to send the otp.
    on<VerifyPhoneNumberEvent>(_onVerifyPhoneNumberEvent);

    //for verifying the otp pincode with phone number
    on<VerifyOTPCodeEvent>(_verifyOTPCodeEvent);

    on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedInEvent);

    on<SignUpWelcomePageProfileUploadEvent>(
        _onSignUpWelcomePageProfileUploadEvent);
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
        (failure) => emit(SignUpVerificationIDFailed(message: failure.message)),
        (verificationId) {
      emit(
        NavigateToOTPPage(
          verificationId: verificationId,
        ),
      );
    });
  }

  FutureOr<void> _onAuthSignUpEvent(
      AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParams(
        phonenumberVerifiedUID: event.phonenumberVerifiedUID,
        phonenumber: event.phoneNumber,
        username: event.username,
        email: event.email,
        password: event.password));
    res.fold(
        (failure) => emit(SignUpUserFailed(message: failure.message)),
        (user) => emit(
              SignUpUserSuccess(
                user: user,
              ),
            ));
  }

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
        OTPVerificationSuccess(userId: userId),
      ),
    );
  }

  FutureOr<void> _onNavigateToSignUpPageEvent(
      NavigateToSignUpPageEvent event, Emitter<AuthState> emit) {
    emit(StartSigningUpUser(userId: event.userId));
  }

  FutureOr<void> _onSignUpWelcomePageProfileUploadEvent(
      SignUpWelcomePageProfileUploadEvent event,
      Emitter<AuthState> emit) async {
    final res = await _userProfileUpload(
      UserProfileUploadParams(
        uid: event.uid,
        isprofilephotoUploaded: event.isprofilephotoUploaded,
        image: event.image,
        username: event.username,
        color: event.color,
      ),
    );
    res.fold(
      (l) => emit(UserProfileSetFailed(message: l.message)),
      (r) => emit(
        UserProfileSetSuccess(message: r),
      ),
    );
  }

  FutureOr<void> _onAuthIsUserLoggedInEvent(
      AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (failure) => emit(
        AuthIsUserLoggedInFailed(message: failure.message),
      ),
      (user) => emit(
        AuthIsUserLoggedInSuccess(user: user),
      ),
    );
  }
}
