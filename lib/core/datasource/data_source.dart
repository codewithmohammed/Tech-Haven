
import 'package:tech_haven/user/features/searchcategory/data/models/category_model.dart';

abstract class DataSource {
  Stream<String> getUserData();
  Future<List<CategoryModel>> getAllCategoryData();
}
