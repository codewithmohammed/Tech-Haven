import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';

class CarouselBannerContainer extends StatelessWidget {
  const CarouselBannerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 275,
          maxHeight: 410,
        ),
        child: BlocConsumer<HomePageBloc, HomePageState>(
          buildWhen: (previous, current) => current is BannerCarouselState,
          listener: (context, state) {
            if (state is GetAllBannerFailed) {
              showSnackBar(
                context: context,
                title: 'Oh',
                content: state.message,
                contentType: ContentType.failure,
              );
            }
          },
          builder: (context, state) {
            if (state is GetAllBannerSuccess) {
              // print('success');
              return CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9, // Set aspect ratio to 16:9
                  viewportFraction: 0.8, // Set width of carousel items
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                ),
                items:
                    //here there must be builder of items from the firebase
                    [
                  ...List.generate(state.listOfBanners.length, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppPallete.whiteColor,
                        boxShadow: const [Constants.globalBoxBlur],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            state.listOfBanners[index].imageURL,
                          ),
                        ),
                      ),
                    );
                  }),
                  Container(
                    // width: 480,
                    decoration: const BoxDecoration(
                      color: AppPallete.whiteColor,
                      boxShadow: [Constants.globalBoxBlur],
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            return CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 9, // Set aspect ratio to 16:9
                viewportFraction: 0.8, // Set width of carousel items
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                clipBehavior: Clip.antiAlias,
              ),
              items:
                  //here there must be builder of items from the firebase
                  [
                ...List.generate(10, (index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade100,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppPallete.whiteColor,
                        boxShadow: [Constants.globalBoxBlur],
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
