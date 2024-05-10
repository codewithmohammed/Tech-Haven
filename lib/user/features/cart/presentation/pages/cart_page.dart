import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/rectangular_product_card.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/cart/presentation/widgets/title_with_count_bar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var items = [
      '1',
      '2',
      '3',
      '4',
      '5',
    ];
    return Scaffold(
      appBar: const AppBarSearchBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            color: AppPallete.lightgreyColor,
            height: 50,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWithCountBar(
                  title: 'Cart',
                  itemsCount: '4 Items',
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                return RectangularProductCard(
                  items: items,
                  onTap: () {},
                  isFavoriteCard: false,
                  productName:
                      ' Sony PlayStation 5 Console (Disc Version) With Controller',
                  productPrize: '2888',
                  vendorName: 'Mohammed Rayid',
                  deliveryDate: 'Tomorrow 5 March',
                  productCount: 12,
                  productImage: null,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 10,
                  color: AppPallete.lightgreyColor,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
