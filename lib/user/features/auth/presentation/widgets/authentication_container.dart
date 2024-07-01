import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class AuthenticationContainer extends StatelessWidget {
  final double height;
  final String title;
  final String subTitle;
  final List<Widget> columnChildren;
  final bool buttonNeeded;
  final String buttonText;
  final bool topButtonNeeded;
  final Widget topButtonChild;
  final void Function()? onPressedElevatedButton;
  final void Function()? onPressedTopButton;

  const AuthenticationContainer(
      {super.key,
      required this.height,
      required this.title,
      this.subTitle = '',
      required this.columnChildren,
      this.buttonNeeded = false,
      this.buttonText = '',
      this.topButtonNeeded = false,
      this.topButtonChild = const Icon(Icons.arrow_forward_rounded),
      this.onPressedElevatedButton,
      this.onPressedTopButton});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          width: 415,
          decoration: const BoxDecoration(
            boxShadow: [
              Constants.globalBoxBlur,
            ],
            color: AppPallete.whiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(45),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadeIn(
                  duration: const Duration(
                      milliseconds: Constants.normalAnimationMilliseconds),
                  curve: Curves.easeIn,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                FadeIn(
                  duration: const Duration(
                      milliseconds: Constants.normalAnimationMilliseconds),
                  curve: Curves.easeIn,
                  child: Text(subTitle),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: columnChildren,
                  ),
                ),
                //  const Spacer(),
                Visibility(
                    visible: buttonNeeded,
                    child: PrimaryAppButton(
                      buttonText: buttonText,
                      onPressed: onPressedElevatedButton,
                    )),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: topButtonNeeded,
          child: Positioned(
            top: -35,
            right: 35,
            child: CircularButton(
              onPressed: onPressedTopButton,
              circularButtonChild: topButtonChild,
              diameter: 70,
            ),
          ),
        ),
      ],
    );
  }
}
