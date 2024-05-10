import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/banner.dart';
import 'package:tech_haven/core/entities/product.dart';

import '../../../../../core/error/failures.dart';

abstract class HomePageRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, List<Banner>>> getAllBanners();
  Future<Either<Failure, bool>> updateProductToFavorite({
    required bool isFavorited,
    required Product product,
  });
  Future<Either<Failure, List<String>>> getAllFavoritedProducts();
}
