import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/icons/icons.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ShoppingCartButton extends StatefulWidget {
  const ShoppingCartButton({super.key});

  @override
  State<ShoppingCartButton> createState() => _ShoppingCartButtonState();
}

class _ShoppingCartButtonState extends State<ShoppingCartButton> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      width: isExpanded ? 80 : 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        color: isExpanded
            ? AppPallete.primaryAppButtonColor
            : AppPallete.whiteColor,
        boxShadow: const [
          BoxShadow(
            color: AppPallete.appShadowColor,
            blurStyle: BlurStyle.normal,
            blurRadius: 3,
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(
            isExpanded ? 30 : 10.0,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded != true ? isExpanded = true : isExpanded = false;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (isExpanded)
              GestureDetector(
                onTap: () {
                  print('object');
                },
                child: const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            isExpanded
                ? const Text(
                    '1',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : const SvgIcon(
                    icon: CustomIcons.cartSvg,
                    radius: 20,
                    color: Colors.black,
                  ),
            if (isExpanded)
              GestureDetector(
                onTap: () {
                  print('object');
                },
                child: const Text(
                  '-',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),

      // decoration: BoxDecoration(
      //   color: isExpanded ? Colors.green : Colors.blue,
      //   borderRadius: BorderRadius.circular(isExpanded ? 30 : 10.0),
      // ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     Icon(
      //       isExpanded ? Icons.check : Icons.shopping_cart,
      //       color: Colors.white,
      //     ),
      //     if (isExpanded)
      //       const Text(
      //         'Added to Cart!',
      //         style: TextStyle(
      //           fontSize: 8,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white,
      //         ),
      //       ),
      //   ],
    );
  }
}
