import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/utils/check_product_is_carted.dart';

double calculateTotalPrize(
    {required List<Product> products, required List<Cart> carts}) {
  double sum = 0;
  for (var product in products) {
    final cartIndex =
        checkCurrentProductIsCarted(product: product, carts: carts);
    sum += product.prize * carts[cartIndex].productCount;
  }
  return sum;
}

double calculateTotalShipping(
    {required List<Product> products, required List<Cart> carts}) {
  double sum = 0;
  for (var product in products) {
    sum += product.shippingCharge ?? 0;
  }
  return sum;
}

calculateTotalQuantity({required List<Cart> listOfCarts}) {
  int quantity = 0;
  for (var cart in listOfCarts) {
    quantity += cart.productCount;
  }
  return quantity;
}
