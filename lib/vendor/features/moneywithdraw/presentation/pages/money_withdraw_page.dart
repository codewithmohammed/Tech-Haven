import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';
import 'package:tech_haven/vendor/features/moneywithdraw/presentation/widgets/line_chart.dart';

class MoneyWithdrawalPage extends StatelessWidget {
  const MoneyWithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        appBar: const VendorAppBar(
          title: 'Withdraw Money',
          bottom: null,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppPallete.whiteColor,
                    boxShadow: [
                      Constants.globalBoxBlur,
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Current Balance',
                              style: TextStyle(
                                color: AppPallete.greyTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '56,856',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        margin: const EdgeInsets.all(8),
                        child: const RoundedRectangularButton(
                          title: 'Withdraw Cash',
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Total Earning So Far : \$ 23,452',
                ),
                const SizedBox(
                  height: 20,
                ),
                const LineChartSample1(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
