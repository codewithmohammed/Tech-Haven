import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';

class GetAllFavoritedProductsHomePage implements UseCase<List<String>, NoParams> {
  final HomePageRepository homePageRepository;
  GetAllFavoritedProductsHomePage({required this.homePageRepository});

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await homePageRepository.getAllFavoritedProducts();
  }
}
