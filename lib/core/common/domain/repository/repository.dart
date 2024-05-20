import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/location.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class Repository {
  Future<Either<Failure, List<Product>>> getAllProduct();
  Future<Either<Failure, List<Product>>> getAllCartProduct();
  Future<Either<Failure, List<Product>>> getAllFavoriteProduct();
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
  Future<Either<Failure, List<Cart>>> getAllCart();
  Future<Either<Failure, List<Category>>> getAllCategory();
  Future<Either<Failure, Map<int, List<Image>>>> getImagesForProduct(
      {required String productID});
  Future<Either<Failure, List<Product>>> getAllBrandRelatedProduct(
      {required Product product});
  Future<Either<Failure, bool>> updateLocation(
      {
      required String name,
      required String phoneNumber,
      required String location,
      required String apartmentHouseNumber,
      required String emailAddress,
      required String addressInstructions});

  Future<Either<Failure, Location?>> getCurrentLocationDetails();
  Future<Either<Failure, User?>> getUserData();
}
