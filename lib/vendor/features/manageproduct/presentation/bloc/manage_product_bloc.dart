import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/usecase/get_all_products.dart';

part 'manage_product_event.dart';
part 'manage_product_state.dart';

class ManageProductBloc extends Bloc<ManageProductEvent, ManageProductState> {
  static bool isDataLoaded = false;
  final GetAllProducts _getAllProducts;
  ManageProductBloc({required GetAllProducts getAllProducts})
      : _getAllProducts = getAllProducts,
        super(ManageProductInitial()) {
    on<ManageProductEvent>((event, emit) {
      emit(ManageProductLoadingState());
    });
    on<GetAllProductsEvent>(_onGetAllProductEvent);
  }

  FutureOr<void> _onGetAllProductEvent(
      GetAllProductsEvent event, Emitter<ManageProductState> emit) async {
    final result = await _getAllProducts(NoParams());
    result
        .fold((failure) => emit(GetAllProductFailed(message: failure.message)),
            (listOfProducts) {
      isDataLoaded = true;
      emit(GetAllProductsSuccess(listOfProductModel: listOfProducts));
    });
  }
}
