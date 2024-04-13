import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/bottomnav/custom_bottom_navigation_bar.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:tech_haven/features/auth/presentation/pages/new_password_page.dart';
import 'package:tech_haven/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:tech_haven/features/auth/presentation/pages/sign_in_page.dart';
import 'package:tech_haven/features/auth/presentation/pages/sign_up_page.dart';
import 'package:tech_haven/features/auth/presentation/pages/sign_up_welcome_page.dart';
import 'package:tech_haven/features/home/presentation/pages/home_page.dart';
import 'package:tech_haven/features/map/presentation/pages/google_map_page.dart';
import 'package:tech_haven/features/message/presentation/pages/message_page.dart';

class AppRoutes {
  static GoRouter goRouter = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      _buildPageRoute(
        name: AppRouteConstants.welcomePage,
        path: '/',
        child: const CustomBottomNavigationBar(),
      ),
      _buildPageRoute(
        name: AppRouteConstants.signupPage,
        path: '/signup_page',
        child: const SignUpPage(),
      ),
      _buildPageRoute(
        name: AppRouteConstants.signinPage,
        path: '/signin_page',
        child: const SignInPage(),
      ),
      _buildPageRoute(
        name: AppRouteConstants.forgotPasswordPage,
        path: '/forgot_password_page',
        child: const ForgotPasswordPage(),
      ),
      _buildPageRouteWithParams(
        name: AppRouteConstants.otpVerificationPage,
        path: '/otp_verification_page/:verificationId',
        pageBuilder: (state) => OTPVerificationPage(
          verificaionId: state.pathParameters['verificationId']!,
        ),
      ),
      _buildPageRoute(
        name: AppRouteConstants.newPasswordPage,
        path: '/new_password_page',
        child: const NewPasswordPage(),
      ),
      _buildPageRouteWithParams(
        name: AppRouteConstants.signupWelcomePage,
        path: '/sign_up_welcome_page/:initialUsername',
        pageBuilder: (state) => SignUpWelcomePage(
          initialUsername: state.pathParameters['initialUsername']!,
        ),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (animation, child) {
          final tween = Tween(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return SlideTransition(
            position: tween,
            child: child,
          );
        },
      ),
      _buildPageRoute(
        name: AppRouteConstants.googleMapPage,
        path: '/google_map_page',
        child: const GoogleMapPage(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (animation, child) {
          final tween = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return SlideTransition(
            position: tween,
            child: child,
          );
        },
      ),
      _buildPageRoute(
        name: AppRouteConstants.mainPage,
        path: '/main_page',
        child: const CustomBottomNavigationBar(),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (animation, child) {
          final tween = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return SlideTransition(
            position: tween,
            child: child,
          );
        },
      ),
      _buildPageRoute(
        name: AppRouteConstants.homePage,
        path: '/home_page',
        child: const HomePage(),
      ),
      _buildPageRoute(
        name: AppRouteConstants.messagePage,
        path: '/message_page',
        child: const MessagePage(),
        transitionsBuilder: (animation, child) {
          final tween = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return SlideTransition(
            position: tween,
            child: child,
          );
        },
      ),
    ],
  );

  static GoRoute _buildPageRoute({
    required String name,
    required String path,
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 250),
    Widget Function(Animation<double>, Widget)? transitionsBuilder,
  }) {
    return GoRoute(
      name: name,
      path: path,
      pageBuilder: (context, state) => _buildCustomTransitionPage(
        state.pageKey,
        child,
        transitionDuration,
        transitionsBuilder,
      ),
    );
  }

  static GoRoute _buildPageRouteWithParams({
    required String name,
    required String path,
    required Widget Function(GoRouterState) pageBuilder,
    Duration transitionDuration = const Duration(milliseconds: 250),
    Widget Function(Animation<double>, Widget)? transitionsBuilder,
  }) {
    return GoRoute(
      name: name,
      path: path,
      pageBuilder: (context, state) => _buildCustomTransitionPage(
        state.pageKey,
        pageBuilder(state),
        transitionDuration,
        transitionsBuilder,
      ),
    );
  }

  static CustomTransitionPage _buildCustomTransitionPage(
    LocalKey? key,
    Widget child,
    Duration transitionDuration,
    Widget Function(Animation<double>, Widget)? transitionsBuilder,
  ) {
    return CustomTransitionPage(
      transitionDuration: transitionDuration,
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (transitionsBuilder != null) {
          return transitionsBuilder(animation, child);
        } else {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeIn).animate(animation),
            child: child,
          );
        }
      },
    );
  }
}

// class AppRoutes {
//   static GoRouter goRouter = GoRouter(
//     debugLogDiagnostics: true,
//     routes: [
//       GoRoute(
//         name: AppRouteConstants.welcomePage,
//         path: '/',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             opaque: false,
//             fullscreenDialog: true,
//             transitionDuration: const Duration(milliseconds: 250),
//             key: state.pageKey,
//             child: const CustomBottomNavigationBar(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               return FadeTransition(
//                 opacity: CurveTween(
//                   curve: Curves.easeIn,
//                 ).animate(animation),
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//       GoRoute(
//         name: AppRouteConstants.signupPage,
//         path: '/signup_page',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 250),
//             key: state.pageKey,
//             child: const SignUpPage(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               return FadeTransition(
//                 opacity: CurveTween(
//                   curve: Curves.easeIn,
//                 ).animate(animation),
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//       GoRoute(
//         name: AppRouteConstants.signinPage,
//         path: '/signin_page',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 250),
//             key: state.pageKey,
//             child: const SignInPage(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               return FadeTransition(
//                 opacity: CurveTween(
//                   curve: Curves.easeIn,
//                 ).animate(animation),
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//       GoRoute(
//         name: AppRouteConstants.forgotPasswordPage,
//         path: '/forgot_password_page',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 250),
//             key: state.pageKey,
//             child: const ForgotPasswordPage(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               return FadeTransition(
//                 opacity: CurveTween(
//                   curve: Curves.easeIn,
//                 ).animate(animation),
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//       GoRoute(
//         name: AppRouteConstants.otpVerificationPage,
//         path: '/otp_verification_page/:verificationId',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 250),
//             key: state.pageKey,
//             child: OTPVerificationPage(
//               verificaionId: state.pathParameters['verificationId']!,
//             ),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               return FadeTransition(
//                 opacity: CurveTween(
//                   curve: Curves.easeIn,
//                 ).animate(animation),
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//       GoRoute(
//         name: AppRouteConstants.newPasswordPage,
//         path: '/new_password_page',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 250),
//             key: state.pageKey,
//             child: const NewPasswordPage(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               return FadeTransition(
//                 opacity: CurveTween(
//                   curve: Curves.easeIn,
//                 ).animate(animation),
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//       GoRoute(
//         name: AppRouteConstants.signupWelcomePage,
//         path: '/sign_up_welcome_page/:initialUsername',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 500),
//             key: state.pageKey,
//             child: SignUpWelcomePage(
//               initialUsername: state.pathParameters['initialUsername']!,
//             ),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               final tween = Tween(
//                 begin: const Offset(0, -1),
//                 end: Offset.zero,
//               ).animate(
//                 CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//               );
//               return SlideTransition(
//                 position: tween,
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//       GoRoute(
//         name: AppRouteConstants.googleMapPage,
//         path: '/google_map_page',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 500),
//             key: state.pageKey,
//             child: const GoogleMapPage(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               final tween = Tween(
//                 begin: const Offset(1, 0),
//                 end: Offset.zero,
//               ).animate(
//                 CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//               );
//               return SlideTransition(
//                 position: tween,
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//       GoRoute(
//         name: AppRouteConstants.mainPage,
//         path: '/main_page',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 500),
//             key: state.pageKey,
//             child: const CustomBottomNavigationBar(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               final tween = Tween(
//                 begin: const Offset(1, 0),
//                 end: Offset.zero,
//               ).animate(
//                 CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//               );
//               return SlideTransition(
//                 position: tween,
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//       GoRoute(
//         name: AppRouteConstants.homePage,
//         path: '/home_page',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 250),
//             key: state.pageKey,
//             child: const HomePage(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               return FadeTransition(
//                 opacity: CurveTween(
//                   curve: Curves.easeIn,
//                 ).animate(animation),
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//       GoRoute(
//         name: AppRouteConstants.messagePage,
//         path: '/message_page',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 250),
//             key: state.pageKey,
//             child: const MessagePage(),
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               final tween = Tween(
//                 begin: const Offset(0, -1),
//                 end: Offset.zero,
//               ).animate(
//                 CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//               );
//               return SlideTransition(
//                 position: tween,
//                 child: child,
//               );
//             },
//           );
//         },
//       ),
//     ],
//   );
// }

class MyCustomRouteTransition extends PageRouteBuilder {
  final Widget route;
  MyCustomRouteTransition({required this.route})
      : super(
          transitionDuration: const Duration(milliseconds: 5000),
          pageBuilder: (context, animation, secondaryAnimation) {
            return route;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            );
            return SlideTransition(
              position: tween,
              child: child,
            );
          },
        );
}
