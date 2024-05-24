import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/error/failures.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/show_present_payment_sheet.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/submit_payment_form.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final SubmitPaymentForm _submitPaymentForm;
  final ShowPresentPaymentSheet _showPresentPaymentSheet;
  CheckoutBloc(
      {required SubmitPaymentForm submitPaymentForm,
      required ShowPresentPaymentSheet showPresentPaymentSheet})
      : _showPresentPaymentSheet = showPresentPaymentSheet,
        _submitPaymentForm = submitPaymentForm,
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
}
