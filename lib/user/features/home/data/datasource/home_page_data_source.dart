import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/user/features/home/data/models/banner_model.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';

abstract class HomePageDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<BannerModel>> getAllBanners();
  Future<bool> updateProductToFavorite(
      {required bool isFavorited, required Product product});
  Future<List<String>> getAllFavoritedProducts();
  Future<List<Cart>> updateProductToCart(
      {required int itemCount, required Product product,required Cart? cart});

  Future<List<CartModel>> getAllCart();
    Future<List<CategoryModel>> getAllSubCategories();
}
