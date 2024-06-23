import 'package:tech_haven/core/entities/user_ordered_product.dart';

class UserOrderedProductModel extends UserOrderedProduct {
  UserOrderedProductModel({
    required super.brandID,
    required super.brandName,
    required super.displayImageURL,
    required super.dateTime,
    required super.mainCategory,
    required super.mainCategoryID,
    required super.name,
    required super.oldPrize,
    required super.overview,
    required super.prize,
    // required super.locationDetails,
    required super.productID,
    required super.orderID,
    required super.shippingCharge,
    required super.specifications,
    required super.subCategory,
    required super.subCategoryID,
    required super.quantity,
    required super.variantCategory,
    required super.variantCategoryID,
    required super.vendorID,
    required super.vendorName,
  });

  factory UserOrderedProductModel.fromJson(Map<String, dynamic> json) {
    return UserOrderedProductModel(
      brandID: json['brandID'],
      brandName: json['brandName'],
      displayImageURL: json['displayImageURL'],
      mainCategory: json['mainCategory'],
      quantity: json['quantity'],
      mainCategoryID: json['mainCategoryID'],
      dateTime: DateTime.parse(json['dateTime']),
      name: json['name'],
      // locationDetails: json['locationDetails'],
      oldPrize: json['oldPrize'],
      orderID: json['orderID'],
      overview: json['overview'],
      prize: json['prize'],
      productID: json['productID'],
      shippingCharge: json['shippingCharge'],
      specifications: Map<String, dynamic>.from(json['specifications']),
      subCategory: json['subCategory'],
      subCategoryID: json['subCategoryID'],
      variantCategory: json['variantCategory'],
      variantCategoryID: json['variantCategoryID'],
      vendorID: json['vendorID'],
      vendorName: json['vendorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brandID': brandID,
      'brandName': brandName,
      'displayImageURL': displayImageURL,
      'mainCategory': mainCategory,
      'orderID': orderID,
      'mainCategoryID': mainCategoryID,
      'name': name,
      'dateTime': dateTime.toIso8601String(),
      'oldPrize': oldPrize,
      'overview': overview,
      'prize': prize,
      'productID': productID,
      'shippingCharge': shippingCharge,
      'specifications': specifications,
      'subCategory': subCategory,
      'subCategoryID': subCategoryID,
      'variantCategory': variantCategory,
      'variantCategoryID': variantCategoryID,
      'vendorID': vendorID,
      'vendorName': vendorName,
    };
  }
}
