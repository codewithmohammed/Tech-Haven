import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_category_state.dart';

class SearchCategoryCubit extends Cubit<SearchCategoryState> {
  SearchCategoryCubit() : super(SearchCategoryInitial());
}
