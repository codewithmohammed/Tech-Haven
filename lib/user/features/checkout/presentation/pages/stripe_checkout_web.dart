// @JS()
// library stripe;

// import 'package:flutter/material.dart';
// // import 'package:flutter_stripe_demo/constants.dart';
// import 'package:js/js.dart';

// void redirectToCheckout(BuildContext _, String priceID) async {
//   final stripe = Stripe(
//       'pk_test_51PITFLIhpYTVpxkBwnjQ3SN8NCGPQktZG5AkkcY0SNQ0bLzlulCDvUq2mA84qhEYJHdpCMYvNxpWmxGw5asi7MbD00Olbi90n8');
//   stripe.redirectToCheckout(CheckoutOptions(
//     lineItems: [
//       LineItem(price: priceID, quantity: 1),
//     ],
//     mode: 'payment',
//     successUrl: 'http://localhost:8080/#/success',
//     cancelUrl: 'http://localhost:8080/#/cancel',
//   ));
// }

// @JS()
// class Stripe {
//   external Stripe(String key);

//   external redirectToCheckout(CheckoutOptions options);
// }

// @JS()
// @anonymous
// class CheckoutOptions {
//   external List<LineItem> get lineItems;

//   external String get mode;

//   external String get successUrl;

//   external String get cancelUrl;

//   external factory CheckoutOptions({
//     List<LineItem> lineItems,
//     String mode,
//     String successUrl,
//     String cancelUrl,
//   });
// }

// @JS()
// @anonymous
// class LineItem {
//   external String get price;

//   external int get quantity;

//   external factory LineItem({String price, int quantity});
// }
