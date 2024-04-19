import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_haven/core/pages/bottomnav/user_bottom_navigation_bar.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/sign_up_page.dart';
import 'package:tech_haven/user/features/auth/presentation/pages/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   checkUserLoggedIn();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const UserBottomNavigationBar();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SafeArea(
              child: Center(
                child: FadeIn(
                  duration: const Duration(
                    seconds: 2,
                  ),
                  child: Image.asset(
                    'assets/logo/techHavenLogo.png',
                    scale: 15,
                  ),
                ),
              ),
            ),
          );
        }
        return const WelcomePage();
      },
    ));
  }
}
