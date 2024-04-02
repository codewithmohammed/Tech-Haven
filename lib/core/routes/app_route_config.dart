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

class AppRoutes {
  static GoRouter goRouter = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: AppRouteConstants.welcomePage,
        path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            opaque: false,
            fullscreenDialog: true,
            transitionDuration: const Duration(milliseconds: 250),
            key: state.pageKey,
            child: const CustomBottomNavigationBar(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(
                  curve: Curves.easeIn,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.signupPage,
        path: '/signup_page',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 250),
            key: state.pageKey,
            child: const SignUpPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(
                  curve: Curves.easeIn,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.signinPage,
        path: '/signin_page',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 250),
            key: state.pageKey,
            child: const SignInPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(
                  curve: Curves.easeIn,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.forgotPasswordPage,
        path: '/forgot_password_page',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 250),
            key: state.pageKey,
            child: const ForgotPasswordPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(
                  curve: Curves.easeIn,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.otpVerificationPage,
        path: '/otp_verification_page/:verificationId',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 250),
            key: state.pageKey,
            child: OTPVerificationPage(
              verificaionId: state.pathParameters['verificationId']!,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(
                  curve: Curves.easeIn,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.newPasswordPage,
        path: '/new_password_page',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 250),
            key: state.pageKey,
            child: const NewPasswordPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(
                  curve: Curves.easeIn,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.signupWelcomePage,
        path: '/sign_up_welcome_page/:initialUsername',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 500),
            key: state.pageKey,
            child: SignUpWelcomePage(
              initialUsername: state.pathParameters['initialUsername']!,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
        },
      ),
      GoRoute(
        name: AppRouteConstants.googleMapPage,
        path: '/google_map_page',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 500),
            key: state.pageKey,
            child: const GoogleMapPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.mainPage,
        path: '/main_page',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 500),
            key: state.pageKey,
            child: const CustomBottomNavigationBar(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
          );
        },
      ),
      GoRoute(
        name: AppRouteConstants.homePage,
        path: '/home_page',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 250),
            key: state.pageKey,
            child: const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(
                  curve: Curves.easeIn,
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
}

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
