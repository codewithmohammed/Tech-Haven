class UserOrderedProduct {
  final String brandID;
  final String brandName;
  final String displayImageURL;
  final String mainCategory;
  final String mainCategoryID;
  final DateTime dateTime;
  final int quantity;
  final String name;
  // final String locationDetails;
  final double oldPrize;
  final String orderID;
  final String overview;
  final double prize;
  final String productID;
  final double shippingCharge;
  final Map<String, dynamic> specifications;
  final String subCategory;
  final String subCategoryID;
  final String variantCategory;
  final String variantCategoryID;
  final String vendorID;
  final String vendorName;

  UserOrderedProduct({
    required this.brandID,
    required this.dateTime,
    required this.quantity,
    // required this.locationDetails,
    required this.brandName,
    required this.displayImageURL,
    required this.mainCategory,
    required this.mainCategoryID,
    required this.orderID,
    required this.name,
    required this.oldPrize,
    required this.overview,
    required this.prize,
    required this.productID,
    required this.shippingCharge,
    required this.specifications,
    required this.subCategory,
    required this.subCategoryID,
    required this.variantCategory,
    required this.variantCategoryID,
    required this.vendorID,
    required this.vendorName,
  });
}
