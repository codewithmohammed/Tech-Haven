import 'package:animate_do/animate_do.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
import 'package:tech_haven/features/auth/presentation/widgets/phone_number_text_field.dart';
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
    // made to null to use it late after assigning the value
    late String fullPhoneNumber;
    bool textFormFieldEnabled = true;
    // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // final screenWidth = MediaQuery.of(context).size.width;
    // a valuenotifire for the country code change.
    final countryCode = AuthUtils.signUpCountryCode;
    return Scaffold(
      backgroundColor: AppPallete.primaryAppColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is SignUpPageActionState,
        buildWhen: (previous, current) => current is AuthSignUpPageState,
        listener: (context, state) {
          //showing a snackbar if the verification of mobile number failed
          if (state is OTPSendFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
          }
          if (state is OTPSendSuccess) {
            print('navigating to otp page');
            GoRouter.of(context).pushNamed(
                AppRouteConstants.otpVerificationPage,
                pathParameters: {
                  'email': state.authSignUpModel.email,
                  'password': state.authSignUpModel.password,
                  'phoneNumber': state.authSignUpModel.phoneNumber,
                  'verificationID': state.authSignUpModel.verificationID,
                }
                // AppRouteConstants.otpVerificationPage,
                // pathParameters: {
                //   'email': state.authSignUpModel.email,
                //   'password': state.authSignUpModel.password,
                //   'phoneNumber': state.authSignUpModel.phoneNumber,
                //   'verificationID': state.authSignUpModel.verificationID,
                // }
                );
          }
          // if (state is StartSigningUpUser) {
          //   print('starting to sign up user');
          //   //we will disable the whole textform field if the otp verification is success and will move on to creating the user.
          //   textFormFieldEnabled = false;
          //   //we have to extract the name from the email given by the user
          //   final username = extractNameFromEmail(emailController.text);
          //   print(username);
          //   //creating the email signup with firebase, and also saving the user data in the user folder.

          //   context.read<AuthBloc>().add(
          //         AuthSignUpEvent(
          //           phoneNumberVerifiedUID: state.userId,
          //           username: username,
          //           phoneNumber: phoneNumberController.text,
          //           email: emailController.text,
          //           password: passwordController.text,
          //         ),
          //       );
          // }
          if (state is SignUpUserSuccess) {
            print('sdffffffffffffffffffffffffffffffffffffffffffffff');
            GoRouter.of(context).pushReplacementNamed(
              AppRouteConstants.signupWelcomePage,
              pathParameters: {
                'initialUsername': state.user.username,
              },
            );
          }
          if (state is SignUpUserFailed) {
            textFormFieldEnabled = true;
            print('failed');
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
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
                      PhoneNumberTextField(
                        countryCode: countryCode,
                        textFormFieldEnabled: textFormFieldEnabled,
                        phoneNumberController: phoneNumberController,
                      ),
                      //email field
                      AuthenticationTextFormField(
                        enabled: textFormFieldEnabled,
                        textEditingController: emailController,
                        labelText: 'Email',
                        hintText: 'example@gmail.com',
                        validator: Validator.validateEmail,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      //password
                      AuthenticationTextFormField(
                        enabled: textFormFieldEnabled,
                        textEditingController: passwordController,
                        labelText: 'Password',
                        hintText: '',
                        isObscureText: passwordIsObscure,
                        validator: Validator.validatePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        isPasswordField: true,
                        suffixOnTap: () {
                          setState(
                            () {
                              passwordIsObscure =
                                  passwordIsObscure ? false : true;
                            },
                          );
                        },
                      ),

                      //re password
                      AuthenticationTextFormField(
                        enabled: textFormFieldEnabled,
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
                    onPressedTopButton: () {
                      //sign up with google
                      // context.read<AuthBloc>().add(SignUpWithGoogleAccount());
                    },
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
                        fullPhoneNumber =
                            '+${countryCode.value}${phoneNumberController.text}';
                        // print(fullPhoneNumber);
                        context.read<AuthBloc>().add(
                              SendOTPEvent(
                                phoneNumber: fullPhoneNumber,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
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

  signInWithGoogle() {}
}


