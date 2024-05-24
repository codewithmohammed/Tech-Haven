import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, dynamic>> submitPaymentForm(
      {required String name,
      required String address,
      required String pin,
      required String city,
      required String state,
      required String country,
      required String currency,
      required String amount});
  Future<Either<Failure, String>> showPresentPaymentSheet();
}
