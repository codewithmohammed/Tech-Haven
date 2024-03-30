import 'package:flutter/material.dart';

import 'package:tech_haven/core/theme/app_pallete.dart';

class AppBarSearchBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 325,
                maxHeight: 50,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppPallete.whiteColor,
                  contentPadding: EdgeInsets.only(top: 10),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'What are you looking for ?',
                  hintStyle: TextStyle(color: AppPallete.greyTextColor),
                  border: OutlineInputBorder(
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
            const Icon(
              Icons.favorite_border,
              color: AppPallete.blackColor,
              size: 30,
            )
          ],
        ),
        //given a visibily widget to hide the location when scrolling yet to complete this.
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            height: 30,
            child: const Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppPallete.blackColor,
                  size: 18,
                ),
                Text(
                  'Delivering to',
                  style: TextStyle(fontSize: 13, color: AppPallete.blackColor),
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
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppPallete.blackColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 75);
}
