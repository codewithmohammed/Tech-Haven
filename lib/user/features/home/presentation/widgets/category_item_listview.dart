import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';

class CategoryIconListView extends StatelessWidget {
  const CategoryIconListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Fixed height for horizontal list
      alignment: Alignment.center,
      child: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is GetAllSubCategoriesFailedState) {
            showSnackBar(
                context: context,
                title: 'Oh',
                content: state.message,
                contentType: ContentType.failure);
          }
        },
        buildWhen: (previous, current) => current is GetAllSubCategoriesState,
        builder: (context, state) {
          if (state is GetAllSubCategoriesSuccessState) {
            return GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
              ),
              scrollDirection:
                  Axis.horizontal, // Set scroll direction to horizontal
              itemCount: state.listOfSubCategories.length,
              itemBuilder: (BuildContext context, int index) {
                final currentSubCategory = state.listOfSubCategories[index];
                //this is the main column which will contain the two list parellel listviews
                return CategoryCircularContainer(
                  categoryName: currentSubCategory.categoryName,
                  imageURL: currentSubCategory.imageURL,
                );
              },
            );
          }
          return GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
            ),
            scrollDirection:
                Axis.horizontal, // Set scroll direction to horizontal
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              //this is the main column which will contain the two list parellel listviews
              return const CategoryCircularContainer();
            },
          );
        },
      ),
    );
  }
}

class CategoryCircularContainer extends StatelessWidget {
  const CategoryCircularContainer({
    super.key,
    this.categoryName,
    this.imageURL,
  });

  final String? categoryName;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //this is for the whole height of onw of the listview
        (categoryName == null)
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppPallete.primaryAppColor,
                  ),
                  margin: const EdgeInsets.all(5),
                  //
                  child: const Center(
                    child: Text(
                      'Item ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            : Container(
                height: 60,
                width: 60,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppPallete.primaryAppColor,
                    image: DecorationImage(image: NetworkImage(imageURL!))),
                margin: const EdgeInsets.all(5),
                //
                // child: Image.network(
                //   imageURL!,
                // ),
              ),

        (categoryName == null)
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: const Text(
                  'categoryName',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : Text(
                categoryName!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
                overflow: TextOverflow.ellipsis,
              ),
      ],
    );
  }
}
