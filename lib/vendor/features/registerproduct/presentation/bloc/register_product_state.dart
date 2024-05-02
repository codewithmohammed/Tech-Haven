part of 'register_product_bloc.dart';

sealed class RegisterProductState  {
  const RegisterProductState();

}

final class RegisterProductInitial extends RegisterProductState {}

final class RegisterProductPageActionState extends RegisterProductPageState {}

final class RegisterProductLoading extends RegisterProductPageActionState {}

final class RegisterProductPageState extends RegisterProductState {}

final class RegisterProductAllCategoryLoadedSuccess
    extends RegisterProductPageActionState {
  final List<Category> allCategoryModel;
  RegisterProductAllCategoryLoadedSuccess({
    required this.allCategoryModel,
  });
}

final class RegisterProductAllCategoryLoadedFailed
    extends RegisterProductPageActionState {
  final String message;
  RegisterProductAllCategoryLoadedFailed({required this.message});
}


final class CategoryDropDownState extends RegisterProductPageState {}

