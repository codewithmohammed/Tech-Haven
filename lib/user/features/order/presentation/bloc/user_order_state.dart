part of 'user_order_bloc.dart';

sealed class UserOrderState extends Equatable {
  const UserOrderState();

  @override
  List<Object> get props => [];
}

final class UserOrderInitial extends UserOrderState {}

final class UserOrderLoading extends UserOrderState{}

// final class GetAllOrderPaymentSuccess extends UserOrder/

final class GetAllOrderDetailsSuccess extends UserOrderState {
  final List<Order> listOfOrderModels;
  const GetAllOrderDetailsSuccess({required this.listOfOrderModels});
}

final class GetAllOrderDetailsFailed extends UserOrderState {
  final String message;
  const GetAllOrderDetailsFailed({required this.message});
}
