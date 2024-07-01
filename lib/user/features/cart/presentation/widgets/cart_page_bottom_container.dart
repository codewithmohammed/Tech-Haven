import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/bottom_sheet_row_text.dart';

class CartPageBottomContainer extends StatelessWidget {
  const CartPageBottomContainer({
    super.key,
    required this.subTotal,
    required this.totalShpping,
    required this.total,
    required this.listOfCart,
  });

  final double subTotal;
  final double totalShpping;
  final double total;
  final List<Cart> listOfCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        boxShadow: [Constants.globalBoxBlur],
        color: AppPallete.whiteColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalTitleText(
              title: '${calculateTotalQuantity(listOfCarts: listOfCart)} Items',
            ),
            BottomSheetRowText(
              title: 'Sub Total',
              value: 'AED $subTotal',
            ),
            const Divider(),
            BottomSheetRowText(
              title: 'Total Shipping',
              value: 'AED $totalShpping',
            ),
            const Divider(),
            BottomSheetRowText(
              title: 'Total',
              value: 'AED $total',
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total'),
                    GlobalTitleText(title: 'AED $total')
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: SizedBox(
                      height: 50,
                      child: RoundedRectangularButton(
                        title: 'CHECKOUT',
                        onPressed: () {
                          GoRouter.of(context).pushNamed(
                              AppRouteConstants.checkoutPage,
                              pathParameters: {
                                'totalAmount': total.toString()
                              });
                          GoRouter.of(context)
                              .pushNamed(AppRouteConstants.googleMapPage);
                        },
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
