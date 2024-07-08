import 'package:animate_do/animate_do.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/auth_utils.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/core/validators/validators.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/sign_in_page_state.dart';
import 'package:tech_haven/user/features/auth/presentation/constants/auth_constants.dart';
import 'package:tech_haven/user/features/auth/presentation/responsive/responsive_authentication.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/authentication_container.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/phone_number_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

String? phoneNumberError;
String? passwordError;
late String fullPhoneNumber;
TextEditingController phoneNumberController = TextEditingController();
TextEditingController passwordController = TextEditingController();

bool passwordIsObscure = true;

class _SignInPageState extends State<SignInPage> {
  final countryCode = AuthUtils.signInCountryCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppPallete.primaryAppColor,
        body: BlocConsumer<AuthBloc, AuthState>(
          // listenWhen: (previous, current) => current is SignInPageActionState,
          // buildWhen: (previous, current) => current is AuthSignInPageState,
          listener: (context, state) {
            if (state is AuthGoogleSignInSuccess) {
              GoRouter.of(context).goNamed(
                AppRouteConstants.mainPage,
                // pathParameters: {
                //   'initialUsername': state.user.username!,}
              );
            }
            if (state is AuthGoogleSignInFailed) {
              showSnackBar(
                context: context,
                title: 'Oh',
                content: state.message,
                contentType: ContentType.failure,
              );
            }
            if (state is AuthSignInSuccess) {
              GoRouter.of(context).goNamed(AppRouteConstants.mainPage);
            }
            if (state is AuthSignInFailed) {
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
            return ResponsiveAuthentication(
              mobileLayout: _buildSignInMobileLayout(context),
              desktopLayout: _buildSignInTabletDesktopLayout(context),
            );

            //  Stack(
            //   alignment: Alignment.bottomCenter,
            //   children: [
            //     Container(
            //         // decoration: const BoxDecoration(
            //         //   color: AppPallete.primaryAppColor,
            //         // ),
            //         ),
            //     Positioned(
            //       top: 25,
            //       child: ConstrainedBox(
            //           constraints: BoxConstraints.tight(const Size(415, 415)),
            //           child:
            //               Lottie.asset('assets/lotties/sign_in_lottie.json')),
            //     ),
            //     //for aligning the container in the stack ,used the align widget instead of positioned.
            //     // MediaQuery.of(context).size.width > 650 ?
            //     //if the screen width is greater than the value we will build a new align else for the mobile phones
            //     // Align(
            //     //   heightFactor: 2,
            //     //   widthFactor: 2,
            //     //   alignment: screenWidth < 930
            //     //       ? const AlignmentDirectional(0, 1.35)
            //     //       : screenWidth < 1250
            //     //           ? const Alignment(1, 0)
            //     //           : screenWidth < 1650
            //     //               ? const Alignment(2, 0)
            //     //               : const Alignment(3, 0),
            //     //the authentication container for form filling the same will be used in the login page / and sign up page.
            //     // child:
            //     // Positioned(
            //     //   bottom: -50,
            //     //   child: Form(
            //     //     key: signinFormKey,
            //     //     child:
            //     //   ),
            //     // ),

            //   ],
            // );
          },
        ));
  }

  _buildSignInMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 15,
        ),
        Flexible(
          flex: 2,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 415, maxWidth: 415),
            child: Lottie.asset('assets/lotties/sign_in_lottie.json'),
          ),
        ),
        Flexible(
          flex: 3,
          child: _buildSignInAuthenticationContainer(context),
        ),
      ],
    );
  }

  _buildSignInTabletDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 415, maxWidth: 415),
          child: Lottie.asset('assets/lotties/sign_in_lottie.json'),
        ),
        _buildSignInAuthenticationContainer(context),
      ],
    );
  }

  _buildSignInAuthenticationContainer(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 625, maxWidth: 415),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: AuthenticationContainer(
                  // height: 450,
                  title: 'Sign In',
                  columnChildren: [
                    PhoneNumberTextField(
                      errorText: phoneNumberError,
                      countryCode: countryCode,
                      textFormFieldEnabled: true,
                      phoneNumberController: phoneNumberController,
                    ),
                    CustomTextFormField(
                      errorText: passwordError,
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
                              GoRouter.of(context).pushNamed(
                                  AppRouteConstants.forgotPasswordPage);
                            },
                            child: const Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppPallete.primaryAppColor),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).pushReplacementNamed(
                                  AppRouteConstants.signupPage);
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
                    PrimaryAppButton(
                      buttonText: 'Sign in',
                      onPressed: () {
                        setState(() {
                          phoneNumberError = Validator.validatePhoneNumber(
                              phoneNumberController.text);
                          passwordError = Validator.validatePassword(
                              passwordController.text);
                          if (phoneNumberError == null &&
                              passwordError == null &&
                              countryCode.value != '000') {
                            // print('object');
                            fullPhoneNumber =
                                '+${countryCode.value}${phoneNumberController.text}';
                            context.read<AuthBloc>().add(UserSignInEvent(
                                phoneNumber: fullPhoneNumber,
                                password: passwordController.text));
                          }
                        });
                        // print('object');
                      },
                    ),
                    // const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 35,
            child: CircularButton(
              onPressed: () async {
                context.read<AuthBloc>().add(SignInWithGoogleAccount());
              },
              circularButtonChild: SvgPicture.asset(
                AuthConstants.googleIconSVG,
                width: 30,
                height: 30,
              ),
              diameter: 70,
            ),
          ),
        ],
      ),
    );
  }
}
