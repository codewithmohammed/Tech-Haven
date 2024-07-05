import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class CustomSliverAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: true,
      scrolledUnderElevation: 0,
      elevation: 0,
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      //the whole height of the appBar
      expandedHeight: 150,
      // leading:
      //the height of the app bar when it is collapsed or scrolled
      collapsedHeight: 100,
      stretchTriggerOffset: 100,
      onStretchTrigger: () async {},
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppPallete.primaryAppColor,
          alignment: Alignment.topLeft,
          child: Image.asset(
            scale: 10,
            Constants.techHavenLogoHR,
          ),
        ),
        expandedTitleScale: 1,
        centerTitle: true,
        // the default padding is made to some values based on the row widgets
        titlePadding: const EdgeInsetsDirectional.only(
          start: 10,
          bottom: 5,
          end: 10,
        ),
        //
        title: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: const AppBarSearchBar(
            enabled: false,
            isForSliver: true,
            autoFocus: true,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 130);
}
