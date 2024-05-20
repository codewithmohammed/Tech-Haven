import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/common/data/model/image_model.dart';
import 'package:tech_haven/core/common/data/model/location_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';

abstract class DataSource {
  Future<UserModel?> getUserData();
  Future<List<CategoryModel>> getAllCategory(bool refresh);
  Future<List<ProductModel>> getAllProduct();
  Future<List<ProductModel>> getAllCartProduct();
  Future<List<ProductModel>> getAllFavoriteProduct();
  Future<bool> updateProductToFavorite(
      {required bool isFavorited, required Product product});
  Future<List<String>> getAllFavorite();
  Future<List<CartModel>> getAllCart();
  Future<bool> updateProductToCart(
      {required int itemCount, required Product product, required Cart? cart});

  Future<List<CategoryModel>> getAllSubCategory();
  Future<Map<int, List<Image>>> getImagesForProduct(
      {required String productID});
  Future<List<ProductModel>> getAllBrandRelatedProduct(
      {required Product product});
  Future<bool> updateLocation(
      {
      required String name,
      required String phoneNumber,
      required String location,
      required String apartmentHouseNumber,
      required String emailAddress,
      required String addressInstructions});

  Future<LocationModel?> getCurrentLocationDetails();
}
