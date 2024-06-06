part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

final class CheckoutInitialEmit extends CheckoutEvent{}

final class SubmitPaymentFormEvent extends CheckoutEvent {
  final String name;
  final String address;
  final String pin;
  final String city;
  final String state;
  final String country;
  final String currency;
  final String amount;

  const SubmitPaymentFormEvent(
      {required this.name,
      required this.address,
      required this.pin,
      required this.city,
      required this.state,
      required this.country,
      required this.currency,
      required this.amount});
}

final class ShowPresentPaymentSheetEvent extends CheckoutEvent{}

// final class UpdateProductQuantityEvent extends CheckoutEvent{}

final class RemoveAllProductsFromTheCartEvent extends CheckoutEvent{}
