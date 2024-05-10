import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';

abstract class ManageProductRepository{
   Future<Either<Failure, List<Product>>> getAllProducts();
}