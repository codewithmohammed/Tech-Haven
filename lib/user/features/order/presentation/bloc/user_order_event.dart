part of 'user_order_bloc.dart';

sealed class UserOrderEvent extends Equatable {
  const UserOrderEvent();

  @override
  List<Object> get props => [];
}



final class GetAllOrderDetailsEvent extends UserOrderEvent{}