import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/product_order.dart';

class ProductOrderModel extends ProductOrder {
  // final String productID;
  // final int quantity;
  // final double price;

  ProductOrderModel({
    // required super.paymentID,
    required super.vendorID,
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
      shippingCharge: json['shippingCharge'],
      productID: json['productID'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendorID': vendorID,
      'shippingCharge': shippingCharge,
      'productID': productID,
      'quantity': quantity,
      'productName': productName,
      'price': price,
    };
  } 
}
