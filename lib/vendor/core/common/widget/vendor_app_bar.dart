import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class VendorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VendorAppBar(
      {super.key,
      required this.title,
      required this.bottom,
      this.trailingIcon = CustomIcons.messagesSvg,
      this.messageIcon = false,
      this.onPressedTrailingIcon});

  final String title;
  final PreferredSizeWidget? bottom;
  final String? trailingIcon;
  final bool messageIcon;
  final void Function()? onPressedTrailingIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: messageIcon && trailingIcon == null
              ? CircularButton(
                  onPressed: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.vendorChatPage);
                  },
                  circularButtonChild: const SvgIcon(
                    icon: CustomIcons.messagesSvg,
                    radius: 25,
                  ),
                  diameter: 50,
                  color: AppPallete.whiteColor,
                  shadow: false,
                )
              : trailingIcon != null
                  ? CircularButton(
                      onPressed: onPressedTrailingIcon,
                      circularButtonChild: SvgIcon(
                        icon: trailingIcon!,
                        radius: 25,
                      ),
                      diameter: 50,
                      color: AppPallete.whiteColor,
                      shadow: false,
                    )
                  : null,
        )
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size(
        double.maxFinite,
        bottom != null ? 100 : 60,
      );
}
