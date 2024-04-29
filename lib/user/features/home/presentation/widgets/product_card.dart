import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:tech_haven/core/common/widgets/shopping_cart_button.dart';
import 'package:tech_haven/core/icons/icons.dart';
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
  });

  final int index;
  final bool isHorizontal;
  @override
  Widget build(BuildContext context) {
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
      child: Card(
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
            GoRouter.of(context).pushNamed(
              AppRouteConstants.detailsPage,
            );
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
                          // image: DecorationImage(
                          //   image: AssetImage(
                          //     'assets/dev/iphone-png.png',
                          //   ),
                          // ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              5,
                            ),
                          ),
                        ),
                        child: Hero(
                          tag: isHorizontal ? '${index + 0.5}' : '$index',
                          child: Image.asset('assets/dev/iphone-png.png'),
                        ),
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '4.5',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SvgIcon(
                                icon: CustomIcons.starSvg,
                                radius: 10,
                                color: Colors.green,
                                fit: BoxFit.scaleDown,
                              ),
                              Text(
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
                        child: SquareButton(
                          // side: 45,
                          icon: LikeButton(
                            mainAxisAlignment: MainAxisAlignment.end,
                            animationDuration: const Duration(
                              milliseconds: 500,
                            ),
                            size: 20,
                            likeBuilder: (isLiked) {
                              return SvgIcon(
                                icon: isLiked
                                    ? CustomIcons.heartFilledSvg
                                    : CustomIcons.heartSvg,
                                color: isLiked
                                    ? Colors.red
                                    : AppPallete.greyTextColor,
                                radius: 5,
                                fit: BoxFit.scaleDown,
                              );
                            },
                          ),
                        ),
                      ),
                      //favorite
                      //cart
                      const Positioned(
                        bottom: 5,
                        right: 5,
                        child: ShoppingCartButton(),
                      ),
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
                      const Text(
                        'Sony Playstation 5 Digital Edition',
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      //product price
                      const SizedBox(
                        width: 150,
                        child: PrizeDataWidget(
                          totalHeight: 200,
                        ),
                      ),

                      //product offer green
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
      ),
    );
  }
}
