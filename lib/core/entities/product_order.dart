class ProductOrder {
  final String vendorID;
  final String productID;
  final int quantity;
  final double shippingCharge;
  final double price;

  ProductOrder({
    // required this.paymentID,
    required this.vendorID,
    required this.productID,
    required this.quantity,
    required this.shippingCharge,
    required this.price,
  });
}
