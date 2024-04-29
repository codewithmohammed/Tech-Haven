import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/cubit/search_category_state.dart';

class SearchCategoryCubit extends Cubit<SearchCategoryCubitState> {
  SearchCategoryCubit() : super(const SearchCategoryCubitState(0, null, null));

  void selectCategory(int index) {
    emit(SearchCategoryCubitState(
        index, state.openedAccordionIndex, state.pageOfcurrentAccordionIndex));
  }

  void toggleAccordion(int pageIndex, int accordionIndex) {
    emit(SearchCategoryCubitState(
      state.currentIndex,
      accordionIndex == state.openedAccordionIndex ? null : accordionIndex,
      pageIndex,
    ));
  }
}
