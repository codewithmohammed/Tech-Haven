import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_haven/core/common/widgets/custom_like_button.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/prize_data_widget.dart';
import 'package:tech_haven/core/common/widgets/square_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.index,
    required this.isHorizontal,
    required this.product,
    required this.onTapFavouriteButton,
    required this.isFavorited,
    // required this.currentCartedCount,
    // this.onTapCartButton,
    // this.onTapPlusButton,
    // this.onTapMinusButton,
    // required this.cartState,
    required this.shoppingCartWidget,
  });

  final int index;
  final bool isHorizontal;
  final Product? product;
  final bool isFavorited;
  final Future<bool?> Function(bool)? onTapFavouriteButton;
  // final int currentCartedCount;
  // final void Function()? onTapCartButton;
  // final void Function()? onTapPlusButton;
  // final void Function()? onTapMinusButton;
  // final UpdateProductToCartState cartState;
  final Widget shoppingCartWidget;

  @override
  Widget build(BuildContext context) {
    // int initialCount = totalItems;
    return Container(
      width: 185,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppPallete.appShadowColor,
            blurStyle: BlurStyle.normal,
            blurRadius: 5,
            spreadRadius: -3,
          ),
        ],
      ),
      margin: const EdgeInsets.all(5),
      child: product != null
          ? Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5,
                  ),
                ),
              ),
              color: AppPallete.whiteColor,
              child: InkWell(
                onTap: () {
                  GoRouter.of(context)
                      .pushNamed(AppRouteConstants.detailsPage, extra: product);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      //sized box for the image and the cart/favorite button
                      Expanded(
                        flex: 2,
                        child: Stack(
                          children: [
                            //image
                            Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppPallete.lightgreyColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5,
                                  ),
                                ),
                              ),
                              child: Hero(
                                  tag: product!.productID,
                                  child:
                                      Image.network(product!.displayImageURL)),
                            ),
                            //rating
                            Positioned(
                              bottom: 5,
                              left: 5,
                              child: Container(
                                height: 15,
                                width: 70,
                                decoration: const BoxDecoration(
                                  color: AppPallete.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppPallete.appShadowColor,
                                      blurStyle: BlurStyle.normal,
                                      blurRadius: 2,
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      product!.rating.toString(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SvgIcon(
                                      icon: CustomIcons.starSvg,
                                      radius: 10,
                                      color: Colors.green,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const Text(
                                      '(8K)',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: AppPallete.greyTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: CustomLikeButton(
                                isFavorited: isFavorited,
                                onTapFavouriteButton: onTapFavouriteButton,
                              ),
                            ),
                            //favorite
                          ],
                        ),
                      ),
                      //this is for the whole height of onw of the listview
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //product title
                            Text(
                              product!.name,
                              softWrap: true,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            //product price
                            SizedBox(
                              width: 150,
                              child: PrizeDataWidget(
                                totalHeight: 190,
                                prize: product!.prize.toString(),
                                offPercentage: '48%',
                                previousPrize: '3299',
                              ),
                            ),
                            Container(
                              height: 8,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppPallete.appShadowColor,
                                    blurStyle: BlurStyle.normal,
                                    blurRadius: 2,
                                  )
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade300,
              child: const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      5,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
