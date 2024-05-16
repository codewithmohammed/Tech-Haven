import 'package:tech_haven/core/common/data/model/product_model.dart';

abstract class ManageProductDataSource{
  Future<List<ProductModel>> getAllProducts();
}