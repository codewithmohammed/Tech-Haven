import 'package:tech_haven/core/datasource/data_source.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/searchcategory/data/datasource/search_category_data_source.dart';
import 'package:tech_haven/user/features/searchcategory/data/models/category_model.dart';

class SearchCategoryDataSourceImpl implements SearchCategoryDataSource {
  final DataSource dataSource;
  SearchCategoryDataSourceImpl({required this.dataSource});
  @override
  Future<List<CategoryModel>> getAllCategoryModel() async {
    try {
      final listOfCategories = await dataSource.getAllCategoryData();
      return listOfCategories;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
