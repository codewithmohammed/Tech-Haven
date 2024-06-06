import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/usecase/get_all_products.dart';

part 'manage_product_event.dart';
part 'manage_product_state.dart';

class ManageProductBloc extends Bloc<ManageProductEvent, ManageProductState> {
  static bool isDataLoaded = false;
  final GetAllProducts _getAllProducts;
  final GetUserData _getUserData;
  ManageProductBloc(
      {required GetAllProducts getAllProducts,
      required GetUserData getUserData})
      : _getUserData = getUserData,
        _getAllProducts = getAllProducts,
        super(ManageProductInitial()) {
    on<ManageProductEvent>((event, emit) {
      emit(ManageProductLoadingState());
    });
    on<GetAllProductsEvent>(_onGetAllProductEvent);
  }

  FutureOr<void> _onGetAllProductEvent(
      GetAllProductsEvent event, Emitter<ManageProductState> emit) async {
    final products = await _getAllProducts(NoParams());
    final user = await _getUserData(NoParams());

    List<Product> listOfProducts = [];

    String? vendorID;

    String userFailureMessage = 'User is Failed';

    user.fold((failure) => userFailureMessage = failure.message,
        (success) => vendorID = success?.vendorID);

    products
        .fold((failure) => emit(GetAllProductFailed(message: failure.message)),
            (listOfProducts) {
      isDataLoaded = true;
      emit(GetAllProductsSuccess(
          listOfProductModel: vendorID != null
              ? listOfProducts
                  .where((element) => element.vendorID == vendorID!)
                  .toList()
              : []));
    });
  }
}
