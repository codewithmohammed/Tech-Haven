import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/bloc/common_bloc.dart';
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
  final bool isForSliver;
  final bool autoFocus;
  final void Function(String)? onChanged;
  const AppBarSearchBar({
    super.key,
    this.isForSliver = false,
    this.hintText = 'What are you looking for ?',
    this.favouriteIconNeeded = true,
    this.deliveryPlaceNeeded = true,
    this.backButton = false,
    this.enabled = false,
    this.autoFocus = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    context.read<CommonBloc>().add(GetUserLocationDataEvent());
    return Container(
      color: isForSliver ? Colors.transparent : AppPallete.whiteColor,
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
                    onChanged: onChanged,
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
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.googleMapPage);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: 30,
                    child: BlocConsumer<CommonBloc, CommonState>(
                      listener: (context, state) {
                        if (state is LocationFailedState) {
                          Fluttertoast.showToast(msg: state.message);
                        }
                      },
                      builder: (context, state) {
                        return Row(
                          children: [
                            const SvgIcon(
                              icon: CustomIcons.mapPinSvg,
                              radius: 15,
                              fit: BoxFit.scaleDown,
                            ),
                            const Text(
                              'Delivering to',
                              style: TextStyle(
                                  fontSize: 13, color: AppPallete.blackColor),
                            ),
                            Expanded(
                              child: Text(
                                state is LocationSuccessState &&
                                        state.location != null
                                    ? '\t ${state.location!.location}'
                                    : "Click here to enter your location",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppPallete.blackColor,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SvgIcon(
                              icon: CustomIcons.chevronDownSvg,
                              radius: 25,
                            ),
                          ],
                        );
                      },
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
