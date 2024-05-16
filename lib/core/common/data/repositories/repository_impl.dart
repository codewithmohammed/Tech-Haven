import 'package:fpdart/src/either.dart';
import 'package:tech_haven/core/common/data/datasource/data_source.dart';
import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';

class RepositoryImpl implements Repository {
  final DataSource dataSource;
  RepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<ProductModel>>> getAllCartProduct() async {
 try {
      final result = await dataSource.getAllCartProduct();
      print(result);
      return right(result);
    } on ServerException catch (e) {
      print(e);
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllFavoriteProduct() async {
    try {
      final result = await dataSource.getAllFavoriteProduct();
      print(result);
      return right(result);
    } on ServerException catch (e) {
      print(e);
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProduct() async {
    try {
      final result = await dataSource.getAllProduct();
      print(result);
      return right(result);
    } on ServerException catch (e) {
      print(e);
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProductToCart(
      {required int itemCount,
      required Product product,
      required Cart? cart}) async {
    try {
      // print('updating the favorite');
      final result = await dataSource.updateProductToCart(
          itemCount: itemCount, product: product, cart: cart);
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProductToFavorite({
    required bool isFavorited,
    required Product product,
  }) async {
    try {
      final result = await dataSource.updateProductToFavorite(
          isFavorited: isFavorited, product: product);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategory() async {
    try {
      final result = await dataSource.getAllCategory(false);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<CartModel>>> getAllCart()async {
      try {
      // print('updating the favorite');
      final result = await dataSource.getAllCart();
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<String>>> getAllFavorite()async {
    try {
      // print('updating the favorite');
      final result = await dataSource.getAllFavorite();
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map<int, List<Image>>>> getImagesForProduct({required String productID}) async{
       try {
      // print('updating the favorite');
      final result = await dataSource.getImagesForProduct(productID: productID);
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
