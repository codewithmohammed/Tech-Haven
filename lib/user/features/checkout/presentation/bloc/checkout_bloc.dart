// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_a_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_fields.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/show_present_payment_sheet.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/submit_payment_form.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final SubmitPaymentForm _submitPaymentForm;
  final UpdateProductFields _updateProductFields;
  final GetAProduct _getAProduct;
  final UpdateProductToCart _updateProductToCart;
  final GetAllCart _getAllCart;
  final ShowPresentPaymentSheet _showPresentPaymentSheet;
  CheckoutBloc(
      {required SubmitPaymentForm submitPaymentForm,
      required UpdateProductToCart updateProductToCart,
      required GetAllCart getAllCart,
      required GetAProduct getAProduct,
      required UpdateProductFields updateProductFields,
      required ShowPresentPaymentSheet showPresentPaymentSheet})
      : _showPresentPaymentSheet = showPresentPaymentSheet,
        _getAllCart = getAllCart,
        _submitPaymentForm = submitPaymentForm,
        _updateProductToCart = updateProductToCart,
        _getAProduct = getAProduct,
        _updateProductFields = updateProductFields,
        super(CheckoutInitial()) {
    on<CheckoutEvent>((event, emit) {
      emit(CheckoutLoading());
    });
    on<CheckoutInitialEmit>(
      (event, emit) {
        emit(CheckoutInitial());
      },
    );
    on<SubmitPaymentFormEvent>(_onSubmitPaymentFormEvent);
    on<RemoveAllProductsFromTheCartEvent>(_onRemoveAllProductsFromTheCartEvent);
    on<ShowPresentPaymentSheetEvent>(_onShowPresentPaymentSheetEvent);
  }

  FutureOr<void> _onSubmitPaymentFormEvent(
      SubmitPaymentFormEvent event, Emitter<CheckoutState> emit) async {
    final result = await _submitPaymentForm(SubmitPaymentFormParams(
        name: event.name,
        address: event.address,
        pin: event.pin,
        city: event.city,
        state: event.state,
        country: event.country,
        currency: event.currency,
        amount: event.amount));

    result.fold(
        (failure) => emit(SubmitPaymentFormFailed(message: failure.message)),
        (jsonData) => emit(SubmitPaymentFormSuccess(jsonData: jsonData)));
  }

  FutureOr<void> _onShowPresentPaymentSheetEvent(
      ShowPresentPaymentSheetEvent event, Emitter<CheckoutState> emit) async {
    final result = await _showPresentPaymentSheet(NoParams());
    result.fold((failure) => emit(PaymentFailed(message: failure.message)),
        (success) => emit(PaymentSuccess()));
  }

  FutureOr<void> _onRemoveAllProductsFromTheCartEvent(
      RemoveAllProductsFromTheCartEvent event,
      Emitter<CheckoutState> emit) async {
    final allCarts = await _getAllCart(NoParams());

    allCarts.fold((l) => emit(AllCartClearedFailedState(message: l.message)),
        (carts) {
      carts.forEach((cart) async {
        final oneProduct =
            await _getAProduct(GetAProductParams(productID: cart.productID));

        // Product? product;
        int? newQuantity;
        oneProduct.fold((l) => null, (product) async {
          newQuantity = product.quantity - cart.productCount;
          final updated = await _updateProductFields(UpdateProductFieldsParams(
              updates: {'quantity': newQuantity}, productID: cart.productID));
          updated.fold((l) => null, (updated) async {
            await _updateProductToCart(UpdateProductToCartParams(
                itemCount: newQuantity!, product: product, cart: cart));
          });
        });
      });
      return emit(AllCartsClearedSuccessState(success: 'success'));
    });
  }
}
