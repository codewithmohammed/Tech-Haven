import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/cart/domain/repository/cart_page_repository.dart';

// class UpdateProductToCartCartPage
//     implements UseCase<List<Cart>, UpdateProductToCartCartPageParams> {
//   final CartPageRepository cartPageRepository;
//   UpdateProductToCartCartPage({required this.cartPageRepository});

//   @override
//   Future<Either<Failure, List<Cart>>> call(
//       UpdateProductToCartCartPageParams params) async {
//     return await cartPageRepository.updateProductToCart(
//         itemCount: params.itemCount,
//         product: params.product,
//         cart: params.cart);
//   }
// }

// class UpdateProductToCartCartPageParams {
//   final int itemCount;
//   final Product product;
//   final Cart? cart;
//   UpdateProductToCartCartPageParams({
//     required this.itemCount,
//     required this.product,
//     required this.cart,
//   });
// }
