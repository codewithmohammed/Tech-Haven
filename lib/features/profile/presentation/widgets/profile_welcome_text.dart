import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ProfileWelcomeText extends StatelessWidget {
  const ProfileWelcomeText({
    super.key,
    this.name = 'Nice to meet you',
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      color: AppPallete.lightgreyColor,
      height: 80,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //hello nice to meet you container
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GlobalTitleText(
                    title: 'Hello! $name',
                    fontSize: 15,
                  ),
                  const Text(
                    'You are currently not signed in',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: const SvgIcon(
                  icon: CustomIcons.settingSvg,
                  radius: 25,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}