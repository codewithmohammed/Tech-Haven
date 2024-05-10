import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/delete_product.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/get_all_category.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/register_new_product.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/update_existing_product.dart';

part 'register_product_event.dart';
part 'register_product_state.dart';

class RegisterProductBloc
    extends Bloc<RegisterProductEvent, RegisterProductState> {
  static bool isDataLoaded = false;
  static List<Category>? allCategoryModel;
  final GetAllCategoryForRegister _getAllCategoryForRegister;
  final RegisterNewProduct _registerNewProduct;
  final DeleteProduct _deleteProduct;
  final UpdateExistingProduct _updateExistingProduct;
  RegisterProductBloc({
    required GetAllCategoryForRegister getAllCategoryForRegister,
    required RegisterNewProduct registerNewProduct,
    required DeleteProduct deleteProduct,
    required UpdateExistingProduct updateExistingProduct,
  })  : _getAllCategoryForRegister = getAllCategoryForRegister,
        _registerNewProduct = registerNewProduct,
        _deleteProduct = deleteProduct,
        _updateExistingProduct = updateExistingProduct,
        super(RegisterProductInitial()) {
    on<RegisterProductEvent>((event, emit) {
      emit(RegisterProductLoading());
    });
    // on<EmitRegisterProductPageIniti
    on<GetAllCategoryEvent>(_onGetAllCategoryEvent);
    on<RegisterNewProductEvent>(_onRegisterNewProductEvent);
    on<DeleteTheProductEvent>(_onDeleteTheProductEvent);
    on<UpdateExistingProductEvent>(_onUpdateExistingProductEvent);
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
        allCategoryModel = success;
        emit(RegisterProductAllCategoryLoadedSuccess(
            allCategoryModel: allCategoryModel!));
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
      isPublished: event.isPublished,
    ));
    result.fold(
        (failure) => emit(NewProductRegisteredFailed(message: failure.message)),
        (registered) {
      return emit(
        NewProductRegisteredSuccess(newProductRegisterd: registered),
      );
    });
    emit(RegisterProductAllCategoryLoadedSuccess(
        allCategoryModel: allCategoryModel!));
  }

  FutureOr<void> _onDeleteTheProductEvent(
      DeleteTheProductEvent event, Emitter<RegisterProductState> emit) async {
    final result = await _deleteProduct(DeleteProductParams(
        product: event.product, mapOfListOfImages: event.mapOfListOfImages));

    result.fold(
        (failed) => emit(DeleteProductFailed(message: failed.message)),
        (success) => emit(DeleteProductSuccess(
              deleteSuccess: success,
            )));
  }

  FutureOr<void> _onUpdateExistingProductEvent(UpdateExistingProductEvent event,
      Emitter<RegisterProductState> emit) async {
    final result = await _updateExistingProduct(UpdateExistingProductParams(
        product: event.product,
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
        deleteImagesIndexes: event.deleteImagesIndexes,
        isPublished: event.isPublished));

    result.fold(
        (failure) => emit(NewProductRegisteredFailed(message: failure.message)),
        (registered) {
      return emit(
        NewProductRegisteredSuccess(newProductRegisterd: registered),
      );
    });
    emit(RegisterProductAllCategoryLoadedSuccess(
        allCategoryModel: allCategoryModel!));
  }
}
