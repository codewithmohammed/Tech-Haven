import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tech_haven/core/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';

import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/theme/theme.dart';

class AppBarSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;
  final bool favouriteIconNeeded;
  final bool deliveryPlaceNeeded;
  const AppBarSearchBar({
    super.key,
    this.hintText = 'What are you looking for ?',
    this.favouriteIconNeeded = true,
    this.deliveryPlaceNeeded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: favouriteIconNeeded
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration:
                      AppTheme.inputDecoration.copyWith(hintText: hintText),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              favouriteIconNeeded
                  ? const SvgIcon(
                      icon: CustomIcons.heartSvg,
                      radius: 30,
                      color: AppPallete.greyTextColor,
                    )
                  : const SizedBox()
            ],
          ),
          //given a visibily widget to hide the location when scrolling yet to complete this.
          deliveryPlaceNeeded
              ? GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: 30,
                    child: const Row(
                      children: [
                        SvgIcon(
                          icon: CustomIcons.mapPinSvg,
                          radius: 15,
                          fit: BoxFit.scaleDown,
                        ),
                        Text(
                          'Delivering to',
                          style: TextStyle(
                              fontSize: 13, color: AppPallete.blackColor),
                        ),
                        Expanded(
                          child: Text(
                            "\tDelivering to",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppPallete.blackColor,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SvgIcon(
                          icon: CustomIcons.chevronDownSvg,
                          radius: 25,
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 85);
}
