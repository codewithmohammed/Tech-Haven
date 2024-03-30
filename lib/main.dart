import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/routes/app_route_config.dart';
import 'package:tech_haven/core/theme/theme.dart';
import 'package:tech_haven/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/firebase_options.dart';
import 'package:tech_haven/init_dependencies.main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeAnimationDuration: const Duration(milliseconds: 500),
      themeAnimationCurve: Curves.easeOut,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      title: 'Tech Haven',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
      routeInformationParser: AppRoutes.goRouter.routeInformationParser,
      routerDelegate: AppRoutes.goRouter.routerDelegate,
    );
  }
}
