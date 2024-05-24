import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_current_location_details.dart';
import 'package:tech_haven/core/entities/location.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  final GetCurrentLocationDetails _getCurrentLocationDetails;
  CommonBloc({required GetCurrentLocationDetails getCurrentLocationDetails})
      : _getCurrentLocationDetails = getCurrentLocationDetails,
        super(CommonInitial()) {
    on<CommonEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetUserLocationDataEvent>(_onGetUserLocationDataEvent);
  }

  FutureOr<void> _onGetUserLocationDataEvent(
      GetUserLocationDataEvent event, Emitter<CommonState> emit) async {
    final result = await _getCurrentLocationDetails(NoParams());
    result.fold((failed) => emit(LocationFailedState(message: failed.message)),
        (success) => emit(LocationSuccessState(location: success)));
  }
}
