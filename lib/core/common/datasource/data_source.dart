
import 'package:tech_haven/core/common/model/category_model.dart';

abstract class DataSource {
  Future<String> getUserData();
  Future<List<CategoryModel>> getAllCategoryData(bool refresh);
}
