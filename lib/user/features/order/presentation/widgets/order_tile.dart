import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.keys,
    required this.value,
  });

  final String keys;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              'Order Date',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              keys,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Column(
          children: [
            const Text(
              'Delivery Date',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
