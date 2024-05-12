import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/theme/theme.dart';

class AppBarSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;
  final bool favouriteIconNeeded;
  final bool deliveryPlaceNeeded;
  final bool backButton;
  final bool enabled;
  final bool autoFocus;
  const AppBarSearchBar({
    super.key,
    this.hintText = 'What are you looking for ?',
    this.favouriteIconNeeded = true,
    this.deliveryPlaceNeeded = true,
    this.backButton = false,
    this.enabled = false,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (backButton)
                CircularButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  circularButtonChild: const SvgIcon(
                    icon: CustomIcons.arrowLeftSvg,
                    radius: 25,
                    // color: AppPallete.whiteColor,
                  ),
                  diameter: 40,
                  color: AppPallete.whiteColor,
                  shadow: false,
                ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.searchPage);
                  },
                  child: TextField(
                    enabled: enabled,
                    decoration:
                        AppTheme.inputDecoration.copyWith(hintText: hintText),
                    autofocus: autoFocus,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              favouriteIconNeeded
                  ? GestureDetector(
                      onTap: () {
                        GoRouter.of(context)
                            .pushNamed(AppRouteConstants.favoritePage);
                      },
                      child: const SvgIcon(
                        icon: CustomIcons.heartSvg,
                        radius: 30,
                        color: AppPallete.greyTextColor,
                      ),
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
