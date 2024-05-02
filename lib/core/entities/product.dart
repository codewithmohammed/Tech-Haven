import 'package:tech_haven/core/entities/image.dart';

class Product {
  final String productID;
  final String vendorID;
  final String vendorName;
  final String brandName;
  final String name;
  final double prize;
  final int quantity;
  final String mainCategory;
  final String mainCategoryID;
  final String subCategory;
  final String subCategoryID;
  final String variantCategory;
  final String variantCategoryID;
  final String overview;
  final Map<String, String>? specifications;
  final double? shippingCharge;
  final Map<int,List<Image>> listOfImages;
  final double? rating;
  final bool isPublished;

  Product({
    required this.productID,
    required this.vendorID,
    required this.vendorName,
    required this.brandName,
    required this.name,
    required this.prize,
    required this.quantity,
    required this.mainCategory,
    required this.mainCategoryID,
    required this.subCategory,
    required this.subCategoryID,
    required this.variantCategory,
    required this.variantCategoryID,
    required this.overview,
    required this.specifications,
    required this.shippingCharge,
    required this.listOfImages,
    required this.rating,
    required this.isPublished,
  });
}
