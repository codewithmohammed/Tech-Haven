import 'package:tech_haven/core/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.productID,
    required super.vendorID,
    required super.vendorName,
    required super.brandName,
    required super.name,
    required super.prize,
    required super.quantity,
    required super.mainCategory,
    required super.mainCategoryID,
    required super.subCategory,
    required super.subCategoryID,
    required super.variantCategory,
    required super.variantCategoryID,
    required super.overview,
    required super.specifications,
    required super.shippingCharge,
    required super.listOfImages,
    required super.rating,
    required super.isPublished, 
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productID: json['productID'],
      vendorID: json['vendorID'],
      vendorName: json['vendorName'],
      brandName: json['brandName'],
      name: json['name'],
      prize: json['prize'],
      quantity: json['quantity'],
      mainCategory: json['mainCategory'],
      mainCategoryID: json['mainCategoryID'],
      subCategory: json['subCategory'],
      subCategoryID: json['subCategoryID'],
      variantCategory: json['variantCategory'],
      variantCategoryID: json['variantCategoryID'],
      overview: json['overview'],
      specifications: json['specifications'],
      shippingCharge: json['shippingCharge'],
      listOfImages: json['listOfImages'],
      rating: json['rating'],
      isPublished: json['isPublished'],
    );
  }
  Map<String, dynamic> toJson() =>{
      'productID': productID,
      'vendorID': vendorID,
      'vendorName': vendorName,
      'brandName': brandName,
      'name': name,
      'prize': prize,
      'quantity': quantity,
      'mainCategory': mainCategory,
      'mainCategoryID': mainCategoryID,
      'subCategory': subCategory,
      'subCategoryID': subCategoryID,
      'variantCategory': variantCategory,
      'variantCategoryID': variantCategoryID,
      'overview': overview,
      'specifications': specifications ?? {},
      'shippingCharge': shippingCharge ?? 0,
      'rating': rating ?? 0,
      'isPublished': isPublished,
    };
}

// class ProductReviewsModel {
//   final String userID;
//   final String userName;
//   final String userImageURL;
//   final String ratingID;
//   final double rating;
//   final String comment;
//   final int helpful;

//   ProductReviewsModel({
//     required this.userID,
//     required this.userName,
//     required this.userImageURL,
//     required this.ratingID,
//     required this.rating,
//     required this.comment,
//     required this.helpful,
//   });
// }
