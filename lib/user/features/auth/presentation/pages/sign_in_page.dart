import 'package:animate_do/animate_do.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/auth_utils.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/core/validators/validators.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/auth/presentation/constants/auth_constants.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/authentication_container.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/authentication_text_form_field.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/phone_number_text_field.dart';
import 'package:tech_haven/user/features/profile/bloc/profile_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

late String fullPhoneNumber;
TextEditingController phoneNumberController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final signinFormKey = GlobalKey<FormState>();
bool passwordIsObscure = true;

class _SignInPageState extends State<SignInPage> {
  @override
  void dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countryCode = AuthUtils.signInCountryCode;
    return Scaffold(
        backgroundColor: AppPallete.primaryAppColor,
        body: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (previous, current) => current is SignInPageActionState,
          buildWhen: (previous, current) => current is AuthSignInPageState,
          listener: (context, state) {
            if (state is AuthSignInSuccess) {
              GoRouter.of(context)
                  .pushReplacementNamed(AppRouteConstants.splashScreen);
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
            return Stack(
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
                  child: Form(
                    key: signinFormKey,
                    child: AuthenticationContainer(
                      height: 450,
                      title: 'Sign In',
                      columnChildren: [
                        PhoneNumberTextField(
                          countryCode: countryCode,
                          textFormFieldEnabled: true,
                          phoneNumberController: phoneNumberController,
                        ),
                        AuthenticationTextFormField(
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
                              milliseconds:
                                  Constants.normalAnimationMilliseconds),
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
                      onPressedElevatedButton: () {
                        print('object');
                        if (signinFormKey.currentState!.validate()  &&
                            countryCode.value != '000') {
                          print('object');
                          fullPhoneNumber =
                              '+${countryCode.value}${phoneNumberController.text}';
                          context.read<AuthBloc>().add(UserSignInEvent(
                              phoneNumber: fullPhoneNumber,
                              password: passwordController.text));
                        }
                      },
                      onPressedTopButton: () {},
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
