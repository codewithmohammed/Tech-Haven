import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/custom_like_button.dart';
import 'package:tech_haven/core/common/widgets/square_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';

import '../../../../../core/constants/constants.dart';

class ProductImagesDisplayWidget extends StatelessWidget {
  const ProductImagesDisplayWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    void updateProductToFavorite(
        {required bool isFavorited, required Product product}) {
      print('hello how are you');
      context.read<DetailsPageBloc>().add(UpdateProductToFavoriteDetailsEvent(
          product: product, isFavorited: isFavorited));
    }

    CarouselController carouselController = CarouselController();
    return BlocConsumer<DetailsPageBloc, DetailsPageState>(
      listener: (context, state) {
        if (state is GetAllImagesForProductFailed) {
          Fluttertoast.showToast(msg: state.message);
        }
        if (state is UpdateProductToFavoriteSuccess) {
          Fluttertoast.showToast(msg: 'Favorite Updated SuccessFully');
          context.read<DetailsPageBloc>().add(GetProductFavoriteDetailsEvent());
        }
        if (state is UpdateProductToFavoriteFailed) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      buildWhen: (previous, current) => current is GetAllImagesForProductState,
      builder: (context, state) {
        if (state is GetAllImagesForProductSuccess) {
          // print('object');
          return Stack(
            children: [
              CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: state.allImages[state.currentSelectedIndex]!.length,
                itemBuilder: (context, index, realIndex) {
                  List<model.Image> images = [];
                  images = state.allImages[state.currentSelectedIndex]!;
                  return Hero(
                      tag: product.productID,
                      child: Image.network(
                        images[index].imageURL,
                      ));
                },
                options: CarouselOptions(
                  height: 350,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                ),
              ),
              Positioned(
                right: 10,
                top: 5,
                child: Column(
                  children: [
                    BlocBuilder<DetailsPageBloc, DetailsPageState>(
                      buildWhen: (previous, current) =>
                          current is GetProductFavoritedDetailsState,
                      builder: (context, state) {
                        if (state is GetProductFavoritedDetailsSuccess) {
                          // print('hello');
                          return CustomLikeButton(
                            isFavorited:
                                state.favorited.contains(product.productID),
                            onTapFavouriteButton: (bool isLiked) async {
                              updateProductToFavorite(
                                  isFavorited: !isLiked, product: product);
                              return !isLiked;
                            },
                          );
                        }
                        return CustomLikeButton(
                          isFavorited: false,
                          onTapFavouriteButton: (p1) async {
                            return null;
                          },
                        );
                      },
                    ),
                    Constants.kHeight,
                    const SquareButton(
                      icon: SvgIcon(
                        icon: CustomIcons.shareSvg,
                        color: AppPallete.greyTextColor,
                        radius: 5,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Stack(
          children: [
            CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: 1,
              itemBuilder: (context, index, realIndex) {
                return Hero(
                  tag: product.productID,
                  child: state is DetailsPageLoadingState
                      ? Image.network(product.displayImageURL)
                      : Image.network(product.displayImageURL),
                );
              },
              options: CarouselOptions(
                height: 350,
                viewportFraction: 1,
                enableInfiniteScroll: false,
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
              ),
            ),
          ],
        );
      },
    );
  }
}
