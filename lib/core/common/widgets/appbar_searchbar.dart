import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';

import 'package:tech_haven/core/theme/app_pallete.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: favouriteIconNeeded
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppPallete.whiteColor,
                  contentPadding: const EdgeInsets.only(top: 10),
                  prefixIcon: SizedBox(
                    height: 50,
                    child: SvgPicture.asset(
                      CustomIcons.searchSvg,
                      theme: const SvgTheme(
                        currentColor: AppPallete.greyTextColor,
                      ),
                      fit: BoxFit.scaleDown,
                      height: 50,
                    ),
                  ),
                  hintText: hintText,
                  hintStyle: const TextStyle(color: AppPallete.greyTextColor),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(
                      color: AppPallete.borderColor,
                    ),
                  ),
                ),
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
                        radius: 18,
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
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 75);
}
