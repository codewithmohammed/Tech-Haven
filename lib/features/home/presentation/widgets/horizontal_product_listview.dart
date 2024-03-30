import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: GlobalTitleText(
              title: 'Recommended for you',
            ),
          ),
          //container for the whole
          SizedBox(
            height: 325,
            child: ListView.builder(
              // physics: const BouncingScrollPhysics(),
              scrollDirection:
                  Axis.horizontal, // Set scroll direction to horizontal
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                //column since the container is divided into two
                return Container(
                  width: 185,
                  margin: const EdgeInsets.all(10),
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
                        5,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      //sized box for the image and the cart/favorite button
                      Expanded(
                        flex: 2,
                        child: Stack(
                          children: [
                            //image
                            Container(
                              decoration: const BoxDecoration(
                                color: AppPallete.lightgreyColor,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/dev/iphone-png.png',
                                  ),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5,
                                  ),
                                ),
                              ),
                            ),
                            //rating
                            Positioned(
                              bottom: 5,
                              left: 5,
                              child: Container(
                                height: 15,
                                width: 70,
                                decoration: const BoxDecoration(
                                  color: AppPallete.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppPallete.appShadowColor,
                                      blurStyle: BlurStyle.normal,
                                      blurRadius: 2,
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '4.5',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      width: 10,
                                      height: 10,
                                      'assets/images/star-svgrepo-com.svg',
                                      theme: const SvgTheme(
                                        currentColor: Colors.green,
                                      ),
                                      colorFilter: const ColorFilter.mode(
                                          Colors.green, BlendMode.srcIn),
                                    ),
                                    const Text(
                                      '(8K)',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: AppPallete.greyTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    color: AppPallete.whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppPallete.appShadowColor,
                                        blurStyle: BlurStyle.normal,
                                        blurRadius: 2,
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        5,
                                      ),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.favorite_border,
                                    ),
                                  )),
                            ),
                            //favorite
                            //cart
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: AppPallete.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppPallete.appShadowColor,
                                      blurStyle: BlurStyle.normal,
                                      blurRadius: 2,
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      5,
                                    ),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.trolley,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //this is for the whole height of onw of the listview
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //product title
                            const Text(
                              'Sony Playstation 5 Digital Edition',
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            //product price
                            const SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          decoration:
                                              TextDecoration.lineThrough,
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
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            //product offer green
                            Container(
                              height: 8,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppPallete.appShadowColor,
                                    blurStyle: BlurStyle.normal,
                                    blurRadius: 2,
                                  )
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

