import 'package:tech_haven/core/common/model/category_model.dart';
import 'package:tech_haven/core/common/model/image_model.dart';
import 'package:tech_haven/core/common/model/product_model.dart';
import 'package:tech_haven/core/common/model/user_model.dart';
import 'package:tech_haven/core/entities/product.dart';

abstract class DataSource {
  Future<UserModel?> getUserData();
  Future<List<CategoryModel>> getAllCategoryData(bool refresh);
  Future<List<ProductModel>> getAllProductsData();
  Future<Map<int, List<ImageModel>>> getImageForTheProduct(
      {required String productID});
  Future<bool> updateProductToFavorite(
      {required bool isFavorited, required Product product});
  Future<List<String>> getAllFavoritedProducts();
}
