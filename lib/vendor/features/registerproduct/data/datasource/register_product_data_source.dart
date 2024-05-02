
import 'dart:io';

import 'package:tech_haven/core/common/model/category_model.dart';

abstract class RegisterProductDataSource {
  Future<List<CategoryModel>> getAllCategoryModel(bool refresh);
  Future<bool> registerNewProduct({
    required String brandName,
    required String name,
    required double prize,
    required int quantity,
    required String mainCategory,
    required String mainCategoryID,
    required String subCategory,
    required String subCategoryID,
    required String variantCategory,
    required String variantCategoryID,
    required String overview,
    required Map<String, String>? specifications,
    required double? shippingCharge,
    required Map<int, List<File>> productImages,
    required bool isPublished,
  });
}
