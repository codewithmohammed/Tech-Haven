import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ProfileWelcomeText extends StatelessWidget {
  const ProfileWelcomeText({
    super.key,
    required this.name,
    required this.subText,
    required this.onTapSettingIcon,
  });
  final String name;
  final String subText;
  final void Function()? onTapSettingIcon;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalTitleText(
                    title: 'Hello! $name',
                    fontSize: 15,
                  ),
                  Text(
                    subText,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              InkWell(
                onTap: onTapSettingIcon,
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
