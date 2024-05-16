import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/common/data/model/image_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';

abstract class DataSource {
  Future<UserModel?> getUserData();
  Future<List<CategoryModel>> getAllCategoryData(bool refresh);
  Future<List<ProductModel>> getAllProductsData();
  Future<Map<int, List<ImageModel>>> getImageForTheProduct(
      {required String productID});
  Future<bool> updateProductToFavorite(
      {required bool isFavorited, required Product product});
  Future<List<String>> getAllFavoritedProducts();

  Future<List<CartModel>> getAllCart();
  Future<List<CartModel>> updateProductToCart(
      {required int itemCount, required Product product, required Cart? cart});

  Future<List<CategoryModel>> getAllSubCategories();
}
