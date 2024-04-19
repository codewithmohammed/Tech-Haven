import 'package:flutter/material.dart';
import 'package:tech_haven/core/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';

class VendorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VendorAppBar({
    super.key,
    required this.title,
    required this.bottom,
  });

  final String title;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
      title: Text(title),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SvgIcon(
            icon: CustomIcons.messagesSvg,
            radius: 25,
          ),
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
