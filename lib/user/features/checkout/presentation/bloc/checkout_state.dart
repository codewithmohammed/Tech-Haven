part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class SubmitPaymentFormSuccess extends CheckoutState {
  final dynamic jsonData;
  const SubmitPaymentFormSuccess({required this.jsonData});
}

final class SubmitPaymentFormFailed extends CheckoutState {
  final String message;
  const SubmitPaymentFormFailed({required this.message});
}

final class PaymentFailed extends CheckoutState {
  final String message;
  PaymentFailed({required this.message});
}

final class PaymentSuccess extends CheckoutState {}

final class AllCartsClearedState extends CheckoutState {}

final class AllCartsClearedSuccessState extends AllCartsClearedState {
  final String success;
  AllCartsClearedSuccessState({required this.success});
}

final class AllCartClearedFailedState extends AllCartsClearedState {
  final String message;
  AllCartClearedFailedState({required this.message});
}
