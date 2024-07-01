import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/bloc/search_category_bloc.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/cubit/search_category_cubit.dart';

class SearchCategoryPage extends StatelessWidget {
  const SearchCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {  context.read<SearchCategoryCubit>().changeIndex(0);
    PageController pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!SearchCategoryBloc.isDataLoaded) {
        // If data is not loaded and not loading, fetch the data
        BlocProvider.of<SearchCategoryBloc>(context)
            .add(const GetAllSearchCategoryEvent(refreshPage: false));
      
      }
    });
    return SafeArea(
      bottom: false,
      child: Scaffold(
        extendBody: true,
        appBar: const AppBarSearchBar(),
        body: BlocConsumer<SearchCategoryBloc, SearchCategoryState>(
          listener: (context, blocState) {
            if (blocState is SearchCategoryAllCategoryLoadedFailed) {
              showSnackBar(
                  context: context,
                  title: 'Oh',
                  content: blocState.message,
                  contentType: ContentType.failure);
            }
          },
          builder: (context, blocState) {
            if (blocState is SearchCategoryLoading) {
              return const Loader();
            }
            if (blocState is! SearchCategoryAllCategoryLoadedSuccess) {
              return const Text('Hello are you ready');
            }
            final mainCategoryModel = blocState.allCategoryModel;

            return BlocBuilder<SearchCategoryCubit, int>(
              builder: (context, pageIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 140,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        primary: true,
                        itemCount: mainCategoryModel.length,
                        itemBuilder: (context, listTileindex) {
                          // print(pageIndex);
                          // print('listIndex' '$listTileindex');
                          return ListTile(
                            tileColor: listTileindex == pageIndex
                                ? AppPallete.lightgreyColor
                                : AppPallete.darkgreyColor,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            leading: Container(
                              width: 5,
                              decoration: BoxDecoration(
                                color: listTileindex == pageIndex
                                    ? AppPallete.primaryAppButtonColor
                                    : null,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                            onTap: () {
                              context
                                  .read<SearchCategoryCubit>()
                                  .changeIndex(listTileindex);
                              pageController.animateToPage(listTileindex,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.ease);
                            },
                            splashColor: AppPallete.primaryAppColor,
                            horizontalTitleGap: 0,
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                              mainCategoryModel[listTileindex].categoryName,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                            trailing: Container(
                              width: 1,
                            ),
                            selectedColor: AppPallete.whiteColor,
                          );
                          //   },
                          // );
                        },
                      ),
                    ),

                    // SideListViewTiles(mainCategoryModel: mainCategoryModel),
                    Expanded(
                      child: BlocBuilder<SearchCategoryCubit, int>(
                        builder: (context, indexState) {
                          return PageView.builder(
                            controller: pageController,
                            // itemExtent: 1000,
                            // shrinkWrap: true,
                            // padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                            onPageChanged: (value) {
                              context
                                  .read<SearchCategoryCubit>()
                                  .changeIndex(value);
                              // context
                              //     .read<SearchCategoryCubit>()
                              //     .changeIndex(value);
                            },
                            itemCount: mainCategoryModel.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, mainPageIndex) {
                              final subCategoryModel =
                                  mainCategoryModel[mainPageIndex]
                                      .subCategories;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GlobalTitleText(
                                    title: mainCategoryModel[mainPageIndex]
                                        .categoryName,
                                    fontSize: 14,
                                  ),
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      width: double.infinity,
                                      color: AppPallete.lightgreyColor,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            mainCategoryModel[mainPageIndex]
                                                .imageURL,
                                        fit: BoxFit.fitHeight,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey.shade100,
                                          highlightColor: Colors.grey.shade300,
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            color: Colors.white,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  BlocBuilder<SearchCategoryAccordionCubit,
                                      int>(
                                    builder: (context, state) {
                                      return ListView.builder(
                                        itemCount: subCategoryModel.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, accordionIndex) {
                                          // print(accordionIndex);
                                          final variantCategoryModel =
                                              subCategoryModel[accordionIndex]
                                                  .subCategories;
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      AppPallete.lightgreyColor,
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            SearchCategoryAccordionCubit>()
                                                        .changeAccordionIndex(
                                                            accordionIndex);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      GlobalTitleText(
                                                        title: subCategoryModel[
                                                                accordionIndex]
                                                            .categoryName,
                                                        fontSize: 14,
                                                      ),
                                                      Icon(
                                                        state == accordionIndex
                                                            ? Icons
                                                                .keyboard_arrow_up_rounded
                                                            : Icons
                                                                .keyboard_arrow_down_rounded,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (state == accordionIndex &&
                                                    mainPageIndex == pageIndex)
                                                  GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        variantCategoryModel
                                                            .length,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                                            maxCrossAxisExtent:
                                                                100,
                                                            mainAxisExtent:
                                                                100),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          GoRouter.of(context).pushNamed(
                                                              AppRouteConstants
                                                                  .productsPage,
                                                              pathParameters: {
                                                                'searchQuery':
                                                                    variantCategoryModel[
                                                                            index]
                                                                        .id
                                                              });
                                                        },
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                                flex: 2,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: variantCategoryModel[
                                                                          index]
                                                                      .imageURL,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Shimmer
                                                                          .fromColors(
                                                                    baseColor: Colors
                                                                        .grey
                                                                        .shade100,
                                                                    highlightColor:
                                                                        Colors
                                                                            .grey
                                                                            .shade300,
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error),
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                )),
                                                            Text(
                                                              variantCategoryModel[
                                                                      index]
                                                                  .categoryName,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      // child: ListViewWithAccordion(
                      //     mainCategoryModel: mainCategoryModel),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// class ListViewWithAccordion extends StatelessWidget {
//   const ListViewWithAccordion({
//     super.key,
//     required this.mainCategoryModel,
//   });

//   final List<Category> mainCategoryModel;

//   @override
//   Widget build(BuildContext context) {
//     PageController pageController = PageController();
//     return BlocBuilder<SearchCategoryCubit, int>(
//       builder: (context, state) {
//         int currentPage = state;

//         return PageView.builder(
//           controller: pageController,
//           // itemExtent: 1000,
//           // shrinkWrap: true,
//           // padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//           itemCount: mainCategoryModel.length,
//           scrollDirection: Axis.vertical,
//           itemBuilder: (context, pageIndex) {
           
//             final subCategoryModel = mainCategoryModel[pageIndex].subCategories;
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GlobalTitleText(
//                   title: mainCategoryModel[pageIndex].categoryName,
//                   fontSize: 16,
//                 ),
//                 AspectRatio(
//                   aspectRatio: 16 / 9,
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     width: double.infinity,
//                     color: AppPallete.lightgreyColor,
//                     child: Image.network(
//                       mainCategoryModel[pageIndex].imageURL,
//                       fit: BoxFit.fitHeight,
//                     ),
//                   ),
//                 ),
//                 BlocBuilder<SearchCategoryAccordionCubit, int>(
//                   builder: (context, state) {
//                     return ListView.builder(
//                       itemCount: subCategoryModel.length,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, accordionIndex) {
//                         final variantCategoryModel =
//                             subCategoryModel[accordionIndex].subCategories;
//                         return Container(
//                           margin: const EdgeInsets.only(top: 10),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               InkWell(
//                                 splashColor: AppPallete.lightgreyColor,
//                                 onTap: () {
//                                   context
//                                       .read<SearchCategoryAccordionCubit>()
//                                       .changeAccordionIndex(accordionIndex);
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     GlobalTitleText(
//                                       title: subCategoryModel[accordionIndex]
//                                           .categoryName,
//                                     ),
//                                     Icon(
//                                       state == accordionIndex
//                                           ? Icons.keyboard_arrow_up_rounded
//                                           : Icons.keyboard_arrow_down_rounded,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               if (state == accordionIndex && pageIndex == 1)
//                                 GridView.builder(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   itemCount: variantCategoryModel.length,
//                                   gridDelegate:
//                                       const SliverGridDelegateWithMaxCrossAxisExtent(
//                                           maxCrossAxisExtent: 100,
//                                           mainAxisExtent: 100),
//                                   itemBuilder: (context, index) {
//                                     return InkWell(
//                                       onTap: () {},
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Expanded(
//                                             flex: 2,
//                                             child: Image.network(
//                                               variantCategoryModel[
//                                                       accordionIndex]
//                                                   .imageURL,
//                                               fit: BoxFit.fitHeight,
//                                             ),
//                                           ),
//                                           Text(
//                                             variantCategoryModel[accordionIndex]
//                                                 .categoryName,
//                                             textAlign: TextAlign.center,
//                                             style: const TextStyle(
//                                               fontSize: 12,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class SideListViewTiles extends StatelessWidget {
//   const SideListViewTiles({
//     super.key,
//     required this.mainCategoryModel,
//   });

//   final List<Category> mainCategoryModel;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 140,
//       height: MediaQuery.of(context).size.height,
//       child: ListView.builder(
//         primary: true,
//         itemCount: mainCategoryModel.length,
//         itemBuilder: (context, listTileindex) {
//           return BlocBuilder<SearchCategoryCubit, int>(
//             builder: (context, state) {
//               return ListTile(
//                 tileColor: listTileindex == state
//                     ? AppPallete.lightgreyColor
//                     : AppPallete.darkgreyColor,
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 0),
//                 leading: Container(
//                   width: 5,
//                   decoration: BoxDecoration(
//                     color: listTileindex == state
//                         ? AppPallete.primaryAppButtonColor
//                         : null,
//                     borderRadius: const BorderRadius.only(
//                       topRight: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   context
//                       .read<SearchCategoryCubit>()
//                       .changeIndex(listTileindex);
//                 },
//                 splashColor: AppPallete.primaryAppColor,
//                 horizontalTitleGap: 0,
//                 titleAlignment: ListTileTitleAlignment.center,
//                 title: Text(
//                   mainCategoryModel[listTileindex].categoryName,
//                   style: const TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                   softWrap: true,
//                 ),
//                 trailing: Container(
//                   width: 1,
//                 ),
//                 selectedColor: AppPallete.whiteColor,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
