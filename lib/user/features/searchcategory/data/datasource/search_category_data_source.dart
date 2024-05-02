import 'package:tech_haven/core/common/model/category_model.dart';

abstract class SearchCategoryDataSource {
  Future<List<CategoryModel>> getAllCategoryModel(bool refresh);
}
