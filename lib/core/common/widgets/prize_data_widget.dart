import 'package:flutter/material.dart';

class PrizeDataWidget extends StatelessWidget {
  const PrizeDataWidget({
    super.key,required this.totalHeight,
  });

  final double totalHeight;

  @override
  Widget build(BuildContext context) {
      final double ratio = totalHeight / 200; 
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              'AED',
              style: TextStyle(
                fontSize: 12 * ratio,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '1,693',
              style: TextStyle(
                fontSize: 16 * ratio,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '3,299',
              style: TextStyle(
                fontSize: 12 * ratio,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2.0,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '48%',
              style: TextStyle(
                color: Colors.green,
                fontSize: 13 * ratio,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
      ],
    );
  }
}
