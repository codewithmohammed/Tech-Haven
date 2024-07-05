import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key,
      required this.name,
      required this.profession,
      required this.onTapSettingIcon});
  final String name;
  final String profession;
  final void Function()? onTapSettingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
          backgroundColor: Colors.white24,
          child: SvgIcon(icon: CustomIcons.userCircleSvg, radius: 15)),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        profession,
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
      trailing: InkWell(
        onTap: onTapSettingIcon,
        child: const SvgIcon(
          color: AppPallete.whiteColor,
          icon: CustomIcons.settingSvg,
          radius: 25,
        ),
      ),
    );
  }
}
