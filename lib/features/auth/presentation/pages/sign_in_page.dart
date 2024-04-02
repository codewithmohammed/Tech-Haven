import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/features/auth/presentation/constants/auth_constants.dart';
import 'package:tech_haven/features/auth/presentation/widgets/authentication_container.dart';
import 'package:tech_haven/features/auth/presentation/widgets/authentication_text_form_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppPallete.primaryAppColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              // decoration: const BoxDecoration(
              //   color: AppPallete.primaryAppColor,
              // ),
              ),
          //for aligning the container in the stack ,used the align widget instead of positioned.
          // MediaQuery.of(context).size.width > 650 ?
          //if the screen width is greater than the value we will build a new align else for the mobile phones
          // Align(
          //   heightFactor: 2,
          //   widthFactor: 2,
          //   alignment: screenWidth < 930
          //       ? const AlignmentDirectional(0, 1.35)
          //       : screenWidth < 1250
          //           ? const Alignment(1, 0)
          //           : screenWidth < 1650
          //               ? const Alignment(2, 0)
          //               : const Alignment(3, 0),
          //the authentication container for form filling the same will be used in the login page / and sign up page.
          // child:
          Positioned(
            bottom: -50,
            child: AuthenticationContainer(
              height: 450,
              title: 'Sign In',
              columnChildren: [
                AuthenticationTextFormField(
                  textEditingController: phoneNumberController,
                  labelText: 'Phone Number',
                  hintText: '+91 1234567890',
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                AuthenticationTextFormField(
                  textEditingController: passwordController,
                  labelText: 'Password',
                  hintText: '',
                  isObscureText: true,

                ),
                FadeInUp(
                  from: 50,
                  duration: const Duration(
                      milliseconds: Constants.normalAnimationMilliseconds),
                  curve: Curves.easeOut,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          GoRouter.of(context)
                              .pushNamed(AppRouteConstants.forgotPasswordPage);
                        },
                        child: const Text(
                          "Forgot Password ?",
                          style: TextStyle(
                              fontSize: 14, color: AppPallete.primaryAppColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).pop();
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
              //the text inside the elevated button
              buttonNeeded: true,
              buttonText: 'Sign in',
              topButtonNeeded: true,
              topButtonChild: SvgPicture.asset(
                AuthConstants.googleIconSVG,
                width: 30,
                height: 30,
              ),
              onPressedElevatedButton: () {},
              onPressedTopButton: () {},
            ),
          ),
        ],
      ),
    );
  }
}
