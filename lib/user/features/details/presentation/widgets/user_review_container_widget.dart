
import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/star_widget.dart';

import '../../../../../core/common/widgets/global_title_text.dart';

class UserReviewContainerWidget extends StatelessWidget {
  const UserReviewContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      children: [
        Container(
          // height: 500,
          // decoration: const BoxDecoration(color: Colors.amber),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //container for the picture
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                  const GlobalTitleText(
                    title: 'Notification Heading',
                  ),
                  //container for the title and the subtitle
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: StarsWidget(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'The standard Lorem Ipsum passage is: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.The standard Lorem Ipsum passage is: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  style: TextStyle(
                    fontSize: 16,
                    // color: AppPallete.blackColor,
                  ),
                ),
              ),
              OutlinedButton.icon(
                style: const ButtonStyle(),
                onPressed: () {},
                icon: const SvgIcon(
                  icon: CustomIcons.thumbUpSvg,
                  radius: 20,
                  color: AppPallete.greyTextColor,
                ),
                label: const Text(
                  'Helpful(21)',
                  style: TextStyle(
                    color: AppPallete.greyTextColor,
                  ),
                ),
              ),
              const Divider()
            ],
          ),
        ),
        Container(
          // height: 500,
          // decoration: const BoxDecoration(color: Colors.amber),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //container for the picture
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                  const GlobalTitleText(
                    title: 'Notification Heading',
                  ),
                  //container for the title and the subtitle
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: StarsWidget(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'The standard Lorem Ipsum passage is: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.The standard Lorem Ipsum passage is: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  style: TextStyle(
                    fontSize: 16,
                    // color: AppPallete.blackColor,
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const SvgIcon(
                  icon: CustomIcons.thumbUpSvg,
                  radius: 20,
                  color: AppPallete.greyTextColor,
                ),
                label: const Text(
                  'Helpful(21)',
                  style: TextStyle(
                    color: AppPallete.greyTextColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}