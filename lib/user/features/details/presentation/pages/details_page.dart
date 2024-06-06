import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_page_divider.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/available_color_horizontal_list_view.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/bottom_cart_quantity_and_button.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/details_grid_view_list_widget.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/overview_and_sprecification_tab_bar.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/product_brand_and_title.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/product_images_display_widget.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/star_widget.dart';
import 'package:tech_haven/user/features/details/presentation/widgets/user_review_container_widget.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //for the main products logic this is
      context
          .read<DetailsPageBloc>()
          .add(GetAllImagesForProductEvent(productID: product.productID));
      context
          .read<DetailsPageBloc>()
          .add(GetProductCartDetailsEvent(productID: product.productID));
      // for the related products
      context
          .read<DetailsPageBloc>()
          .add(GetAllBrandRelatedProductsDetailsEvent(product: product));
      // // print('next is getting all brand related cart details');
      // print('all the brand related product is gotten');
    });
      context.read<DetailsPageBloc>().add(GetProductFavoriteDetailsEvent());
    return Scaffold(
      appBar: const AppBarSearchBar(
        backButton: true,
        deliveryPlaceNeeded: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //for the brand name
              ProductBrandAndTitle(product: product),
              const SizedBox(
                height: 25,
              ),
              ProductImagesDisplayWidget(
                product: product,
              ),

              //for the indicator

              Container(),

              //for the prize tag
              SizedBox(
                height: 350,
                child: OverviewAndSpecificationTabBar(
                  overview: product.overview,
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
                    AvailableColorHorizontalListView(product: product),
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
              const UserReviewContainerWidget(),
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
                child: GlobalTitleText(
                  title: 'More From ${product.brandName}',
                  fontSize: 16,
                  color: AppPallete.primaryAppColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DetailsGridViewListWidget(
                product: product,
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BottomCartQuantityAndButton(product: product),
    );
  }
}
