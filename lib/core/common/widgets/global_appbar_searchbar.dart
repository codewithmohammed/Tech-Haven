import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';

class GlobalAppBarSearchBar extends StatelessWidget
    implements PreferredSizeWidget {
  const GlobalAppBarSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: const AppBarSearchBar(),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}
