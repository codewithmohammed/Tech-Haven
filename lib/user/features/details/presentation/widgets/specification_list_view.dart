
import 'package:flutter/material.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class SpecificationListView extends StatelessWidget {
  const SpecificationListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: index % 2 != 0
                    ? AppPallete.primaryAppColor
                        .withOpacity(
                        0.5,
                      )
                    : AppPallete.whiteColor,
                borderRadius:const BorderRadius.all(
                  Radius.circular(
                    3,
                  ),
                )),
            child: const Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                Text('Spec Type'),
                Text('Spec Value'),
              ],
            ),
          );
        },
      ),
    );
  }
}
