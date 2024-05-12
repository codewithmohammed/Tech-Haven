import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/banner.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/cart/data/datasource/cart_page_data_source.dart';
import 'package:tech_haven/user/features/cart/domain/repository/cart_page_repository.dart';

class CartPageRepositoryImpl extends CartPageRepository {
  final CartPageDataSource cartPageDataSource;
  CartPageRepositoryImpl({required this.cartPageDataSource});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final result = await cartPageDataSource.getAllProducts();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Banner>>> getAllBanners() async {
    try {
      final result = await cartPageDataSource.getAllBanners();
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
      // print('updating the favorite');
      final result = await cartPageDataSource.updateProductToFavorite(
          isFavorited: isFavorited, product: product);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllFavoritedProducts() async {
    try {
      // print('updating the favorite');
      final result = await cartPageDataSource.getAllFavoritedProducts();
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Cart>>> updateProductToCart(
      {required int itemCount, required Product product,required Cart? cart}) async {
    try {
      // print('updating the favorite');
      final result = await cartPageDataSource.updateProductToCart(
        itemCount: itemCount,
        product: product,
        cart:  cart
      );
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Cart>>> getAllCart() async {
    try {
      // print('updating the favorite');
      final result = await cartPageDataSource.getAllCart();
      // print('hello how are you');
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
