import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class SignUpWelcomePage extends StatelessWidget {
  const SignUpWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(40),
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'WELCOME !',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
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
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        spreadRadius: Constants.globalBoxBlur.spreadRadius,
                        blurRadius: Constants.globalBoxBlur.blurRadius,
                        color: AppPallete.primaryAppColor,)
                  ],),
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppPallete.darkgreyColor,
                  ),
                  child: const Icon(
                    Icons.person,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: CircularButton(
                    onPressed: () {},
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

          const TextField(
            decoration: InputDecoration(hintText: 'Enter your Name'),
          ),
          // const Spacer(),
          const SizedBox(
            height: 50,
          ),
          PrimaryAppButton(
            buttonText: 'Save',
            onPressed: () {
              GoRouter.of(context).pushNamed(AppRouteConstants.googleMapPage);
            },
          ),
        ],
      ),
    ));
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