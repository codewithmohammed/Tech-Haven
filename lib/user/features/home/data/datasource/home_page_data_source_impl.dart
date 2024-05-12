import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/datasource/data_source.dart';
import 'package:tech_haven/core/common/model/product_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/home/data/datasource/home_page_data_source.dart';
import 'package:tech_haven/user/features/home/data/models/banner_model.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';

class HomePageDataSourceImpl extends HomePageDataSource {
  final DataSource dataSource;
  final FirebaseFirestore firebaseFirestore;
  // final FirebaseStorage firebaseStorage;
  HomePageDataSourceImpl({
    required this.dataSource,
    required this.firebaseFirestore,
    // required this.firebaseStorage
  });
  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final allProducts = await dataSource.getAllProductsData();
      return allProducts;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BannerModel>> getAllBanners() async {
    try {
      QuerySnapshot<Map<String, dynamic>> bannerSnapshot =
          await firebaseFirestore.collection('banners').get();

      List<BannerModel> listOfBannerModel = [];
      for (var doc in bannerSnapshot.docs) {
        listOfBannerModel.add(BannerModel.fromJson(doc.data()));
      }
      return listOfBannerModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> updateProductToFavorite(
      {required bool isFavorited, required Product product}) async {
    try {
      await dataSource.updateProductToFavorite(
        isFavorited: isFavorited,
        product: product,
      );
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> getAllFavoritedProducts() async {
    try {
      return await dataSource.getAllFavoritedProducts();
      // return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CartModel>> updateProductToCart(
      {required int itemCount,
      required Product product,
      required Cart? cart}) async {
    try {
      return await dataSource.updateProductToCart(
          itemCount: itemCount, product: product, cart: cart);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CartModel>> getAllCart() async {
    try {
      return dataSource.getAllCart();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
