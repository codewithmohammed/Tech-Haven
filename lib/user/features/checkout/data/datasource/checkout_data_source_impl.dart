import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/checkout/data/datasource/checkout_data_source.dart';

class CheckoutDataSourceImpl implements CheckoutDataSource {
  @override
  Future<dynamic> submitPaymentForm(
      {required String name,
      required String address,
      required String pin,
      required String city,
      required String state,
      required String country,
      required String currency,
      required String amount}) async {
    try {
      final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
      final secretKey = dotenv.env["STRIPE_SECRET_KEY"]!;
      final body = {
        'amount': amount,
        'currency': currency.toLowerCase(),
        'automatic_payment_methods[enabled]': 'true',
        'description': "Test Donation",
        'shipping[name]': name,
        'shipping[address][line1]': address,
        'shipping[address][postal_code]': pin,
        'shipping[address][city]': city,
        'shipping[address][state]': state,
        'shipping[address][country]': country
      };

      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer $secretKey",
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: body);

      // print(body);
      var json;
      // print(response.body);
      if (response.statusCode == 200) {
        json = jsonDecode(response.body);
      }
      await initPaymentSheet(data: json);
      return json;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<void> initPaymentSheet({required dynamic data}) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],

          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> showPresentPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(options: const PaymentSheetPresentOptions())
          .then((value) => print('object'));

      return 'success';
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
