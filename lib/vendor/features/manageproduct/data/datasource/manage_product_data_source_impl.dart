import 'package:tech_haven/core/common/datasource/data_source.dart';
import 'package:tech_haven/core/common/model/product_model.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/vendor/features/manageproduct/data/datasource/manage_product_data_source.dart';

class ManageProductDataSourceImpl extends ManageProductDataSource {
  final DataSource dataSource;
  ManageProductDataSourceImpl({required this.dataSource});
  @override
  Future<List<ProductModel>> getAllProducts() {
    try {
      final allProducts = dataSource.getAllProductsData();
      return allProducts;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
