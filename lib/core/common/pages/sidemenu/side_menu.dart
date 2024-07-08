import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/bloc/common_bloc.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/pages/sidemenu/widgets/info_card.dart';
import 'package:tech_haven/core/common/pages/sidemenu/widgets/animated_side_menu_tile.dart';
import 'package:tech_haven/core/common/pages/sidemenu/widgets/side_bar_title.dart';
import 'package:tech_haven/core/common/pages/sidemenu/widgets/side_menu_tile.dart';
import 'package:tech_haven/core/common/widgets/phone_number_text_field.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/rive/rive_nav_utils.dart';
import 'package:tech_haven/core/rive/rive_assets.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';

// import 'path/to/common_bloc.dart';
// import 'path/to/common_state.dart';
// import 'path/to/common_event.dart';
// import 'path/to/app_pallete.dart';
// import 'path/to/info_card.dart';
// import 'path/to/side_bar_title.dart';
// import 'path/to/animated_side_menu_tile.dart';
// import 'path/to/side_menu_tile.dart';
// import 'path/to/rive_nav_utils.dart';
// import 'path/to/rive_asset.dart';
class SideMenu extends StatefulWidget {
  const SideMenu({super.key});
  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  // @override
  // void initState() {

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    context.read<CommonBloc>().add(LoadUserDataEventForCommon());
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: AppPallete.primaryAppColor,
        child: SafeArea(
          child: BlocConsumer<CommonBloc, CommonState>(
            buildWhen: (previous, current) =>
                current is LoadUserDataCommonState,
            listener: (context, state) {
              // Handle side effects like showing a snack bar or navigation
            },
            builder: (context, state) {
              if (state is LoadUserDataCommonSuccessState) {
                final user = state.user;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCard(
                      imageURL: user.profilePhoto,
                      name: user.username ?? "No Name",
                      email: user.email ?? "No Email",
                      onTapSettingIcon: () {
                        GoRouter.of(context)
                            .pushNamed(AppRouteConstants.profileEditPage);
                      },
                    ),
                    const SideBarTitle(
                      title: "Browse",
                    ),
                    ...List.generate(browseSideMenus.length, (index) {
                      final menu = browseSideMenus[index].riveAsset;
                      return ValueListenableBuilder<RiveAsset>(
                        valueListenable: RiveNavUtils.selectedSideBarBrowser,
                        builder: (context, value, child) {
                          return ValueListenableBuilder<int>(
                            valueListenable: RiveNavUtils.selectedSideBarTotal,
                            builder: (context, value, child) {
                              return AnimatedSideMenuTile(
                                menu: menu,
                                riveonInit: (artboard) {
                                  RiveNavUtils.riveOnInItForSideMenu(
                                      index, artboard);
                                },
                                press: () {
                                  RiveNavUtils.animateTheIconForSideMenu(index);
                                },
                                isActive: RiveNavUtils
                                            .selectedSideBarBrowser.value ==
                                        menu &&
                                    RiveNavUtils.selectedSideBarTotal.value ==
                                        index,
                              );
                            },
                          );
                        },
                      );
                    }),
                    const SideBarTitle(
                      title: "Profile",
                    ),
                    ...List.generate(profileSideMenus.length, (index) {
                      final menu = profileSideMenus[index];
                      return ValueListenableBuilder<int>(
                        valueListenable: RiveNavUtils.selectedSideBarTotal,
                        builder: (context, value, child) {
                          // print(state.user.phoneNumber);
                          return (index + 3 == 4 &&
                                  state.user.phoneNumber != null)
                              ? const SizedBox.shrink()
                              : (!state.user.isVendor && index + 3 == 5)
                                  ? SideMenuTile(
                                      isActive:
                                          RiveNavUtils
                                                      .selectedSideBarTotal
                                                      .value ==
                                                  index + 3,
                                      onTap: () {
                                        if (state.user.phoneNumber == null) {
                                          return _showPhoneVerificationDialog(
                                              context);
                                        }
                                        GoRouter.of(context).pushNamed(
                                            AppRouteConstants
                                                .registerVendorPage,
                                            extra: state.user);
                                      },
                                      title: 'Start Selling',
                                      icon: CustomIcons.cartSvg)
                                  : SideMenuTile(
                                      isActive: (state.user.phoneNumber != null &&
                                                  RiveNavUtils
                                                          .selectedSideBarTotal
                                                          .value ==
                                                      4 &&
                                                  index + 3 == 6)
                                              ? true
                                              : RiveNavUtils
                                              .selectedSideBarTotal.value ==
                                          index + 3,
                                      onTap: () {
                                        // print(state.user.phoneNumber == null &&
                                        //     RiveNavUtils.selectedSideBarTotal
                                        //             .value ==
                                        //         4 &&
                                        //     index + 3 == 6);
                                        // print(RiveNavUtils
                                        //     .selectedSideBarTotal.value);
                                        // print(index + 3);
                                        // print(state.user.phoneNumber != null &&
                                        //     RiveNavUtils.selectedSideBarTotal
                                        //             .value ==
                                        //         4);
                                        if (state.user.isVendor &&
                                            index + 3 == 5) {
                                          GoRouter.of(context).pushNamed(
                                              AppRouteConstants.vendorMainPage);
                                          return;
                                        }
                                        if (state.user.phoneNumber != null &&
                                            index + 3 == 6) {
                                          print('object');
                                          RiveNavUtils
                                              .selectedSideBarTotal.value = 4;
                                          return;
                                        }
                                        if (index + 3 == 7) {
                                          showConfirmationDialog(
                                              context,
                                              'Sign Out',
                                              'Are you sure you want to sign out',
                                              () {
                                            FirebaseAuth.instance.signOut();
                                            GoRouter.of(context).goNamed(
                                                AppRouteConstants.splashScreen);
                                          });
                                          return;
                                        }
                                        RiveNavUtils.selectedSideBarTotal
                                            .value = index + 3;
                                      },
                                      title: menu.title,
                                      icon: menu.icon,
                                    );
                        },
                      );
                    }),
                  ],
                );
              } else if (state is LoadUserDataCommonFailedState) {
                return Center(
                  child: Text('Failed to load user data: ${state.message}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

ValueNotifier<String> _countryCode = ValueNotifier('000');
void _showPhoneVerificationDialog(BuildContext context) {
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Verify Phone Number',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: PhoneNumberTextField(
                countryCode: _countryCode,
                textFormFieldEnabled: true,
                phoneNumberController: phoneController,
              ),
            )
          ],
        ),
        actions: [
          RoundedRectangularButton(
            title: 'Verify',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                String phoneNumber =
                    '+${_countryCode.value}${phoneController.text}';
                // Implement verification logic here
                // context.read<ProfileBloc>().add(SendOTPForGoogleLoginEvent(
                //       phoneNumber: phoneNumber,
                //     ));
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
