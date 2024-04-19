import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class CategoryIconListView extends StatelessWidget {
  const CategoryIconListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Fixed height for horizontal list
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
        ),
        scrollDirection: Axis.horizontal, // Set scroll direction to horizontal
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          //this is the main column which will contain the two list parellel listviews
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //this is for the whole height of onw of the listview
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPallete.primaryAppColor,
                ),
                margin: const EdgeInsets.all(5),
                //
                child: Center(
                  child: Text(
                    'Item ${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Text(
                'category',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}
