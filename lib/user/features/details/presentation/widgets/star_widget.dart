import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';

class StarsWidget extends StatefulWidget {
  const StarsWidget({
    super.key,
    this.radius = 12,
    required this.value,
  });
  final double value;
  final double radius;
  @override
  State<StarsWidget> createState() => _StarsWidgetState();
}

class _StarsWidgetState extends State<StarsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          if (index < widget.value.floor()) {
            // Full star
            return SvgIcon(
              icon: CustomIcons.starSvg,
              radius: widget.radius,
              color: Colors.green,
              fit: BoxFit.scaleDown,
            );
          } else if (index < widget.value) {
            // Half star (you need a half star SVG or some other representation)
            return SvgIcon(
              icon: CustomIcons.starHalfSvg,
              radius: widget.radius,
              color: Colors.green,
              fit: BoxFit.scaleDown,
            );
          } else {
            // Empty star
            return SvgIcon(
              icon: CustomIcons.outlinedStarSvg,
              radius: widget.radius,
              color: Colors.white,
              fit: BoxFit.scaleDown,
            );
          }
        }),
      ),
    );
  }
}
