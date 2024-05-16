import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';

abstract class Repository {
  Future<Either<Failure, List<ProductModel>>> getAllProduct();
    // Future<Either<Failure, List<Category>>> getAllSubCategory();
  Future<Either<Failure, bool>> updateProductToFavorite({
    required bool isFavorited,
    required Product product,
  });
  Future<Either<Failure, List<String>>> getAllFavoriteProduct();
  Future<Either<Failure, List<CartModel>>> updateProductToCart({
    required int itemCount,
    required Product product,
    required Cart? cart,
  });
    Future<Either<Failure, List<CartModel>>> getAllCartProduct();
     Future<Either<Failure, List<CategoryModel
     >>> getAllCategory();
}
