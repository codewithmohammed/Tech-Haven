import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/get_all_category.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/register_new_product.dart';

part 'register_product_event.dart';
part 'register_product_state.dart';

class RegisterProductBloc
    extends Bloc<RegisterProductEvent, RegisterProductState> {
  static bool isDataLoaded = false;
  final GetAllCategoryForRegister _getAllCategoryForRegister;
  final RegisterNewProduct _registerNewProduct;
  RegisterProductBloc(
      {required GetAllCategoryForRegister getAllCategoryForRegister,
      required RegisterNewProduct registerNewProduct})
      : _getAllCategoryForRegister = getAllCategoryForRegister,
        _registerNewProduct = registerNewProduct,
        super(RegisterProductInitial()) {
    on<RegisterProductEvent>((event, emit) {
      emit(RegisterProductLoading());
    });
    on<GetAllCategoryEvent>(_onGetAllCategoryEvent);
    on<RegisterNewProductEvent>(_onRegisterNewProductEvent);
  }

  FutureOr<void> _onGetAllCategoryEvent(
      GetAllCategoryEvent event, Emitter<RegisterProductState> emit) async {
    if (isDataLoaded == false) {
      final result = await _getAllCategoryForRegister(
          GetAllCategoryForRegiseterParams(refresh: event.refreshPage));

      result.fold(
          (failure) => emit(
              RegisterProductAllCategoryLoadedFailed(message: failure.message)),
          (success) {
        isDataLoaded = true;
        emit(
            RegisterProductAllCategoryLoadedSuccess(allCategoryModel: success));
      });
    }
  }

  FutureOr<void> _onRegisterNewProductEvent(
      RegisterNewProductEvent event, Emitter<RegisterProductState> emit) async {
    final result = await _registerNewProduct(RegisterNewProductParams(
        brandName: event.brandName,
        productName: event.productName,
        productPrize: event.productPrize,
        productQuantity: event.productQuantity,
        mainCategory: event.mainCategory,
        mainCategoryID: event.mainCategoryID,
        subCategory: event.subCategory,
        subCategoryID: event.subCategoryID,
        variantCategory: event.variantCategory,
        variantCategoryID: event.variantCategoryID,
        productOverview: event.productOverview,
        specifications: {},
        shippingCharge: event.shippingCharge,
        productImages: event.productImages,
        isPublished: event.isPublished, ));
    result.fold((l) => Failure(l.message), (r) => null);
  }
}
