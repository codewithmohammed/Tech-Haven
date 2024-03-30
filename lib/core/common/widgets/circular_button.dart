

import 'package:flutter/material.dart';
import 'package:tech_haven/core/constants/constants.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.onPressed,
    required this.circularButtonChild,
    required this.diameter,
    this.shadow = true,
  });

  final void Function()? onPressed;
  final Widget circularButtonChild;
  final double diameter;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: shadow ? [Constants.globalBoxBlur] : null,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: circularButtonChild,
      ),
    );
  }
}
