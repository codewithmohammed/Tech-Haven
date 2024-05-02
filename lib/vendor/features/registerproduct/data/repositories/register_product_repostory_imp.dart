import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/datasource/register_product_data_source.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';

class RegisterProductRepositoryImpl extends RegisterProductRepository {
  final RegisterProductDataSource registerProductDataSource;
  RegisterProductRepositoryImpl({required this.registerProductDataSource});
  @override
  Future<Either<Failure, List<Category>>> getAllCategories(bool refresh) async {
    try {
      final result =
          await registerProductDataSource.getAllCategoryModel(refresh);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> registerNewProduct({
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
  }) async {
    try {
      final result = await registerProductDataSource.registerNewProduct(
        brandName: brandName,
        name: name,
        prize: prize,
        quantity: quantity,
        mainCategory: mainCategory,
        mainCategoryID: mainCategoryID,
        subCategory: subCategory,
        subCategoryID: subCategoryID,
        variantCategory: variantCategory,
        variantCategoryID: variantCategoryID,
        overview: overview,
        specifications: specifications,
        shippingCharge: shippingCharge,
        productImages: productImages,
        isPublished: isPublished,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
