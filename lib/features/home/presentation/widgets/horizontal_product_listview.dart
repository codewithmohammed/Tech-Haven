import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/features/home/presentation/widgets/product_card.dart';

class HorizontalProductListView extends StatelessWidget {
  const HorizontalProductListView({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
              // physics: const BouncingScrollPhysics(),
              scrollDirection:
                  Axis.horizontal, // Set scroll direction to horizontal
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                //column since the container is divided into two
                return  ProductCard(index: index,);
              },
            ),
          ),
        ],
      ),
    );
  }
}

