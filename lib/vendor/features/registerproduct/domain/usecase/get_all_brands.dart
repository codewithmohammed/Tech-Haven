import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';

class GetAllBrands implements UseCase<List<Category>, NoParams> {
  final RegisterProductRepository registerProductRepository;
  GetAllBrands({
    required this.registerProductRepository,
  });

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await registerProductRepository.getAllBrands();
  }
}

// class GetAllBrandsParams {
//   final String productID;
//   GetAllBrandsParams({required this.productID});
// }
