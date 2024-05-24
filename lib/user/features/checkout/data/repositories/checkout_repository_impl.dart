import 'dart:convert';

import 'package:fpdart/src/either.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:tech_haven/user/features/checkout/domain/repository/checkout_repository.dart';

class CheckoutRepositoryImpl extends CheckoutRepository {
  final CheckoutDataSource checkoutDataSource;
  CheckoutRepositoryImpl({required this.checkoutDataSource});
  @override
  Future<Either<Failure, dynamic>> submitPaymentForm(
      {required String name,
      required String address,
      required String pin,
      required String city,
      required String state,
      required String country,
      required String currency,
      required String amount}) async {
             try {
      final result = await checkoutDataSource.submitPaymentForm(name: name, address: address, pin: pin, city: city, state: state, country: country, currency: currency, amount: amount);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
      }
      
        @override
        Future<Either<Failure, String>> showPresentPaymentSheet() async{
                   try {
      final result = await checkoutDataSource.showPresentPaymentSheet();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
        }
}
