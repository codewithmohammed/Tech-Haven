import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/entities/revenue.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/entities/vendor_payment.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/vendor/features/revenue/domain/usecase/get_list_of_revenue_date.dart';
import 'package:tech_haven/vendor/features/revenue/domain/usecase/get_revenue.dart';

part 'revenue_event.dart';
part 'revenue_state.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  final GetUserData _getUserData;
  final GetRevenue _getRevenue;
  final GetListOfRevenueData _getListOfRevenueData;
  RevenueBloc(
      {required GetUserData getUserData,
      required GetRevenue getRevenue,
      required GetListOfRevenueData getListOfRevenueData})
      : _getUserData = getUserData,
        _getRevenue = getRevenue,
        _getListOfRevenueData = getListOfRevenueData,
        super(RevenueInitial()) {
    on<RevenueEvent>((event, emit) {
      emit(RevenueLoading());
    });
    on<GetRevenueEvent>(_onGetRevenueEvent);
    on<GetListOfRevenueDataEvent>(_onGetListOfRevenueDataEvent);
  }

  FutureOr<void> _onGetRevenueEvent(
      GetRevenueEvent event, Emitter<RevenueState> emit) async {
    User? userData;
    final user = await _getUserData(NoParams());
    user.fold((failiure) => emit(GetRevenueFailed(message: failiure.message)),
        (user) async {
      userData = user;
    });

    // if (userData != null) {
    final revenue =
        await _getRevenue(GetRevenueParams(vendorID: userData!.vendorID!));
    revenue.fold((failure) {
      return emit(GetRevenueFailed(message: failure.message));
    }, (success) {
      return emit(GetRevenueSuccess(revenue: success));
    });
    // }
  }

  FutureOr<void> _onGetListOfRevenueDataEvent(
      GetListOfRevenueDataEvent event, Emitter<RevenueState> emit) async {
    User? userData;
    final user = await _getUserData(NoParams());
    user.fold((failiure) => emit(GetRevenueFailed(message: failiure.message)),
        (user) async {
      userData = user;
    });
    final listOfRevenue = await _getListOfRevenueData(
        GetListOfRevenueDataParams(vendorID: userData!.vendorID!));
    listOfRevenue.fold(
        (failure) => emit(GetListOfRevenueDataFailedState(message: failure.message)),
        (success) => emit(GetListOfRevenueDataSuccessState(listOfVendorPayment: success)));
  }
}
