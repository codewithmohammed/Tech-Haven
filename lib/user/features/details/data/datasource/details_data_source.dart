import 'package:tech_haven/core/common/data/model/review_model.dart';
import 'package:tech_haven/core/entities/review.dart';

abstract class DetailsDataSource {
  Future<List<ReviewModel>> getReviewsForProduct(String productId);
}
