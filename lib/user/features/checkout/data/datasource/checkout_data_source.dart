import 'dart:convert';

abstract class CheckoutDataSource {
  Future<dynamic> submitPaymentForm(
      {required String name,
      required String address,
      required String pin,
      required String city,
      required String state,
      required String country,
      required String currency,
      required String amount});
  Future<String> showPresentPaymentSheet();
}
