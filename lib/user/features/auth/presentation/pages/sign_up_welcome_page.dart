import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/get_random_color.dart';
import 'package:tech_haven/core/utils/pick_image.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/sign_up_welcome_page.dart';

class SignUpWelcomePage extends StatelessWidget {
  final String initialUsername;
  const SignUpWelcomePage({super.key, required this.initialUsername});

  // final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> username = ValueNotifier(initialUsername);
    ValueNotifier<File?> image = ValueNotifier(null);

    // File? image;
    void selectImage() async {
      final pickedImage = await pickImage();
      if (pickedImage != null) {
        image.value = pickedImage;
      }
    }

    final Color userColor = getRandomColor();
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        // listenWhen: (previous, current) =>
        //     current is SignUpWelcomePageActionState,
        // buildWhen: (previous, current) => current is AuthSignUpWelcomPageState,
        listener: (context, state) {
          if (state is AuthIsUserLoggedInSuccess) {
            context.read<AuthBloc>().add(
                  SignUpWelcomePageProfileUploadEvent(
                    uid: state.user.uid!,
                    isProfilePhotoUploaded: image.value != null,
                    image: image.value,
                    username: username.value,
                    color: userColor.value,
                  ),
                );
          }
          if (state is AuthIsUserLoggedInFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
          }
          if (state is CreateUserSuccess) {
            GoRouter.of(context).pushNamed(AppRouteConstants.mainPage);
          }
          if (state is CreateUserFailed) {
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
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(40),
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  valueListenable: username,
                  builder: (context, value, child) {
                    return Text(
                      'WELCOME ${username.value}!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w800),
                    );
                  },
                ),
                const Text('upload your image and enter your name below.'),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius:
                                  Constants.globalBoxBlur.spreadRadius,
                              blurRadius: Constants.globalBoxBlur.blurRadius,
                              color: AppPallete.primaryAppColor,
                            ),
                          ],
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: image,
                        builder: (context, value, child) {
                          return Container(
                            alignment: Alignment.center,
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: userColor,
                                image: image.value == null
                                    ? null
                                    : DecorationImage(
                                        image: FileImage(image.value!),
                                      )),
                            child: image.value == null
                                ? ValueListenableBuilder(
                                    valueListenable: username,
                                    builder: (context, value, child) {
                                      return Text(
                                        username.value.split('').first,
                                        style: const TextStyle(
                                          fontSize: 100,
                                        ),
                                      );
                                    })
                                : const SizedBox(),
                          );
                        },
                        // child:
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircularButton(
                          onPressed: () async {
                            //select an image from the gallery and show
                            selectImage();
                          },
                          circularButtonChild: const Icon(
                            Icons.camera_alt,
                            color: AppPallete.whiteColor,
                          ),
                          diameter: 50,
                        ),
                      ),
                    ],
                  ),
                ),

                // const Spacer(),
                const SizedBox(
                  height: 50,
                ),

                TextFormField(
                  initialValue: initialUsername,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      username.value = value;
                    } else {
                      username.value = initialUsername;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your UserName',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                PrimaryAppButton(
                  buttonText: 'Save',
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          CreateUserEvent(
                            username: username.value,
                            image: image.value,
                            color: userColor.value,
                          ),
                        );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class SplashAnimation extends StatefulWidget {
//   const SplashAnimation({super.key});

//   @override
//   State<SplashAnimation> createState() => _SplashAnimationState();
// }

// class _SplashAnimationState extends State<SplashAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );

//     controller.addListener(() {
//       if (controller.isCompleted) {
//         Navigator.of(context).push(
//           MyCustomRouteTransition(
//             route: const Destination(),
//           ),
//         );

//         Timer(const Duration(milliseconds: 500), () {
//           controller.reset();
//         });
//       }
//     });

//     scaleAnimation = Tween<double>(begin: 1, end: 10).animate(controller);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             controller.forward();
//           },
//           child: ScaleTransition(
//             scale: scaleAnimation,
//             child: Container(
//               width: 100,
//               height: 100,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Destination extends StatelessWidget {
//   const Destination({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: const Text('Go Back'),
//       ),
//     );
//   }
// }

// class MyCustomRouteTransition extends PageRouteBuilder {
//   final Widget route;
//   MyCustomRouteTransition({required this.route})
//       : super(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return route;
//           },
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             final tween = Tween(
//               begin: const Offset(0, -1),
//               end: Offset.zero,
//             ).animate(
//               CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//             );
//             return SlideTransition(
//               position: tween,
//               child: child,
//             );
//           },
//         );
// }