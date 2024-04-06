import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                  prefixIcon: const Icon(Icons.search),
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
            favouriteIconNeeded
                ? const Icon(
                    Icons.favorite_border,
                    color: AppPallete.blackColor,
                    size: 30,
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
                      Icon(
                        Icons.location_on,
                        color: AppPallete.blackColor,
                        size: 18,
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
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppPallete.blackColor,
                      )
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
