import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/shopping_cart_button.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';

import '../../../../../core/theme/app_pallete.dart';

class DealsGridView extends StatelessWidget {
  const DealsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color.fromARGB(255, 54, 95, 46),
      height: 670,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Row(
                  children: [
                    Text(
                      'MEGA DEALS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '24 HOURS ONLY',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
                width: 125,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.blackColor,
                    foregroundColor: AppPallete.whiteColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'VIEW ALL',
                    style: TextStyle(
                      color: AppPallete.whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
          //container for the product card
          Container(
            height: 600,
            margin: const EdgeInsets.only(top: 20),
            child: GridView.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                // crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10, maxCrossAxisExtent: 300,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  // width: 200,

                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppPallete.appShadowColor,
                        blurStyle: BlurStyle.normal,
                        blurRadius: 5,
                      ),
                    ],
                    color: AppPallete.whiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),

                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouteConstants.detailsPage);
                    },
                    child: Column(
                      children: [
                        //sized box for the image and the cart/favorite button
                        Expanded(
                          child: Stack(
                            children: [
                              //image
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppPallete.whiteColor,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/dev/iphone-png.png',
                                    ),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                              ),
                              //smartphone deals
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  // alignment: Alignment.center,
                                  width: 120,
                                  height: 15,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: AppPallete.primaryAppColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                        10,
                                      ),
                                      bottomLeft: Radius.circular(
                                        10,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'SmartPhones Deals',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: AppPallete.whiteColor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    textAlign: TextAlign.center,
                                    softWrap: false,
                                  ),
                                ),
                              ),

                              //cart
                              const Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: ShoppingCartButton(
                                    currentCount: 0,
                                  )),
                            ],
                          ),
                        ),
                        //this is for the whole height of onw of the listview
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: AppPallete.lightgreyColor,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //product title
                                Text(
                                  'Sony Playstation 5 Digital Edition',
                                  softWrap: true,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                //product price
                                SizedBox(
                                  // width: 150,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'AED',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '1,693',
                                            style: TextStyle(
                                              fontSize: 16,
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
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationThickness: 2.0,
                                            ),
                                          ),
                                          Text(
                                            'AED',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationThickness: 2.0,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          //container for the whole
        ],
      ),
    );
  }
}
