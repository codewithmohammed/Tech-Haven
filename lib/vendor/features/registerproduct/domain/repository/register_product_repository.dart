import 'dart:io';

import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import '../../../../../core/entities/category.dart';

abstract class RegisterProductRepository {
  Future<Either<Failure, List<Category>>> getAllCategories(bool refresh);
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
  });
    Future<Either<Failure, Map<int, List<model.Image>>>> getImagesForTheProduct(
    String productID,
  );
  Future<Either<Failure, bool>> deleteProduct({required Product product,required Map<int,List<model.Image>> mapOfListOfImages});
    Future<Either<Failure, bool>> updateExistingProduct({
      required Product product,
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
    required Map<int, List<File>>? productImages,
     required List<int> deleteImagesIndexes,
    required bool isPublished,
  });
}
