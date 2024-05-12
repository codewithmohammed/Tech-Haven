import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';

import '../../../../../core/usecase/usecase.dart';

class GetAllCartHomePage implements UseCase<List<Cart>, NoParams> {
  final HomePageRepository homePageRepository;
  GetAllCartHomePage({required this.homePageRepository});

  @override
  Future<Either<Failure, List<Cart>>> call(NoParams params) async {
    return await homePageRepository.getAllCart();
  }
}
