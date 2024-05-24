// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/pages/bottomnav/user_bottom_navigation_bar.dart';
import 'package:tech_haven/core/common/pages/bottomnav/vendor_bottom_navigation_bar.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/new_password_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/sign_in_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/sign_up_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/sign_up_welcome_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/welcome_page.dart';
import 'package:tech_haven/user/features/checkout/presentation/pages/checkout_page.dart';
import 'package:tech_haven/user/features/details/presentation/pages/details_page.dart';
import 'package:tech_haven/user/features/favorite/presentation/pages/favorite_page.dart';
import 'package:tech_haven/user/features/home/presentation/pages/home_page.dart';
import 'package:tech_haven/user/features/map/presentation/pages/google_map_page.dart';
import 'package:tech_haven/user/features/message/presentation/pages/message_page.dart';
import 'package:tech_haven/core/common/pages/splash/presentation/pages/splash_page.dart';
import 'package:tech_haven/user/features/search/presentation/pages/search_page.dart';
import 'package:tech_haven/vendor/features/message/presentation/pages/vendor_chat_page.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/pages/register_product_page.dart';

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
        child: const GoogleMapPage(
          isForCheckout: false,
        ),
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
      // _buildPageRoute(
      //   name: AppRouteConstants.checkoutPage,
      //   path: '/checkout_page/:totalAmount',
      //   child: const CheckoutPage(totalAmount: ,),
      // ),
      _buildPageRouteWithParams(
        name: AppRouteConstants.checkoutPage,
        path:
            '/checkout_page/:totalAmount',
        pageBuilder: (state) => CheckoutPage(
         totalAmount: state.pathParameters['totalAmount']!,
        ),
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
      _buildPageRouteWithParams(
        name: AppRouteConstants.detailsPage,
        path: '/details_page',
        pageBuilder: (state) {
          Product product = state.extra as Product;
          // String? cartID = extra[1];
          // String? favoriteID = extra[2];
          return DetailsPage(
            product: product,
            // cartID:cartID ,
            // favoriteID: favoriteID,
          );
        },
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
        name: AppRouteConstants.favoritePage,
        path: '/favorite_page',
        child: const FavoritePage(),
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
      _buildPageRouteWithParams(
        name: AppRouteConstants.registerProductPage,
        path: '/register_product_page',
        pageBuilder: (state) {
          Product? product = state.extra as Product?;
          return RegisterProductPage(product: product);
        },
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
      // _buildPageRoute(
      //   name: AppRouteConstants.registerProductPage,
      //   path: '/register_product_page:/product',
      //   child:  RegisterProductPage(product: ),
      //   transitionsBuilder:
      // ),
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
