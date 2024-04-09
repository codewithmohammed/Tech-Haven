import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import '../../../../core/common/widgets/global_appbar_searchbar.dart';

class SearchCategoryPage extends StatefulWidget {
  const SearchCategoryPage({super.key});

  @override
  State<SearchCategoryPage> createState() => _SearchCategoryPageState();
}

class _SearchCategoryPageState extends State<SearchCategoryPage> {
  bool isExpanded = false;
  int currentIndex = 0;
  ScrollController searchPageController = ScrollController();

  int? openedAccordionIndex;
  int? pageOfcurrentAccordionIndex;
  @override
  void dispose() {
    searchPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
            extendBody: true,
            appBar: const AppBarSearchBar(),
            body: Row(
              children: [
                SizedBox(
                  width: 125,
                  height: MediaQuery.of(context).size.height,
                  // decoration: const BoxDecoration(
                  //   color: AppPallete.darkgreyColor,
                  // ),
                  child: ListView.builder(
                    primary: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: index == currentIndex
                            ? AppPallete.lightgreyColor
                            : AppPallete.darkgreyColor,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        leading: Container(
                          // height: 10,
                          width: 5,
                          decoration: BoxDecoration(
                            color: index == currentIndex
                                ? AppPallete.primaryAppButtonColor
                                : null,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(
                                10,
                              ),
                              bottomRight: Radius.circular(
                                10,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        splashColor: AppPallete.primaryAppColor,
                        horizontalTitleGap: 0,

                        titleAlignment: ListTileTitleAlignment.center,
                        title: const Text(
                          'Main Category',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                        ),

                        trailing: Container(
                          width: 1,
                        ),
                        // selectedTileColor: AppPallete.whiteColor,
                      );
                    },
                  ),
                ),
                //first we need a custom scroll view

                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: searchPageController,
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, pageIndex) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GlobalTitleText(
                            title: 'Main Category',
                            fontSize: 16,
                          ),
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: AppPallete.lightgreyColor,
                              ),
                            ),
                          ),
                          ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, accordionIndex) {
                              // int? currentPageIndex;
                              return Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      splashColor: AppPallete.lightgreyColor,
                                      onTap: () {
                                        setState(() {
                                          pageOfcurrentAccordionIndex =
                                              pageIndex;
                                          openedAccordionIndex = accordionIndex == openedAccordionIndex ? null : accordionIndex;
                                        });
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GlobalTitleText(
                                            title: 'title',
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                          ),
                                        ],
                                      ),
                                    ),
                                    accordionIndex == openedAccordionIndex &&
                                            pageIndex ==
                                                pageOfcurrentAccordionIndex
                                        ? GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: 10,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/dev/iphone-png.png',
                                                  ),
                                                  const Text(
                                                    'iPhone',
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            )));
  }
}
