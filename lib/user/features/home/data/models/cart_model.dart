import 'package:tech_haven/core/entities/cart.dart';

class CartModel extends Cart {
  CartModel({
    required super.cartID,
    required super.productID,
    required super.productCount,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      cartID: json['cartID'],
      productID: json['productID'],
      productCount: json['productCount']);

  Map<String, dynamic> toJson() => {
        'cartID': cartID,
        'productID': productID,
        'productCount': productCount,
      };
}
