import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';

class UpdateProductToCartHomePage
    implements UseCase<List<Cart>, UpdateProductToCartHomePageParams> {
  final HomePageRepository homePageRepository;
  UpdateProductToCartHomePage({required this.homePageRepository});

  @override
  Future<Either<Failure, List<Cart>>> call(
      UpdateProductToCartHomePageParams params) async {
    return await homePageRepository.updateProductToCart(itemCount: params.itemCount, product: params.product,cart: params.cart);
  }
}

class UpdateProductToCartHomePageParams {
  final int itemCount;
  final Product product;
  final Cart? cart;
  UpdateProductToCartHomePageParams(
      {required this.itemCount, required this.product,required this.cart,});
}
