import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/features/cart/presentation/pages/cart_page.dart';
import 'package:tech_haven/features/home/presentation/pages/home_page.dart';
import 'package:tech_haven/features/notification/presentation/pages/main_notification_page.dart';
import 'package:tech_haven/features/profile/presentation/pages/profile_page.dart';
import 'package:tech_haven/features/searchcategory/presentation/pages/search_category_page.dart';

class Constants {
  static const globalBoxBlur = BoxShadow(
    color: AppPallete.appShadowColor,
    blurStyle: BlurStyle.normal,
    blurRadius: 15,
  );
  static const int normalAnimationMilliseconds = 1000;
  static const double buttonTextFontSize = 15;

  static List<Widget> listOFMainPages = [
    const HomePage(),
    const SearchCategoryPage(),
    const MainNotificationPage(),
    const ProfilePage(),
    const CartPage(),
  ];

  static const noConnectionErrorMessage = 'Not connected to the network';
}
