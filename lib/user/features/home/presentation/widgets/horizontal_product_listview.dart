import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/user/features/home/presentation/widgets/product_card.dart';
// import 'package:shimmer/shimmer.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) { 
     void updateProductToFavorite(
      Product product, bool isLiked) { print('updating the favorite');
    context.read<HomePageBloc>().add(
          UpdateProductToFavoriteEvent(
            product: product,
            isFavorited: !isLiked,
          ),
        );
  }
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
            child: BlocConsumer<HomePageBloc, HomePageState>(
              buildWhen: (previous, current) =>
                  current is HorizontalProductListViewState,
              listener: (context, state) {
                if (state is HorizontalProductsListViewFailed) {
                  return showSnackBar(
                      context: context,
                      title: 'Oh',
                      content: state.message,
                      contentType: ContentType.failure);
                }
              },
              builder: (context, state) {
                final List<Product>? listOfProduct =
                    state is HorizontalProductsListViewSuccess
                        ? state.listOfProducts
                        : null;
                // print('object');
                return ListView.builder(
                  // physics: const BouncingScrollPhysics(),
                  scrollDirection:
                      Axis.horizontal, // Set scroll direction to horizontal
                  itemCount: listOfProduct != null ? listOfProduct.length : 10,
                  itemBuilder: (BuildContext context, int index) {
                    //column since the container is divided into two
                    return ProductCard(
                      listOfFavoritedProducts:  state is HorizontalProductsListViewSuccess
                        ? state.listOfFavoritedProducts
                        : null,
                      index: index,
                      isHorizontal: true,
                      product:
                          listOfProduct != null ? listOfProduct[index] : null,
                      onTapFavouriteButton: (bool isLiked) async {
                       
                        updateProductToFavorite(
                            listOfProduct![index], isLiked);
                        return isLiked ? false : true;
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }


}
