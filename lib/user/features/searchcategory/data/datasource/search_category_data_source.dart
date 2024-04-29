import 'package:tech_haven/user/features/searchcategory/data/models/category_model.dart';

abstract class SearchCategoryDataSource {
  Future<List<CategoryModel>> getAllCategoryModel();
}
