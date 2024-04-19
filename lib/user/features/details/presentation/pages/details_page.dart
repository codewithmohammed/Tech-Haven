import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_page_divider.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/common/widgets/square_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/star_widget.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/product_card.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    PageController pageController = PageController();
    int selectedColor = 1;
    // TabController controller = TabController(length: 2, vsync: this);
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarSearchBar(
          deliveryPlaceNeeded: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //for the brand name
              const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalTitleText(
                      title: 'Brand Name',
                      fontSize: 16,
                      color: AppPallete.primaryAppColor,
                    ),
                    Constants.kHeight,
                    Text(
                      'PlayStation 5 Digital Edition Console Withsssssssssssssssss Controller',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //for the images of the products
              Stack(
                children: [
                  CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount: 1,
                    itemBuilder: (context, index, realIndex) {
                      return Hero(
                        tag: '0',
                        child: Image.asset(
                          'assets/dev/iphone-png.png',
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 350,
                      viewportFraction: 1,
                      // onPageChanged: (index, reason) {
                      //   pageController.jumpToPage(index);
                      // },
                    ),
                  ),
                  const Positioned(
                      right: 10,
                      top: 5,
                      child: Column(
                        children: [
                          SquareButton(
                            icon: SvgIcon(
                              icon: CustomIcons.heartSvg,
                              color: AppPallete.greyTextColor,
                              radius: 5,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Constants.kHeight,
                          SquareButton(
                            icon: SvgIcon(
                              icon: CustomIcons.shareSvg,
                              color: AppPallete.greyTextColor,
                              radius: 5,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      )),
                ],
              ),

              //for the indicator

              Container(),

              //for the prize tag
              SizedBox(
                height: 350,
                child: Column(
                  children: [
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Overview'),
                        Tab(text: 'Specifications'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat'),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ListView.builder(
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: index % 2 != 0
                                          ? AppPallete.primaryAppColor
                                              .withOpacity(
                                              0.5,
                                            )
                                          : AppPallete.whiteColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          3,
                                        ),
                                      )),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('Spec Type'),
                                      Text('Spec Value'),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const GlobalPageDivider(),
              Container(
                color: AppPallete.whiteColor,
                height: 150,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: GlobalTitleText(
                        title: 'Available Colors',
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          right: 5,
                          left: 5,
                        ),
                        child: GridView.builder(
                          // shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 175,
                          ),
                          itemCount: 50,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.all(
                                5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    10,
                                  ),
                                ),
                                border: Border.all(
                                  color: selectedColor == index
                                      ? AppPallete.primaryAppColor
                                      : AppPallete.darkgreyColor,
                                  width: 2,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Image.asset(
                                    'assets/dev/iphone-png.png',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const GlobalPageDivider(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                height: 100,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalTitleText(
                      title: 'User Reviews',
                    ),
                    Expanded(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //for the rating
                          Text(
                            '4.5',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w700),
                          ),
                          //column for the star and subtext
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StarsWidget(),
                              Text(
                                'Based on 8K rating and 1.4K reviews',
                                style: TextStyle(
                                  color: AppPallete.greyTextColor,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider()
                  ],
                ),
              ),
              Column(
                // physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                children: [
                  Container(
                    // height: 500,
                    // decoration: const BoxDecoration(color: Colors.amber),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //container for the picture
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                            const GlobalTitleText(
                              title: 'Notification Heading',
                            ),
                            //container for the title and the subtitle
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: StarsWidget(),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'The standard Lorem Ipsum passage is: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.The standard Lorem Ipsum passage is: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                            style: TextStyle(
                              fontSize: 16,
                              // color: AppPallete.blackColor,
                            ),
                          ),
                        ),
                        OutlinedButton.icon(
                          style: const ButtonStyle(),
                          onPressed: () {},
                          icon: const SvgIcon(
                            icon: CustomIcons.thumbUpSvg,
                            radius: 20,
                            color: AppPallete.greyTextColor,
                          ),
                          label: const Text(
                            'Helpful(21)',
                            style: TextStyle(
                              color: AppPallete.greyTextColor,
                            ),
                          ),
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                  Container(
                    // height: 500,
                    // decoration: const BoxDecoration(color: Colors.amber),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //container for the picture
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                            const GlobalTitleText(
                              title: 'Notification Heading',
                            ),
                            //container for the title and the subtitle
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: StarsWidget(),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'The standard Lorem Ipsum passage is: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.The standard Lorem Ipsum passage is: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                            style: TextStyle(
                              fontSize: 16,
                              // color: AppPallete.blackColor,
                            ),
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const SvgIcon(
                            icon: CustomIcons.thumbUpSvg,
                            radius: 20,
                            color: AppPallete.greyTextColor,
                          ),
                          label: const Text(
                            'Helpful(21)',
                            style: TextStyle(
                              color: AppPallete.greyTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  height: 50,
                  width: double.infinity,
                  child: const RoundedRectangularButton(
                    title: 'VIEW MORE',
                    outlined: true,
                  )),

              const Divider(),
              Container(
                // height: 600,
                padding: const EdgeInsets.all(10),
                child: const GlobalTitleText(
                  title: 'More From Brand Name',
                  fontSize: 16,
                  color: AppPallete.primaryAppColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisExtent: 300,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ProductCard(index: index);
                },
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          width: double.infinity,
          height: 70,
          decoration: const BoxDecoration(
            color: AppPallete.whiteColor,
            border: Border(
              top: BorderSide(
                color: AppPallete.greyTextColor,
                width: 0.5,
              ),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: AppPallete.whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      5,
                    ),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: AppPallete.greyTextColor,
                      width: 0.5,
                    ),
                    bottom: BorderSide(
                      color: AppPallete.greyTextColor,
                      width: 0.5,
                    ),
                    right: BorderSide(
                      color: AppPallete.greyTextColor,
                      width: 0.5,
                    ),
                    left: BorderSide(
                      color: AppPallete.greyTextColor,
                      width: 0.5,
                    ),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'QTY',
                      style: TextStyle(
                          color: AppPallete.greyTextColor, fontSize: 10),
                    ),
                    Text(
                      '1',
                      style: TextStyle(
                        color: AppPallete.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Expanded(
                child: SizedBox(
                  height: 50,
                  child: RoundedRectangularButton(
                    title: 'ADD TO CART',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class MyTabbedPage extends StatefulWidget {
//   const MyTabbedPage({super.key});

//   @override
//   _MyTabbedPageState createState() => _MyTabbedPageState();
// }

// class _MyTabbedPageState extends State<MyTabbedPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tabbed Page'),
//       ),
//       body: Column(
//         children: [
//           TabBar(
//             controller: _tabController,
//             tabs: const [
//               Tab(text: 'Tab 1'),
//               Tab(text: 'Tab 2'),
//               Tab(text: 'Tab 3'),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: const [
//                 Center(child: Text('Tab 1 Content')),
//                 Center(child: Text('Tab 2 Content')),
//                 Center(child: Text('Tab 3 Content')),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
