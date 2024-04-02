import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tech_haven/core/common/bottomnav/utils/bottom_nav_utils.dart';
import 'package:tech_haven/core/common/widgets/animated_bar.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/rive/rive_assets.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  // RiveAsset selectedBottomNav = bottonNavs[0].riveAsset;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: true,
        body: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          itemCount: Constants.listOFMainPages.length,
          // controller: ,
          itemBuilder: (context, index) {
            return Constants.listOFMainPages[index];
          },
          onPageChanged: (index) {
            BottomNavUtils.animateTheIcon(index);
          },
        ),
        bottomNavigationBar: Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.all(
            10,
          ),
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 14),
          decoration: const BoxDecoration(
            color: AppPallete.primaryAppButtonColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                24,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppPallete.primaryAppColor,
                blurStyle: BlurStyle.normal,
                blurRadius: 15,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              bottonNavs.length,
              (index) {
                final riveIcon = bottonNavs[index].riveAsset;
                return ValueListenableBuilder(
                  valueListenable: BottomNavUtils.selectedBottomNav,
                  builder: (BuildContext context, value, Widget? child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBar(
                          isActive: riveIcon ==
                              BottomNavUtils.selectedBottomNav.value,
                        ),
                        CircularButton(
                          onPressed: () {
                            BottomNavUtils.animateTheIcon(index);

                            pageController.jumpToPage(index);

                            // animateToPage(
                            //   index,
                            //   duration: const Duration(milliseconds: 1000),
                            //   curve: Curves.easeInOut,
                            // );
                          },
                          shadow: false,
                          circularButtonChild: Opacity(
                            opacity: riveIcon ==
                                    BottomNavUtils.selectedBottomNav.value
                                ? 1
                                : 0.5,
                            child: RiveAnimation.asset(
                              riveIcon.src,
                              artboard: riveIcon.artboard,
                              onInit: (artboard) {
                                BottomNavUtils.riveOnInIt(index, artboard);
                              },
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
      ),
    );
  }
}
