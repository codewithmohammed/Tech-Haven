import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppPallete.primaryAppColor,
      body:  Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  // decoration: const BoxDecoration(
                  //   color: AppPallete.primaryAppColor,
                  // ),
                  ),
              //for aligning the container in the stack ,used the align widget instead of positioned.
              // MediaQuery.of(context).size.width > 650 ?
              //if the screen width is greater than the value we will build a new align else for the mobile phones
              Positioned(
                bottom: -50,
                // heightFactor: 2,
                // widthFactor: 2,
                // alignment: screenWidth < 930
                //     ? const AlignmentDirectional(0, 1.25)
                //     : screenWidth < 1250
                //         ? const Alignment(1, 0)
                //         : screenWidth < 1650
                //             ? const Alignment(2, 0)
                //             : const Alignment(3, 0),
                child: Container(
                  height: 450,
                  width: 415,
                  decoration: const BoxDecoration(
                    boxShadow: [Constants.globalBoxBlur],
                    color: AppPallete.whiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(45),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FadeInDown(
                              from: 50,
                              duration: const Duration(
                                  milliseconds:
                                      Constants.normalAnimationMilliseconds),
                              curve: Curves.easeOut,
                              child: InkWell(
                                onTap: () {},
                                child: const Text('Skip'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeIn(
                          duration: const Duration(
                              milliseconds:
                                  Constants.normalAnimationMilliseconds),
                          curve: Curves.easeIn,
                          child: const Text(
                            'Welcome to',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              // color: AppPallete.blackColor,
                            ),
                          ),
                        ),
                        FadeIn(
                          duration: const Duration(
                              milliseconds:
                                  Constants.normalAnimationMilliseconds),
                          curve: Curves.easeIn,
                          child: const Text(
                            'Tech Haven',
                            style: TextStyle(
                              // fontFamily: 'BeVietnamPro',
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: AppPallete.primaryAppColor,
                            ),
                          ),
                        ),
                        FadeInUp(
                          from: 50,
                          duration: const Duration(
                              milliseconds:
                                  Constants.normalAnimationMilliseconds),
                          curve: Curves.easeOut,
                          child: const Text(
                            'Where Tech Enthusiasts Come Together.',
                            style: TextStyle(
                              color: AppPallete.greyTextColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppPallete.bordergreyColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: DefaultTabController(
                            length: 2,
                            child: TabBar(
                              onTap: (value) {
                                if (value == 1) {
                                  GoRouter.of(context)
                                      .pushNamed(AppRouteConstants.signinPage);
                                } else {
                                  GoRouter.of(context)
                                      .pushNamed(AppRouteConstants.signupPage);
                                }
                              },
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelStyle: const TextStyle(
                                  color: AppPallete.whiteColor,
                                  fontSize: Constants.buttonTextFontSize,
                                  fontWeight: FontWeight.w500),
                              unselectedLabelColor: AppPallete.blackColor,
                              indicator: const BoxDecoration(
                                color: AppPallete.primaryAppButtonColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(45),
                                ),
                              ),
                              tabs: const [
                                Tab(
                                  text: 'Sign Up',
                                ),
                                Tab(
                                  text: 'Sign In',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        
      
    );
  }
}
