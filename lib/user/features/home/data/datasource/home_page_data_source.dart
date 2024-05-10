import 'package:tech_haven/core/common/model/product_model.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/user/features/home/data/models/banner_model.dart';

abstract class HomePageDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<BannerModel>> getAllBanners();
  Future<bool> updateProductToFavorite(
      {required bool isFavorited, required Product product});
  Future<List<String>> getAllFavoritedProducts();
}
