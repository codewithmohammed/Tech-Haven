import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';
// import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';

// class GetImagesForTheProduct implements UseCase<Map<int,List<Image>>, GetImagesForTheProductParams> {
//   final RegisterProductRepository registerProductRepository;
//   GetImagesForTheProduct({
//     required this.registerProductRepository,
//   });

//   @override
//   Future<Either<Failure, Map<int,List<Image>>>> call(GetImagesForTheProductParams params) async {
//     return await registerProductRepository.getImagesForTheProduct(params.productID);
//   }
// }

// class GetImagesForTheProductParams {
//   final String productID;
//   GetImagesForTheProductParams({required this.productID});
// }
