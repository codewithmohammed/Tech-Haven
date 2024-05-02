part of 'search_category_cubit.dart';

sealed class SearchCategoryState extends Equatable {
  const SearchCategoryState();

  @override
  List<Object> get props => [];
}

final class SearchCategoryInitial extends SearchCategoryState {}
