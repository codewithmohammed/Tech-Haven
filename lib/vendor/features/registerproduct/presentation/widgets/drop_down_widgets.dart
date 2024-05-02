import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_drop_down.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/entities/category.dart';

class DropDownWidgets extends StatefulWidget {
  const DropDownWidgets(
      {super.key,
      required this.allCategories,
      // required this.mainCategoryIndex,
      // required this.subCategoryIndex,
      // required this.variantCategoryIndex,
      required this.categoryIndexes});

  final List<Category> allCategories;

  final List<int?> categoryIndexes;

  // int? mainCategoryIndex;
  // int? subCategoryIndex;
  // int? variantCategoryIndex;

  @override
  State<DropDownWidgets> createState() => _DropDownWidgetsState();
}

String? mainCategoryValue;
String? subCategoryValue;
String? variantCategoryValue;

// Getter methods to access index values
// int? get mainCategoryIndex => widget.categoryIndexes[0];
// int? get subCategoryIndex => widget.categoryIndexes[1];
// int? get variantCategoryIndex => widget.categoryIndexes[2];

class _DropDownWidgetsState extends State<DropDownWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropDown(
          currentItem: mainCategoryValue,
          items: widget.allCategories.map((e) => e.categoryName).toList(),
          onChanged: (value) {
            final categoryIndex = widget.allCategories
                .indexWhere((element) => element.categoryName == value);
            if (subCategoryValue == null) {
              setState(() {
                mainCategoryValue = value;
                widget.categoryIndexes[0] = categoryIndex;
              });
            } else {
              setState(() {
                mainCategoryValue = value;
                widget.categoryIndexes[0] = categoryIndex;
                subCategoryValue = null;
                widget.categoryIndexes[1] = null;
                widget.categoryIndexes[2] = null;
                variantCategoryValue = null;
              });
            }
          },
        ),
        Constants.kHeight,
        // droopdown for product main category
        CustomDropDown(
          currentItem: subCategoryValue,
          items: widget.categoryIndexes[0] != null
              ? widget.allCategories[widget.categoryIndexes[0]!].subCategories
                  .map((e) => e.categoryName)
                  .toList()
              : [],
          onChanged: (value) {
            final categoryIndex = widget
                .allCategories[widget.categoryIndexes[0]!].subCategories
                .indexWhere((element) => element.categoryName == value);
            setState(() {
              subCategoryValue = value;
              widget.categoryIndexes[1] = categoryIndex;
            });
          },
        ),
        CustomDropDown(
          currentItem: variantCategoryValue,
          items: widget.categoryIndexes[1] != null
              ? widget.allCategories[widget.categoryIndexes[0]!]
                  .subCategories[widget.categoryIndexes[1]!].subCategories
                  .map((e) => e.categoryName)
                  .toList()
              : [],
          onChanged: (value) {
            final categoryIndex = widget
                .allCategories[widget.categoryIndexes[0]!]
                .subCategories[widget.categoryIndexes[1]!]
                .subCategories
                .indexWhere((element) => element.categoryName == value);
            setState(() {
              variantCategoryValue = value;
              widget.categoryIndexes[2] = categoryIndex;
            });
          },
        ),
      ],
    );
  }
}
