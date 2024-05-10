import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:like_button/like_button.dart';
import 'package:tech_haven/core/common/widgets/square_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/icons/icons.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/remove_button.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/save_button.dart';

import '../../constants/constants.dart';

class RectangularProductCard extends StatelessWidget {
  const RectangularProductCard(
      {super.key,
      required this.items,
      required this.onTap,
      required this.isFavoriteCard,
      required this.productName,
      required this.productPrize,
      required this.vendorName,
      required this.deliveryDate,
      this.productCount = 0,
      this.onTapFavouriteButton,
      required this.productImage});
  final bool isFavoriteCard;
  final List<String> items;
  final void Function()? onTap;
  final String productName;
  final String productPrize;
  final String vendorName;
  final String deliveryDate;
  final int productCount;
  final String? productImage;
  final Future<bool?> Function(bool)? onTapFavouriteButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //for the heading
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Constants.kHeight,
                      //for the price
                      Row(
                        children: [
                          const Text(
                            'AED',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            productPrize,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Constants.kHeight,
                      //for the delivery
                      if (!isFavoriteCard)
                        Row(
                          children: [
                            const Text(
                              'Free Delivery by',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              deliveryDate,
                              style: const TextStyle(
                                color: AppPallete.primaryAppButtonColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      Constants.kHeight,
                      //for the vendor name
                      Row(
                        children: [
                          const Text('Sold by'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            vendorName,
                            style: const TextStyle(
                              // color: AppPallete.primaryAppButtonColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: productImage != null
                        ? Image.network(
                            productImage!,
                            fit: BoxFit.contain,
                          )
                        : Image.asset('assets/logo/techHavenLogo.png'),
                  ),
                ),
              ],
            ),
            Constants.kHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isFavoriteCard)
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 70,
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: 'Quantity',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.only(bottom: 2),
                            fillColor: AppPallete.darkgreyColor,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          width: 100,
                          height: 30,
                          child: SaveButton(
                            onPressed: () {},
                          )),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //remove button
                    if (!isFavoriteCard)
                      RemoveButton(
                        onTap: () {},
                      ),
                    //heart button
                    SquareButton(
                      // side: 45,
                      icon: LikeButton(
                        isLiked: true,
                        mainAxisAlignment: MainAxisAlignment.end,
                        animationDuration: const Duration(
                          milliseconds: 500,
                        ),
                        onTap: onTapFavouriteButton,
                        size: 20,
                        likeBuilder: (isLiked) {
                          return SvgIcon(
                            icon: isLiked
                                ? CustomIcons.heartFilledSvg
                                : CustomIcons.heartSvg,
                            color:
                                isLiked ? Colors.red : AppPallete.greyTextColor,
                            radius: 5,
                            fit: BoxFit.scaleDown,
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
