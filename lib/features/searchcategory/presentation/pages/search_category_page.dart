import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
            extendBody: true,
            appBar: const GlobalAppBarSearchBar(),
            body: Row(
              children: [
                SizedBox(
                    width: 125,
                    height: MediaQuery.of(context).size.height,
                    // decoration: const BoxDecoration(
                    //   color: AppPallete.darkgreyColor,
                    // ),
                    child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (context, index) {
                        return ListTile(
                          style: ListTileStyle.list,
                          tileColor: index == 0
                              ? AppPallete.lightgreyColor
                              : AppPallete.darkgreyColor,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 0),
                          leading: Container(
                            // height: 10,
                            width: 5,
                            decoration: BoxDecoration(
                              color: index == 0
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
                          onTap: () {},
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
                    )),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    // color: Colors.green,
                    child: PageView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: 10,
                      pageSnapping: false,
                      scrollDirection: Axis.vertical,
                      allowImplicitScrolling: true,
                      itemBuilder: (context, index) {
                        return Container(
                          // color: AppPallete.backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
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
                                Expanded(
                                  child: SizedBox(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: isExpanded
                                              ? Column(
                                                  children: [
                                                    InkWell(
                                                      splashColor: AppPallete
                                                          .lightgreyColor,
                                                      onTap: () {
                                                        setState(() {
                                                          isExpanded = true;
                                                        });
                                                      },
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          GlobalTitleText(
                                                            title: 'title',
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .keyboard_arrow_down_rounded,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    InkWell(
                                                      splashColor: AppPallete
                                                          .lightgreyColor,
                                                      onTap: () {},
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          GlobalTitleText(
                                                            title: 'hello',
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .keyboard_arrow_down_rounded,
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
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )));
  }
}
// =======

// class SearchCategoryPage extends StatelessWidget {
//   const SearchCategoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Text(
//         'Search Category Page',
// >>>>>>> bottomnavigationbar
//       ),
//     );
//   }
// }
// <<<<<<< HEAD

// SizedBox(
//                                       height: 30,
//                                       child: ListTile(
//                                         splashColor: AppPallete.lightgreyColor,
//                                         horizontalTitleGap: 0,
//                                         title: const Text('sdfsd'),
//                                         trailing: CircularButton(
//                                           onPressed: () {},
//                                           shadow: false,
//                                           circularButtonChild: const Icon(Icons
//                                               .keyboard_arrow_down_rounded),
//                                           diameter: 40,
//                                         ),
//                                         onTap: () {},
//                                       ),
//                                     );
// Container(
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: index == 0 ? Colors.red : Colors.white,
//                           ),
//                           alignment: Alignment.centerLeft,
//                           child: const Text('da5555555555555555555ta'));

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   static const String _title = 'Flutter Tutorial';
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: const Steps(),
//       ),
//     );
//   }
// }

// class Step {
//   Step(this.title, this.body, [this.isExpanded = true]);
//   String title;
//   String body;
//   bool isExpanded;
// }

// List<Step> getSteps() {
//   return [
//     Step(
//       'Step 0: Install Flutter',
//       'Install Flutter development tools according to the official documentation.',
//     ),
//     Step(
//         'Step 1: Create a project',
//         'Open your terminal, run `flutter create <project_name>` to create a new project.',
//         false),
//     Step(
//         'Step 2: Run the app',
//         'Change your terminal directory to the project directory, enter `flutter run`.',
//         false),
//   ];
// }

// class Steps extends StatefulWidget {
//   const Steps({super.key});
//   @override
//   State<Steps> createState() => _StepsState();
// }

// class _StepsState extends State<Steps> {
//   final List<Step> _steps = getSteps();
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionPanelList(
//       materialGapSize: 0,
//       elevation: 0,
//       expansionCallback: (int index, bool isExpanded) {
//         setState(() {
//           _steps[index].isExpanded = !isExpanded;
//         });
//       },
//       children: _steps.map<ExpansionPanel>((Step step) {
//         return ExpansionPanel(
//           canTapOnHeader: true,
//           headerBuilder: (BuildContext context, bool isExpanded) {
//             return SizedBox(
//               height: 10,
//               child: GlobalTitleText(
//                 title: step.title,
//                 fontSize: 14,
//               ),
//             );
//           },
//           body: ListTile(
//             title: Text(step.body),
//           ),
//           isExpanded: step.isExpanded,
//         );
//       }).toList(),
//     );
//   }
//   // Widget _renderSteps() {
//   //   return
//   // }
// }
// =======
// >>>>>>> bottomnavigationbar
