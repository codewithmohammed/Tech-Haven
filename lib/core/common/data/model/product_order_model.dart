import 'package:tech_haven/core/entities/product_order.dart';

class ProductOrderModel extends ProductOrder {
  // If ProductOrder class has these fields, then no need to redefine them here
  // final String productID;
  // final int quantity;
  // final double price;

  ProductOrderModel({
    required super.vendorID,
    required super.color,
    required super.productID,
    required super.shippingCharge,
    required super.productName,
    required super.quantity,
    required super.price,
  });

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) {
    // print('Raw JSON: $json');
    // print('Raw productName: ${json['productName']}');
    // print('Raw vendorID: ${json['vendorID']}');
    // print('Raw shippingCharge: ${json['shippingCharge']}');
    // print('Raw productID: ${json['productID']}');
    // print('Raw color: ${json['color']}');
    // print('Raw quantity: ${json['quantity']}');
    // print('Raw price: ${json['price']}');
    return ProductOrderModel(
      productName: json['productName'],
      vendorID: json['vendorID'],
      shippingCharge: json['shippingCharge'] is int
          ? (json['shippingCharge'] as int).toDouble()
          : json['shippingCharge'] as double,
      productID: json['productID'],
      color: json['color'] ?? 1,
      quantity: json['quantity'] as int,
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendorID': vendorID,
      'shippingCharge': shippingCharge,
      'productID': productID,
      'quantity': quantity,
      'productName': productName,
      'color': color,
      'price': price,
    };
  }
}
