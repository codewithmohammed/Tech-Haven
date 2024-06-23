import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';

import '../../../../../core/entities/user_ordered_product.dart';

abstract class UserOrderHistoryRepository {
  Future<Either<Failure, List<UserOrderedProduct>>> getProducts();
}
