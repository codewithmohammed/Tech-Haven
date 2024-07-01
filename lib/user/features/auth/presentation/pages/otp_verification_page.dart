import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/otp_page_state.dart';
import 'package:tech_haven/user/features/auth/presentation/route%20params/home_route_params.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/authentication_container.dart';
import 'package:lottie/lottie.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({
    super.key,
    // required this.phoneNumber,
    // required this.verificaionID,
    // required this.email,
    // required this.password,
    required this.otpParams,
  });
  // final String phoneNumber;
  // final String email;
  // final String password;
  // final String verificaionID;
  final OTPParams otpParams;
  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  // @override
  // void deactivate() {
  //   pinController.dispose();
  //   focusNode.dispose();
  //   super.deactivate();
  // }

  @override
  Widget build(BuildContext context) {
    // const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = AppPallete.lightgreyColor;
    // const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(
          10,
        ),
        // border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      backgroundColor: AppPallete.primaryAppColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        // listenWhen: (previous, current) => current is OTPPageActionState,
        // buildWhen: (previous, current) => current is AuthOTPPageState,
        listener: (context, state) {
          if (state is UserCreationSuccess) {
            //navigate to signupwelcome page.
            if (widget.otpParams.isForSignUp) {
              GoRouter.of(context).pushReplacementNamed(
                  AppRouteConstants.signupWelcomePage,
                  pathParameters: {
                    'initialUsername': state.username,
                  });
            }
          }
          if (state is UserCreationFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
            pinController.clear();
            GoRouter.of(context).pop();
          }
          if (state is UpdateUserPhoneNumberFailed) {
            Fluttertoast.showToast(msg: state.message);
            GoRouter.of(context).pop();
          }
          if (state is UpdateUserPhoneNumberSuccess) {
            Fluttertoast.showToast(
                msg: "Your Phone number is successfully Updated");
            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  // decoration: const BoxDecoration(
                  //   color: AppPallete.primaryAppColor,
                  // ),
                  ),
              Positioned(
                top: 25,
                child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(415, 415)),
                    child: Lottie.asset(' assets/lotties/otp-lottie.json')),
              ),
              Container(),
              Positioned(
                bottom: -50,
                child: AuthenticationContainer(
                  height: 450,
                  title: 'Code Verification',
                  subTitle:
                      'Enter your 4-digit verification code receieved in your phone number',
                  columnChildren: [
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      child: Pinput(
                        length: 6,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                            6,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          )
                        ],
                        controller: pinController,
                        focusNode: focusNode,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 1),
                        // validator: (value) {
                        //   return value == '222255' ? null : 'Pin is incorrect';
                        // },
                        onClipboardFound: (value) {
                          debugPrint('onClipboardFound: $value');
                          pinController.setText(value);
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        //on completing the entering of the pinCode.
                        onCompleted: (pinCode) {
                          if (widget.otpParams.isForSignUp) {
                            context.read<AuthBloc>().add(
                                  VerifyPhoneAndSignUpUserEvent(
                                    phoneNumber: widget.otpParams.phoneNumber,
                                    email: widget.otpParams.email!,
                                    password: widget.otpParams.password!,
                                    verificationId:
                                        widget.otpParams.verificaionID,
                                    otpCode: pinCode,
                                  ),
                                );
                          } else {
                            context
                                .read<AuthBloc>()
                                .add(UpdateThePhoneNumberOfUser(
                                  updateNumber: false,
                                  phoneNumber: widget.otpParams.phoneNumber,
                                  verificationID:
                                      widget.otpParams.verificaionID,
                                  otpCode: pinCode,
                                ));
                          }
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: AppPallete.blackColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
