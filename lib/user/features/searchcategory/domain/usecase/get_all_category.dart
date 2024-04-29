import 'package:fpdart/fpdart.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/searchcategory/domain/repository/search_category_repository.dart';

class GetAllCategory implements UseCase<List<Category>, NoParams> {
  final SearchCategoryRepository searchCategoryRepository;
  GetAllCategory({required this.searchCategoryRepository});
  
  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async{
   return await searchCategoryRepository.getAllCategories();
  }
}