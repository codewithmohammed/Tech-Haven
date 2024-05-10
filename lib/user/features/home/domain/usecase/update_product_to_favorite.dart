import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';

class UpdateProductToFavorite
    implements UseCase<bool, UpdateProductToFavoriteParams> {
  final HomePageRepository homePageRepository;
  UpdateProductToFavorite({required this.homePageRepository});

  @override
  Future<Either<Failure, bool>> call(
      UpdateProductToFavoriteParams params) async {
    return await homePageRepository.updateProductToFavorite(isFavorited: params.isFavorited, product: params.product);
  }
}

class UpdateProductToFavoriteParams {
  final bool isFavorited;
  final Product product;

  UpdateProductToFavoriteParams(
      {required this.isFavorited, required this.product});
}
