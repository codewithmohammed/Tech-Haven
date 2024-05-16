import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';

// class GetAllProductsHomePage implements UseCase<List<Product>, NoParams> {
//   final HomePageRepository homePageRepository;
//   GetAllProductsHomePage({required this.homePageRepository});

//   @override
//   Future<Either<Failure, List<Product>>> call(NoParams params) async {
//     return await homePageRepository.getAllProducts();
//   }
// }
