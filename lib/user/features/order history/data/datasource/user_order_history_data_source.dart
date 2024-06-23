import 'package:tech_haven/core/common/data/model/user_ordered_product_model.dart';
import 'package:tech_haven/core/entities/product.dart';

abstract class UserOrderHistoryDataSource {
  Future<List<UserOrderedProductModel>> getProducts();
}
