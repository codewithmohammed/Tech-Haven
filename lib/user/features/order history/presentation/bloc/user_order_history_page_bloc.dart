import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tech_haven/core/entities/order.dart' as model;
import 'package:tech_haven/core/entities/user_ordered_product.dart';
import 'package:tech_haven/user/features/order%20history/domain/usecase/get_all_user_order_history.dart';

part 'user_order_page_history_event.dart';
part 'user_order_page_history_state.dart';

class UserOrderHistoryPageBloc
    extends Bloc<UserOrderHistoryEvent, UserOrderHistoryState> {
  final GetAllUserOrderHistoryUseCase _getAllUserOrderHistoryUseCase;

  UserOrderHistoryPageBloc(
      {required GetAllUserOrderHistoryUseCase getAllUserOrderHistoryUseCase})
      : _getAllUserOrderHistoryUseCase = getAllUserOrderHistoryUseCase,
        super(UserOrderHistoryInitial()) {
    on<UserOrderHistoryEvent>((event, emit) {
      emit(UserOrderHistoryLoading());
    });
    on<GetUserOrderHistoryEvent>(_onGetUserOrderHistoryEvent);
  }

  FutureOr<void> _onGetUserOrderHistoryEvent(GetUserOrderHistoryEvent event,
      Emitter<UserOrderHistoryState> emit) async {
    final result = await _getAllUserOrderHistoryUseCase(NoParams());
    result.fold((failed) => emit(UserOrderHistoryError(failed.message)),
        (success) => emit(UserOrderHistoryLoaded(success)));
  }
}
