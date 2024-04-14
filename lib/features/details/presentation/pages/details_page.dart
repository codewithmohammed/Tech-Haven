import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/square_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

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
                          DataTable(columns: [
                            DataColumn(
                                label: Container(
                              child: const Text('data'),
                            ))
                          ], rows: [
                            DataRow(cells: [
                              DataCell(Container(
                                child: const Text('sdlfh'),
                              ))
                            ])
                          ])
                        ],
                      ),
                    ),
                  ],
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
