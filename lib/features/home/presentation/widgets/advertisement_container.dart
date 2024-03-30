
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class AdvertisementContainer extends StatelessWidget {
  const AdvertisementContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.primaryAppColor,
      height: 150,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    Text(
                      'LAPTOPS | DESKTOPS UP TO 35% OFF',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      softWrap: true,
                      // overflow: TextOverflow.visible,
                    ),
                    Text(
                      'The Ultimate Laptops Destination Shop Now and Get the Best Deals',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                      softWrap: true,
                      // overflow: TextOverflow.visible,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppPallete.whiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: const Text(
                      'Order Now',
                      style: TextStyle(color: AppPallete.primaryAppColor),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppPallete.gradient2,
                            AppPallete.gradient1,
                          ],
                        ),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        children: [
                          //blur effect
                          BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 3,
                              sigmaY: 3,
                            ),
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset('assets/dev/hp-laptop-png.png')
                ],
              ),
              // width: 100,
            ),
          )
        ],
      ),
    );
  }
}
