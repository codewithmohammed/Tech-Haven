
import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

class AddReview implements UseCase<void, AddReviewParams> {
  final Repository repository;

  AddReview(this.repository);

  @override
  Future<Either<Failure, void>> call(AddReviewParams params) async {
    return await repository.addReview(
      product: params.product,
      userReview: params.userReivew,
      userRating: params.userRating,
    );
  }
}

class AddReviewParams {
  final String userReivew;
  final double userRating;
  final Product product;
  AddReviewParams(
      {required this.userRating,
      required this.userReivew,
      required this.product});
}
