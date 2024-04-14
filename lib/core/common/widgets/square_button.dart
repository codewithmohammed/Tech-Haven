import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({super.key, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 33,
        width: 33,
        decoration: const BoxDecoration(
          // color: AppPallete.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppPallete.appShadowColor,
              blurStyle: BlurStyle.normal,
              blurRadius: 2,
              spreadRadius: -3,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(
              5,
            ),
          ),
        ),
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                5,
              ),
            ),
          ),
          child: InkWell(onTap: () {}, child: icon),
        ));
  }
}
