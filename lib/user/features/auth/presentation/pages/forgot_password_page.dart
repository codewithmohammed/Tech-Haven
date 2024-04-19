import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/authentication_container.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/authentication_text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.primaryAppColor,
      body: Stack(
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
                AuthenticationTextFormField(
                  textEditingController: phoneNumberController,
                  labelText: 'Mobile Number',
                  hintText: '+91 1234567890',
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ],
              buttonNeeded: true,
              buttonText: 'Sent OTP',
              onPressedElevatedButton: () {
                GoRouter.of(context).pushNamed(
                    AppRouteConstants.otpVerificationPage,
                    pathParameters: {'verificationId': 'hello'});
              },
            ),
          )
        ],
      ),
    );
  }
}
