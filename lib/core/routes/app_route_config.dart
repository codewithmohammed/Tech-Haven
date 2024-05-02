import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/pages/bottomnav/user_bottom_navigation_bar.dart';
import 'package:tech_haven/core/common/pages/bottomnav/vendor_bottom_navigation_bar.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/new_password_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/sign_in_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/sign_up_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/sign_up_welcome_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/welcome_page.dart';
import 'package:tech_haven/user/features/details/presentation/pages/details_page.dart';
import 'package:tech_haven/user/features/home/presentation/pages/home_page.dart';
import 'package:tech_haven/user/features/map/presentation/pages/google_map_page.dart';
import 'package:tech_haven/user/features/message/presentation/pages/message_page.dart';
import 'package:tech_haven/core/common/pages/splash/presentation/pages/splash_page.dart';
import 'package:tech_haven/user/features/search/presentation/pages/search_page.dart';
import 'package:tech_haven/vendor/features/message/presentation/pages/vendor_chat_page.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/pages/register_product_page.dart';

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
//             child: const SplashScreen(),
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
//         path:  '/otp_verification_page/:phoneNumber/:email/:password/:verificationID',
//         pageBuilder: (context, state) {
//           return CustomTransitionPage(
//             transitionDuration: const Duration(milliseconds: 250),
//             key: state.pageKey,
//             child: OTPVerificationPage(
//               phoneNumber: state.pathParameters['phoneNumber']!,
//               email: state.pathParameters['email']!,
//               password: state.pathParameters['password']!,
//               verificaionID: state.pathParameters['verificationID']!,
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
class AppRoutes {
  // static GoRouter returnRouter(bool isAuth) {
  static GoRouter goRouter = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      _buildPageRoute(
          name: AppRouteConstants.splashScreen,
          path: '/',
          child: const SplashScreen()),
      _buildPageRoute(
        name: AppRouteConstants.welcomePage,
        path: '/welcome_page',
        child: const WelcomePage(),
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
        path:
            '/otp_verification_page/:phoneNumber/:email/:password/:verificationID',
        pageBuilder: (state) => OTPVerificationPage(
          phoneNumber: state.pathParameters['phoneNumber']!,
          email: state.pathParameters['email']!,
          password: state.pathParameters['password']!,
          verificaionID: state.pathParameters['verificationID']!,
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
        child: const UserBottomNavigationBar(),
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
      _buildPageRoute(
        name: AppRouteConstants.detailsPage,
        path: '/details_page',
        child: const DetailsPage(),
      ),
      _buildPageRoute(
          name: AppRouteConstants.vendorMainPage,
          path: '/vendor_main_page',
          child: const VendorBottomNavigationBar()),
      _buildPageRoute(
        name: AppRouteConstants.vendorChatPage,
        path: '/vendor_chat_page',
        child: const VendorChatPage(),
      ),
      _buildPageRoute(
        name: AppRouteConstants.searchPage,
        path: '/search_page',
        child: const SearchPage(),
        transitionsBuilder: (animation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1), // Slide from bottom to top
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
      _buildPageRoute(
        name: AppRouteConstants.registerProductPage,
        path: '/register_product_page',
        child:  RegisterProductPage(),
        transitionsBuilder: (animation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1), // Slide from bottom to top
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
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



// class MyCustomRouteTransition extends PageRouteBuilder {
//   final Widget route;
//   MyCustomRouteTransition({required this.route})
//       : super(
//           transitionDuration: const Duration(milliseconds: 5000),
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
