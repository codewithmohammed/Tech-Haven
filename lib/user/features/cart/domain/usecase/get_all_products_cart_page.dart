import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/cart/domain/repository/cart_page_repository.dart';

class GetAllProductsCartPage implements UseCase<List<Product>, NoParams> {
  final CartPageRepository cartPageRepository;
  GetAllProductsCartPage({required this.cartPageRepository});

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await cartPageRepository.getAllProducts();
  }
}
