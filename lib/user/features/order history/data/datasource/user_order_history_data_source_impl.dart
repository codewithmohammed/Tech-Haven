import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/data/model/user_ordered_product_model.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/order%20history/data/datasource/user_order_history_data_source.dart';

class UserOrderHistoryDataSourceImpl implements UserOrderHistoryDataSource {
  final FirebaseFirestore firestore;

  UserOrderHistoryDataSourceImpl(this.firestore);

  @override
  Future<List<UserOrderedProductModel>> getProducts() async {
    try {
      final snapshot = await firestore
          .collection('userOrderedProducts')
          .doc('4q3TMZkh5zeWe3bxeVXBOmz3iev1')
          .collection('products')
          .get();
      return snapshot.docs
          .map((doc) => UserOrderedProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
