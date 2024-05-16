import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';

abstract class Repository {
  Future<Either<Failure, List<ProductModel>>> getAllProduct();
  Future<Either<Failure, List<ProductModel>>> getAllCartProduct();
  Future<Either<Failure, List<ProductModel>>> getAllFavoriteProduct();
  // Future<Either<Failure, List<Category>>> getAllSubCategory();
  Future<Either<Failure, bool>> updateProductToFavorite({
    required bool isFavorited,
    required Product product,
  });
  Future<Either<Failure, List<String>>> getAllFavorite();
  Future<Either<Failure, bool>> updateProductToCart({
    required int itemCount,
    required Product product,
    required Cart? cart,
  });
  Future<Either<Failure, List<CartModel>>> getAllCart();
  Future<Either<Failure, List<CategoryModel>>> getAllCategory();
  Future<Either<Failure,Map<int,List<Image>>>> getImagesForProduct({required String productID});
}
