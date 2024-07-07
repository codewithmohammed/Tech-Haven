import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tech_haven/core/common/data/model/payment_status.dart';

class StripeService {
  final String secretKey;

  StripeService(this.secretKey);

  Future<void> createPayout(
      {required int amount,
      required String currency,
      required String destination}) async {
    final url = Uri.parse('https://api.stripe.com/v1/transfers');

    final body = {
      'amount': amount.toString(),
      'currency': currency.toLowerCase(),
      'destination':
          destination, // This should be the recipient's Stripe account ID or connected account ID
      'transfer_group': 'ORDER_95',
    };

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $secretKey",
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );

    if (response.statusCode == 200) {
      jsonDecode(response.body);
    } else {
      throw Exception('Failed to create payout: ${response.reasonPhrase}');
    }
  }

  // final String apiKey =
  //     'sk_test_51PITFLIhpYTVpxkBNiZJBhx7dykQdGYwNOecnnjCxaZ0hpXuTqlqQQBHL2Kh3VIq4vfklyw70BqWfaRed7H3aXrD003YCcU8S7';
  final String baseUrl = 'https://api.stripe.com/v1';
  Future<List<PaymentStatus>> getLatestPayments() async {
    final response = await http.get(
      Uri.parse('$baseUrl/payment_intents?limit=10'),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> paymentsData = data['data'];
      return paymentsData
          .map((paymentJson) => PaymentStatus.fromJson(paymentJson))
          .toList();
    } else {
      throw Exception('Failed to load payments');
    }
  }
}

// Example usage
// void main() async {
//   final payoutService = StripeService('your_secret_key_here');
//   try {
//     await payoutService.createPayout(amount: 1000, currency: 'usd', destination: 'acct_1Gqj58Hpdw6KrtgH');
//   } catch (e) {
//   }
// }
