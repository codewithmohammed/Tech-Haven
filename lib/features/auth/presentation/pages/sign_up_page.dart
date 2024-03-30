import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/auth_utils.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/core/validators/validators.dart';
import 'package:tech_haven/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/features/auth/presentation/constants/auth_constants.dart';
import 'package:tech_haven/features/auth/presentation/widgets/authentication_text_form_field.dart';
import 'package:tech_haven/features/auth/presentation/widgets/country_code_container.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widgets/authentication_container.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();
  bool passwordIsObscure = true;
  bool rePasswordIsObscure = true;

// disposing the controllers
  @override
  void dispose() {
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // final screenWidth = MediaQuery.of(context).size.width;
    // a valuenotifire for the country code change.
    final countryCode = AuthUtils.signUpcountryCode;
    return Scaffold(
      backgroundColor: AppPallete.primaryAppColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          //showing a snackbar if the verification of mobile number failed
          if (state is PhoneVerificationFailed) {
            showSnackBar(
              context,
              state.message,
            );
          }
          if (state is NavigateToOTPPage) {
            GoRouter.of(context).pushNamed(
              AppRouteConstants.otpVerificationPage,
              pathParameters: {'verificationId': state.verificationId},
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
              Container(
                  // decoration: const BoxDecoration(
                  //   color: Colors.red
                  // ),
                  ),
              //for aligning the container in the stack ,used the align widget instead of positioned.
              // MediaQuery.of(context).size.width > 650 ?
              //if the screen width is greater than the value we will build a new align else for the mobile phones

              //the authentication container for form filling the same will be used in the login page / and sign up page.
              Positioned(
                bottom: -50,
                child: Form(
                  key: signupFormKey,
                  child: AuthenticationContainer(
                    height: 625,
                    title: 'Sign Up',
                    columnChildren: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // the container for selecting the counctry code
                          ValueListenableBuilder(
                            valueListenable: countryCode,
                            builder: (context, value, child) {
                              return CountryCodeContainer(
                                countryCode: countryCode.value,
                                onTap: () {
                                  changeCountryCode(context);
                                },
                              );
                            },
                          ),
                          //phone number field
                          Expanded(
                            child: AuthenticationTextFormField(
                              textEditingController: phoneNumberController,
                              labelText: 'Phone Number',
                              hintText: '1234567890',
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: Validator.validatePhoneNumber,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      //email field
                      AuthenticationTextFormField(
                        textEditingController: emailController,
                        labelText: 'Email',
                        hintText: 'example@gmail.com',
                        validator: Validator.validateEmail,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      //password
                      AuthenticationTextFormField(
                        textEditingController: passwordController,
                        labelText: 'Password',
                        hintText: '',
                        isObscureText: passwordIsObscure,
                        validator: Validator.validatePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        isPasswordField: true,
                        suffixOnTap: () {
                          setState(() {
                            passwordIsObscure =
                                passwordIsObscure ? false : true;
                          });
                        },
                      ),

                      //re password
                      AuthenticationTextFormField(
                        textEditingController: rePasswordController,
                        labelText: 'Re-Enter Password',
                        hintText: '',
                        isObscureText: rePasswordIsObscure,
                        isPasswordField: true,
                        suffixOnTap: () {
                          setState(() {
                            rePasswordIsObscure =
                                rePasswordIsObscure ? false : true;
                          });
                        },
                      ),

                      FadeInUp(
                        from: 50,
                        duration: const Duration(
                            milliseconds:
                                Constants.normalAnimationMilliseconds),
                        curve: Curves.easeOut,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppPallete.primaryAppColor),
                            ),
                            InkWell(
                              onTap: () {
                                GoRouter.of(context)
                                    .pushNamed(AppRouteConstants.signinPage);
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                    //for the goolgle authentication
                    onPressedTopButton: () {},
                    //the text inside the elevated button
                    buttonNeeded: true,
                    buttonText: 'Sign up',
                    topButtonNeeded: true,
                    topButtonChild: SvgPicture.asset(
                      AuthConstants.googleIconSVG,
                      width: 30,
                      height: 30,
                    ),
                    onPressedElevatedButton: () async {
                      //if all the fields are validated then we need to move to the otp screen to verify the otp by sending the otp to specified mobile number
                      if (signupFormKey.currentState!.validate() &&
                          passwordController.text ==
                              rePasswordController.text &&
                          countryCode.value != '000') {
                        final String fullPhoneNumber =
                            '+${countryCode.value}${phoneNumberController.text}';
                        print(fullPhoneNumber);
                        // print('${countryCode.value}${phoneNumberController.text}');
                        context.read<AuthBloc>().add(
                              VerifyPhoneNumberEvent(
                                phoneNumber: fullPhoneNumber,
                              ),
                            );
                        // await firebaseAuth.verifyPhoneNumber(
                        //   phoneNumber: '+447444555666',
                        //   verificationCompleted: (phoneAuthCredential) async {
                        //     await firebaseAuth
                        //         .signInWithCredential(phoneAuthCredential);
                        //     print('verification is completed automaticall7');
                        //   },
                        //   verificationFailed: (FirebaseAuthException e) {
                        //     if (e.code == 'invalid-phone-number') {
                        //       print('The provided phone number is not valid.');
                        //     }

                        //     // Handle other errors
                        //   },
                        //   codeSent: (verificationId, forceResendingToken) async {
                        //     GoRouter.of(context).pushNamed(
                        //         AppRouteConstants.otpVerificationPage,
                        //         pathParameters: {'verificationId': verificationId});
                        //   },
                        //   codeAutoRetrievalTimeout: (verificationId) {},
                        // );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
                    // context.read<AuthBloc>().add(
                    //       AuthSignUp(
                    //         phoneNumber:
                    //             countryCode.value + phoneNumberController.text,
                    //         email: emailController.text,
                    //         password: passwordController.text,
                    //       ),
                    //     );

                