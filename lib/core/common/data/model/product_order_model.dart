import 'package:tech_haven/core/entities/product_order.dart';

class ProductOrderModel extends ProductOrder {
  // final String productID;
  // final int quantity;
  // final double price;

  ProductOrderModel({
    // required super.paymentID,
    required super.vendorID,    required super.color,
    required super.productID,
    required super.shippingCharge,
    required super.productName,
    required super.quantity,
    required super.price,
  });

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) {
    return ProductOrderModel(
      // paymentID: json['payment_id'],
      productName: json['productName'],
      vendorID: json['vendorID'],
      shippingCharge: json['shippingCharge'] is int
          ? (json['shippingCharge'] as int).toDouble()
          : json['shippingCharge'] as double,
      productID: json['productID'],   color: json['color'],
      quantity: json['quantity'] as int,
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendorID': vendorID,
      'shippingCharge': double.parse('$shippingCharge'),
      'productID': productID,
      'quantity': quantity,
      'productName': productName,   'color':color,
      'price': double.parse('$price'),
    };
  }
}
