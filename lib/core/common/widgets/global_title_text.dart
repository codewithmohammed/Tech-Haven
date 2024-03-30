import 'package:flutter/material.dart';

class GlobalTitleText extends StatelessWidget {
  const GlobalTitleText({super.key, required this.title, this.fontSize = 18});
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
