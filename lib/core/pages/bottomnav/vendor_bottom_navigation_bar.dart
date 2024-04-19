import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/animated_bar.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/icons/icons.dart';
import 'package:tech_haven/core/pages/bottomnav/utils/bottom_nav_utils.dart';
import 'package:tech_haven/core/pages/bottomnav/widgets/bottom_navigation_bar_container.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class VendorBottomNavigationBar extends StatelessWidget {
  const VendorBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {},
          child: const SvgIcon(
            icon: CustomIcons.plusSvg,
            radius: 20,
          ),
        ),
        body: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          itemCount: Constants.listOFVendorPages.length,
          itemBuilder: (context, index) {
            return Constants.listOFVendorPages[index];
          },
        ),
        bottomNavigationBar: BottomNavigationBarContainer(
          children: List.generate(
            Constants.vendorListOfIcons.length,
            (index) {
              // final icon = BottomNavUtils.selectedBottomNavVendor.value;
              return ValueListenableBuilder(
                valueListenable: BottomNavUtils.selectedBottomNavVendor,
                builder: (BuildContext context, value, Widget? child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(
                        isActive:
                            BottomNavUtils.selectedBottomNavVendor.value ==
                                Constants.vendorListOfIcons[index],
                      ),
                      CircularButton(
                        onPressed: () {
                          BottomNavUtils.selectedBottomNavVendor.value =
                              Constants.vendorListOfIcons[index];
                          pageController.jumpToPage(index);
                        },
                        shadow: false,
                        circularButtonChild: Opacity(
                          opacity: Constants.vendorListOfIcons[index] ==
                                  BottomNavUtils.selectedBottomNavVendor.value
                              ? 1
                              : 0.5,
                          child: SvgIcon(
                            icon: Constants.vendorListOfIcons[index],
                            radius: 25,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                        diameter: 45,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
