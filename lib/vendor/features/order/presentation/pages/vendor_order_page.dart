import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/icons/icons.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';

class VendorOrderPage extends StatelessWidget {
  const VendorOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const VendorAppBar(title: 'Your Order', bottom: null),
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(
              10,
            ),
            decoration: const BoxDecoration(
              color: AppPallete.darkgreyColor,
            ),
            //the whole container column
            child: Column(
              children: [
                //row for the first bar
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //clock icon
                    Row(
                      children: [
                        SvgIcon(
                          icon: CustomIcons.clockSvg,
                          radius: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        //column for the text
                        Column(
                          children: [
                            Text(
                              'Waiting for Acceptance',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '13/12/2023',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //text for the amount
                    Text(
                      'Amount 23.00',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
                //divider
                const Divider(),
                //text for the order details
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GlobalTitleText(
                        title: 'Order Details',
                        fontSize: 16,
                      ),
                    ),
                    //row for the pic and details
                    Row(
                      children: [
                        //for the image container
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: const BoxDecoration(
                              color: AppPallete.whiteColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                              boxShadow: [
                                Constants.globalBoxBlur,
                              ]),
                          child: InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'assets/dev/hp-laptop-png.png',
                              scale: 10,
                            ),
                          ),
                        ),
                        //column for the details of the customer
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //row for the name and quantity of the product ordered
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('PS5'),
                                    Text('Quantity : 2'),
                                  ],
                                ),
                                //text customer details
                                GlobalTitleText(
                                  title: 'Customer Details',
                                  fontSize: 14,
                                ),
                                Text('Name :'),
                                Text('Location :'),
                                Text('Customer ID :'),
                              ],
                            ),
                          ),
                        ),
                        //column for the two buttons
                        const Column(
                          children: [
                            //accept button
                            SmallLongButton(
                              text: 'Accept',
                              bgColor: Colors.green,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //decline button
                            SmallLongButton(
                              text: 'Decline',
                              bgColor: Colors.red,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}

class SmallLongButton extends StatelessWidget {
  const SmallLongButton({
    super.key,
    required this.bgColor,
    required this.text,
  });

  final Color bgColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 25,
      child: ElevatedButton(
        onPressed: () {},
        style: const ButtonStyle().copyWith(
            shape: const MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5,
                  ),
                ),
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(
              bgColor,
            )),
        child: Text(
          text,
          style: const TextStyle(
            color: AppPallete.whiteColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
