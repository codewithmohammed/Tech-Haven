import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_orders.dart';
import 'package:tech_haven/core/entities/order.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

part 'user_order_event.dart';
part 'user_order_state.dart';

class UserOrderBloc extends Bloc<UserOrderEvent, UserOrderState> {
  final GetAllOrders _getAllOrders;
  UserOrderBloc({required GetAllOrders getAllOrders})
      : _getAllOrders = getAllOrders,
        super(UserOrderInitial()) {
    on<UserOrderEvent>((event, emit) {
      emit(UserOrderLoading());
    });

    on<GetAllOrderDetailsEvent>(_onGetAllOrderDetailsEvent);
  }

  FutureOr<void> _onGetAllOrderDetailsEvent(
      GetAllOrderDetailsEvent event, Emitter<UserOrderState> emit) async {
    final result = await _getAllOrders(NoParams());
    result.fold(
        (failure) => emit(GetAllOrderDetailsFailed(message: failure.message)),
        (success) =>
            emit(GetAllOrderDetailsSuccess(listOfOrderModels: success)));
  }
}
