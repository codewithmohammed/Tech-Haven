import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/cart/presentation/pages/cart_page.dart';
import 'package:tech_haven/user/features/home/presentation/pages/home_page.dart';
import 'package:tech_haven/user/features/notification/presentation/pages/main_notification_page.dart';
import 'package:tech_haven/user/features/profile/presentation/pages/user_profile_page.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/pages/search_category_page.dart';
import 'package:tech_haven/vendor/features/manageproduct/presentation/pages/manage_product_page.dart';
import 'package:tech_haven/vendor/features/moneywithdraw/presentation/pages/money_withdraw_page.dart';
import 'package:tech_haven/vendor/features/order/presentation/pages/vendor_order_page.dart';
import 'package:tech_haven/vendor/features/profile/presentation/pages/vendor_profile_page.dart';

class Constants {
  static const String techHavenLogo = 'assets/logo/techHavenLogo.png';
  static const String techHavenLogoHR = 'assets/logo/techHavenLogoHR.png';

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
    const UserProfilePage(),
    const CartPage(),
  ];

  static List<Widget> listOFVendorPages = [
    const MoneyWithdrawalPage(),
    const ManageProductPage(),
    const VendorProfilePage(),
    const VendorOrderPage(),
  ];

  static List<String> vendorListOfIcons = [
    CustomIcons.dollarSvg,
    CustomIcons.penSvg,
    CustomIcons.userCircleSvg,
    CustomIcons.cartSvg,
  ];

  static const noConnectionErrorMessage = 'Not connected to the network';
  static const Widget kHeight = SizedBox(
    height: 10,
  );
  static const Widget kWidth = SizedBox(
    width: 20,
  );
}
