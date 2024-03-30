import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      fontFamily: 'BeVietnamPro',

      // brightness: Brightness.light,
      primaryColor: AppPallete.primaryAppColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppPallete.primaryAppButtonColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              AppPallete.primaryAppButtonColor),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              AppPallete.primaryAppButtonColor),
        ),
      )
      // inputDecorationTheme: InputDecorationTheme(
      //   border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(20.0),
      //       borderSide: BorderSide.none),
      //   filled: true,
      //   fillColor: Colors.grey.withOpacity(
      //     0.1,
      //   ),
      // ),
      );

  static ThemeData darkTheme = ThemeData(
      fontFamily: 'BeVietnamPro',

      // brightness: Brightness.light,
      primaryColor: AppPallete.primaryAppColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppPallete.primaryAppButtonColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              AppPallete.primaryAppButtonColor),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              AppPallete.primaryAppButtonColor),
        ),
      )
      // inputDecorationTheme: InputDecorationTheme(
      //   border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(20.0),
      //       borderSide: BorderSide.none),
      //   filled: true,
      //   fillColor: Colors.grey.withOpacity(
      //     0.1,
      //   ),
      // ),
      );
}
