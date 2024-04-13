import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class HeartButton extends StatelessWidget {
  const HeartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
        color: AppPallete.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppPallete.appShadowColor,
            blurStyle: BlurStyle.normal,
            blurRadius: 2,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(
            5,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {},
        child: const SvgIcon(
          icon: CustomIcons.heartSvg,
          color: AppPallete.greyTextColor,
          radius: 5,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
