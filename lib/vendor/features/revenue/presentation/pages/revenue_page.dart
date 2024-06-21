import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/widgets/custom_drop_down.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';
import 'package:tech_haven/vendor/features/revenue/presentation/bloc/revenue_bloc.dart';
import 'package:tech_haven/vendor/features/revenue/presentation/widgets/line_chart.dart';

class MoneyWithdrawalPage extends StatelessWidget {
  const MoneyWithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RevenueBloc>().add(GetRevenueEvent());
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        appBar: const VendorAppBar(
          title: 'Withdraw Money',
          bottom: null,
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<RevenueBloc, RevenueState>(
            listener: (context, state) {
              if (state is GetRevenueFailed) {
                Fluttertoast.showToast(msg: state.message);
              }
            },
            builder: (context, state) {
              if (state is GetRevenueSuccess) {
                return Container(
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
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Current Balance',
                                    style: TextStyle(
                                      color: AppPallete.greyTextColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.revenue.currentBalance.toString(),
                                    style: const TextStyle(
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

                      //List of revenues default will be given as monthly revenue
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const GlobalTitleText(
                            title: 'Revenue Overview',
                          ),
                          SizedBox(
                            // height: 20,
                            width: 150,
                            child: CustomDropDown(
                              hintText: '',
                              items: const ['hello', 'how are you'],
                              currentItem: 'hello',
                              onChanged: (p0) {},
                            ),
                          )
                        ],
                      ),
                      const Row(
                        children: [
                          GlobalTitleText(title: 'Monthly : '),
                          GlobalTitleText(title: '1241'),
                        ],
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const ListTile();
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: 12,
                      )
                      // Text(
                      //   'Total Earning So Far : \$ ${state.revenue.currentBalance + state.revenue.withdrewAmount}',
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // const LineChartSample1(),
                    ],
                  ),
                );
              }
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
