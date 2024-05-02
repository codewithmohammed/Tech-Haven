import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/bloc/search_category_bloc.dart';

class SearchCategoryPage extends StatelessWidget {
  const SearchCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!SearchCategoryBloc.isDataLoaded) {
        // If data is not loaded and not loading, fetch the data
        BlocProvider.of<SearchCategoryBloc>(context)
            .add(GetAllSearchCategoryEvent(refreshPage: false));
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

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 125,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    primary: true,
                    itemCount: mainCategoryModel.length,
                    itemBuilder: (context, listTileindex) {
                      return ListTile(
                        tileColor: listTileindex == 1
                            ? AppPallete.lightgreyColor
                            : AppPallete.darkgreyColor,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        leading: Container(
                          width: 5,
                          decoration: BoxDecoration(
                            color: listTileindex == 1
                                ? AppPallete.primaryAppButtonColor
                                : null,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        onTap: () {},
                        splashColor: AppPallete.primaryAppColor,
                        horizontalTitleGap: 0,
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          mainCategoryModel[listTileindex].categoryName,
                          style: const TextStyle(
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
                        selectedColor: AppPallete.whiteColor,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    itemCount: mainCategoryModel.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, pageIndex) {
                      //the subcategorymodel inside the maincategorymodel
                      final subCategoryModel =
                          mainCategoryModel[pageIndex].subCategories;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalTitleText(
                            title: mainCategoryModel[pageIndex].categoryName,
                            fontSize: 16,
                          ),
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              color: AppPallete.lightgreyColor,
                              child: Image.network(
                                mainCategoryModel[pageIndex].imageURL,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          ListView.builder(
                            itemCount: subCategoryModel.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, accordionIndex) {
                              final variantCategoryModel =
                                  subCategoryModel[accordionIndex]
                                      .subCategories;
                              return Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      splashColor: AppPallete.lightgreyColor,
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GlobalTitleText(
                                            title:
                                                subCategoryModel[accordionIndex]
                                                    .categoryName,
                                          ),
                                          Icon(
                                            1 == accordionIndex
                                                ? Icons
                                                    .keyboard_arrow_up_rounded
                                                : Icons
                                                    .keyboard_arrow_down_rounded,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (1 == accordionIndex && pageIndex == 1)
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: variantCategoryModel.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 100,
                                                mainAxisExtent: 100),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {},
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Image.network(
                                                    variantCategoryModel[
                                                            accordionIndex]
                                                        .imageURL,
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                                Text(
                                                  variantCategoryModel[
                                                          accordionIndex]
                                                      .categoryName,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
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
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
