import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/auth_utils.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/forgot_password_page_state.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/authentication_container.dart';
import 'package:tech_haven/core/common/widgets/phone_number_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneNumberController = TextEditingController();
  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  final countryCode = AuthUtils.forgotPasswordCountryCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.primaryAppColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        // buildWhen: (previous, current) =>
        //     current is AuthForgotPasswordPageState,
        // listenWhen: (previous, current) =>
        //     current is ForgotPasswordPageActionState,
        listener: (context, state) {
          if (state is UserEmailForgotPasswordFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
          }
          if (state is UserEmailForgotPasswordSuccess) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );

            GoRouter.of(context).pushReplacementNamed(
              AppRouteConstants.signinPage,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(),
              Positioned(
                bottom: -50,
                child: AuthenticationContainer(
                  height: 450,
                  title: "Forgot \nPassword?",
                  subTitle: 'enter your registered mobile number',
                  columnChildren: [
                    PhoneNumberTextField(
                      countryCode: countryCode,
                      textFormFieldEnabled: true,
                      phoneNumberController: phoneNumberController,
                    ),
                  ],
                  buttonNeeded: true,
                  buttonText: 'Sent OTP',
                  onPressedElevatedButton: () async {
                    if (countryCode.value != '000') {
                      final fullPhoneNumber =
                          '+${countryCode.value}${phoneNumberController.text}';
                      //check if the user is present.if the user is present send the otp to the mobile else show snackbar.
                      context.read<AuthBloc>().add(ForgotPasswordSendEmailEvent(
                          phoneNumber: fullPhoneNumber));
                      // GoRouter.of(context).pushNamed(
                      //     AppRouteConstants.otpVerificationPage,
                      //     pathParameters: {'verificationId': 'hello'}
                      //     );
                    }
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
