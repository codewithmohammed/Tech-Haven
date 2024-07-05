import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/pages/sidemenu/widgets/info_card.dart';
import 'package:tech_haven/core/common/pages/sidemenu/widgets/animated_side_menu_tile.dart';
import 'package:tech_haven/core/common/pages/sidemenu/widgets/side_bar_title.dart';
import 'package:tech_haven/core/common/pages/sidemenu/widgets/side_menu_tile.dart';
import 'package:tech_haven/core/rive/rive_nav_utils.dart';
import 'package:tech_haven/core/rive/rive_assets.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});
  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: AppPallete.primaryAppColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                name: " Mohammed Rayid",
                profession: "Flutter Dev",
                onTapSettingIcon: () {},
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
                            isActive:
                                RiveNavUtils.selectedSideBarBrowser.value ==
                                        menu &&
                                    RiveNavUtils.selectedSideBarTotal.value ==
                                        index,
                          );
                        });
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
                      return SideMenuTile(
                        isActive: RiveNavUtils.selectedSideBarTotal.value ==
                            index + 3,
                        onTap: () {
                          RiveNavUtils.selectedSideBarTotal.value = index + 3;
                        },
                        title: menu.title,
                        icon: menu.icon,
                      );
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
