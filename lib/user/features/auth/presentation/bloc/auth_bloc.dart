import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/common/cubits/app_cubit/app_user_cubit.dart';
import 'package:tech_haven/core/common/entities/auth_sign_up_model.dart';
import 'package:tech_haven/core/common/entities/user.dart';
import 'package:tech_haven/core/common/entities/user_data_model.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/current_user.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/create_user.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/user_signin.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/verify_phone_number_and_sign_up.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/send_otp_to_phone_number.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final UserSignUp _userSignUp;
  final AppUserCubit _appUserCubit;
  final CurrentUser _currentUser;

  final SendOTPToPhoneNumber _sendOTPToPhoneNumber;
  final VerifyPhoneAndSignUpUser _verifyPhoneAndSignUpUser;
  final CreateUser _createUser;
  final UserSignIn _userSignIn;
  AuthBloc({
    // required UserSignUp userSignUp,
    required AppUserCubit appUserCubit,
    required CurrentUser currentUser,
    required SendOTPToPhoneNumber sendOTPToPhoneNumber,
    required VerifyPhoneAndSignUpUser verifyPhoneAndSignUpUser,
    required CreateUser createUser,
    required UserSignIn userSignIn,
  })  :
        //  _userSignUp = userSignUp,
        _appUserCubit = appUserCubit,
        _currentUser = currentUser,
        _sendOTPToPhoneNumber = sendOTPToPhoneNumber,
        _verifyPhoneAndSignUpUser = verifyPhoneAndSignUpUser,
        _createUser = createUser,
        _userSignIn = userSignIn,
        super(AuthInitial()) {
    // on the first event or in the initial stage we will show the loading state
    on<AuthEvent>((event, emit) {
      emit(
        AuthLoading(),
      );
    });
    //for verifying the phoneNumber and also creating a user with email and password
    // on<NavigateToSignUpPageEvent>(_onNavigateToSignUpPageEvent);
    // on<AuthSignUpEvent>(_onAuthSignUpEvent);
    //sending the phonenumber to send the otp.
    on<SendOTPEvent>(_onSendOTPEvent);

    on<VerifyPhoneAndSignUpUserEvent>(_onVerifyPhoneAndSignUpUserEvent);

    //for verifying the otp pincode with phone number
    on<CreateUserEvent>(_onCreateUserEvent);

    on<AuthIsUserLoggedInEvent>(_onAuthIsUserLoggedInEvent);

    on<UserSignInEvent>(_onUserSignInEvent);

    on<SignUpWithGoogleAccount>(_onSignUpWithGoogleAccount);
  }

  FutureOr<void> _onSendOTPEvent(
    SendOTPEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _sendOTPToPhoneNumber(
      SendOTPToPhoneNumberParams(
        phonenumber: event.phoneNumber,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold((failure) => emit(OTPSendFailed(message: failure.message)),
        (authSignUpModel) {
      emit(
        OTPSendSuccess(authSignUpModel: authSignUpModel),
      );
    });
  }

  FutureOr<void> _onVerifyPhoneAndSignUpUserEvent(
      VerifyPhoneAndSignUpUserEvent event, Emitter<AuthState> emit) async {
    final res = await _verifyPhoneAndSignUpUser(VerifyPhoneAndSignUpUserParams(
      phoneNumber: event.phoneNumber,
      email: event.email,
      password: event.password,
      verificationId: event.verificationId,
      otpCode: event.otpCode,
    ));
    res.fold(
      (failure) => emit(
        UserCreationFailed(
          message: failure.message,
        ),
      ),
      (user) => emit(
        UserCreationSuccess(
          user: user,
        ),
      ),
    );
  }

  FutureOr<void> _onCreateUserEvent(
      CreateUserEvent event, Emitter<AuthState> emit) async {
    final res = await _createUser(CreateUserParams(
      image: event.image,
      username: event.username,
      color: event.color,
    ));

    res.fold(
      (failure) => emit(CreateUserFailed(message: failure.message)),
      (result) => emit(
        CreateUserSuccess(
          message: result,
        ),
      ),
    );
  }

  FutureOr<void> _onUserSignInEvent(
      UserSignInEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(UserSignInParams(
        phoneNumber: event.phoneNumber, password: event.password));
    res.fold(
        (failure) => emit(AuthSignInFailed(message: failure.message)),
        (result) => AuthSignInSuccess(
              message: result,
            ));
  }

  FutureOr<void> _onAuthIsUserLoggedInEvent(
      AuthIsUserLoggedInEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold(
        (failure) => emit(
              AuthIsUserLoggedInFailed(message: failure.message),
            ), (user) {
      _appUserCubit.updateUser(user);
      emit(
        AuthIsUserLoggedInSuccess(user: user),
      );
    });
  }

  FutureOr<void> _onSignUpWithGoogleAccount(
      SignUpWithGoogleAccount event, Emitter<AuthState> emit) {}
}
