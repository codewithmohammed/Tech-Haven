import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tech_haven/core/common/data/model/order_model.dart';
import 'package:tech_haven/core/common/data/model/payment_model.dart';
import 'package:tech_haven/core/common/data/model/product_order_model.dart';
import 'package:tech_haven/core/common/data/model/vendor_payment_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/utils/sum.dart';
import 'package:tech_haven/user/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:tech_haven/user/features/checkout/data/models/payment_intent_model.dart';
import 'package:uuid/uuid.dart';
// import 'package:tech_haven/user/features/checkout/domain/usecase/send_order.dart';

class CheckoutDataSourceImpl implements CheckoutDataSource {
  final FirebaseFirestore firebaseFirestore;
  CheckoutDataSourceImpl({required this.firebaseFirestore});
  @override
  Future<PaymentIntentModel> submitPaymentForm(
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
      PaymentIntentModel paymentIntentModel;
      dynamic jsonResponse;
      if (response.statusCode == 200) {
        jsonResponse = jsonDecode(response.body);
        debugPrint(response.body);
        // print(jsonResponse);
        // Create a PaymentIntentModel object from the JSON response
        paymentIntentModel = PaymentIntentModel.fromJson(jsonResponse);
        // print('okda mone');
        // Use debugPrint to output the paymentIntentModel details
        // debugPrint('Payment Intent: ${paymentIntentModel.toJson()}');
        // print('hello how are you ');
      } else {
        throw ServerException(response.reasonPhrase.toString());
      }
      // print(body);
      // var json;

      // debugPrint(response.body);
      // if (response.statusCode == 200) {
      //   json = jsonDecode(response.body);
      // }

      // OrderDetails orderDetails = OrderDetails.fromJson(jsonDecode(json));

      // print(paymentIntentModel.amount);
      await initPaymentSheet(data: jsonResponse);
      return paymentIntentModel;
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
  Future<PaymentIntentModel> showPresentPaymentSheet(
      {required PaymentIntentModel paymentIntentModel}) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(options: const PaymentSheetPresentOptions());

      return paymentIntentModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> sendOrder({
    required PaymentIntentModel paymentIntentModel,
    required List<Product> products,
    required List<Cart> carts,
    required User user,
  }) async {
    try {
      String orderID = const Uuid().v4();
      print(1);
      DateTime orderDateWithTime = DateTime.now();

      List<ProductOrderModel> listOfProductOrderModel = [];

      Map<String, List<ProductOrderModel>> mapOfvendorProducts = {};
      // print('start');
      // Populate mapOfvendorProducts and listOfProductOrderModel

      for (int i = 0; i < carts.length; i++) {
        // print(carts[i].productID);
        Product product = products
            .firstWhere((element) => element.productID == carts[i].productID);
        if (mapOfvendorProducts[product.vendorID] != null) {
          mapOfvendorProducts[product.vendorID]!.add(ProductOrderModel(
            vendorID: product.vendorID,
            shippingCharge: product.shippingCharge ?? 0,
            productID: carts[i].productID,
            quantity: carts[i].productCount,
            price: product.prize,
          ));
        } else {
          mapOfvendorProducts[product.vendorID] = [
            ProductOrderModel(
              shippingCharge: product.shippingCharge ?? 0,
              vendorID: product.vendorID,
              productID: carts[i].productID,
              quantity: carts[i].productCount,
              price: product.prize,
            )
          ];
        }
        // print(product.vendorID);
        listOfProductOrderModel.add(ProductOrderModel(
          vendorID: product.vendorID,
          productID: carts[i].productID,
          shippingCharge: product.shippingCharge ?? 0,
          quantity: carts[i].productCount,
          price: product.prize,
        ));
      }
      // print('iterate finished');
      for (var entry in mapOfvendorProducts.entries) {
        var vendorID = entry.key;
        VendorPaymentModel vendorPaymentModel = VendorPaymentModel(
          vendorID: vendorID,
          dateTime: orderDateWithTime,
          paymentID: paymentIntentModel.id,
          totalAmount: paymentIntentModel.amount,
          orderID: orderID,
        );
// RevenueModel(currentBalance: currentBalance, vendorID: vendorID, withdrewAmount: withdrewAmount)
        print(2);
        await firebaseFirestore.collection('revenues').doc(vendorID).set({
          'currentBalance': FieldValue.increment(
            calculateTotalPrizeForVendorOrdrer(
              productOrderModel: entry.value,
            ),
          )
        }, SetOptions(merge: true));

        await firebaseFirestore
            .collection('revenues')
            .doc(vendorID)
            .collection('paymentHistory')
            .doc(orderID)
            .set(vendorPaymentModel.toJson());
        print(3);
        // await firebaseFirestore
        //     .collection('revenues')
        //     .doc(vendorID)
        //     .collection('paymentHistory')
        //     .doc(orderID)
        //     .set(paymentIntentModel.toJson());
        //first we create a vendor id with some data
        // print('addding data to vendororder');
        print(4);
        await firebaseFirestore
            .collection('vendorOrders')
            .doc(vendorID)
            .set(vendorPaymentModel.toJson());

        final OrderModel orderModel = OrderModel(
          orderID: orderID,
          orderDate: orderDateWithTime,
          deliveryDate: orderDateWithTime.add(const Duration(days: 7)),
          products: entry.value,
          userID: user.uid!,
          deliveredProducts: [],
          paymentID: paymentIntentModel.id,
          name: paymentIntentModel.shippingModel.name,
          address: paymentIntentModel.shippingModel.addressModel.line1,
          pin: paymentIntentModel.shippingModel.addressModel.postalCode,
          city: paymentIntentModel.shippingModel.addressModel.city,
          state: paymentIntentModel.shippingModel.addressModel.state,
          country: paymentIntentModel.shippingModel.addressModel.country,
          currency: paymentIntentModel.currency,
          totalAmount: paymentIntentModel.amount,
        );
        print(5);
        await firebaseFirestore
            .collection('vendorOrders')
            .doc(vendorID)
            .collection('orderDetails')
            .doc(orderID)
            .set(orderModel.toJson());
      }
      // print('adding data to userorder');
      final OrderModel orderModel = OrderModel(
        orderID: orderID,
        orderDate: orderDateWithTime,
        deliveryDate: orderDateWithTime.add(const Duration(days: 7)),
        products: listOfProductOrderModel,
        deliveredProducts: [],
        userID: user.uid!,
        name: paymentIntentModel.shippingModel.name,
        paymentID: paymentIntentModel.id,
        address: paymentIntentModel.shippingModel.addressModel.line1,
        pin: paymentIntentModel.shippingModel.addressModel.postalCode,
        city: paymentIntentModel.shippingModel.addressModel.city,
        state: paymentIntentModel.shippingModel.addressModel.state,
        country: paymentIntentModel.shippingModel.addressModel.country,
        currency: paymentIntentModel.currency,
        // shippingCharge: ,
        totalAmount: paymentIntentModel.amount,
      );
      // final PaymentModel paymentModel = PaymentModel(
      //   userID: user.uid!,
      //   userName: user.username!,
      //   paymentID: paymentIntentModel.id,
      // );
      // print(6);
      // await firebaseFirestore
      //     .collection('userOrders')
      //     .doc(user.uid!)
      //     .set(paymentModel.toJson());
      print(7);
      await firebaseFirestore
          .collection('userOrders')
          .doc(user.uid!)
          .collection('orderDetails')
          .doc(orderID)
          .set(orderModel.toJson());

      print('ok');

      return 'success';
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
