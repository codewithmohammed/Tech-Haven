import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tech_haven/core/pages/bottomnav/utils/bottom_nav_utils.dart';
import 'package:tech_haven/core/common/widgets/animated_bar.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/pages/bottomnav/widgets/bottom_navigation_bar_container.dart';
import 'package:tech_haven/core/rive/rive_assets.dart';

class UserBottomNavigationBar extends StatelessWidget {
  const UserBottomNavigationBar({super.key});

  // RiveAsset selectedBottomNav = bottonNavs[0].riveAsset;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
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
        bottomNavigationBar: BottomNavigationBarContainer(
          children: List.generate(
            bottonNavs.length,
            (index) {
              final riveIcon = bottonNavs[index].riveAsset;
              return ValueListenableBuilder(
                valueListenable: BottomNavUtils.selectedBottomNavUser,
                builder: (BuildContext context, value, Widget? child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(
                        isActive: riveIcon ==
                            BottomNavUtils.selectedBottomNavUser.value,
                      ),
                      CircularButton(
                        onPressed: () {
                          BottomNavUtils.animateTheIcon(index);
                          pageController.jumpToPage(index);
                        },
                        shadow: false,
                        circularButtonChild: Opacity(
                          opacity: riveIcon ==
                                  BottomNavUtils.selectedBottomNavUser.value
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
    );
  }
}
