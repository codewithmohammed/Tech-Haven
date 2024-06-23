import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/user_ordered_product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/order%20history/domain/repository/user_order_history_repositry.dart';

class GetAllUserOrderHistoryUseCase implements UseCase<List<UserOrderedProduct>, NoParams> {
  final UserOrderHistoryRepository userOrderHistoryRepository;

  GetAllUserOrderHistoryUseCase({required this.userOrderHistoryRepository});

  @override
  Future<Either<Failure, List<UserOrderedProduct>>> call(NoParams params) async {
    return await userOrderHistoryRepository.getProducts();
  }
}

class NoParams {}
