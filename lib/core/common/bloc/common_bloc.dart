import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_current_location_details.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
import 'package:tech_haven/core/entities/location.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';

part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  // final UpdateProductToFavorite _updateProductToFavorite;
  final GetCurrentLocationDetails _getCurrentLocationDetails;
  CommonBloc(
      {required GetCurrentLocationDetails getCurrentLocationDetails,
      required UpdateProductToFavorite updateProductToFavorite})
      :
      //  _updateProductToFavorite = updateProductToFavorite,
        _getCurrentLocationDetails = getCurrentLocationDetails,
        super(CommonInitial()) {
    on<CommonEvent>((event, emit) {});
    on<GetUserLocationDataEvent>(_onGetUserLocationDataEvent);
    // on<UpdateProductToFavoriteEvent>(_onUpdateProductToFavoriteEvent);
  }

  FutureOr<void> _onGetUserLocationDataEvent(
      GetUserLocationDataEvent event, Emitter<CommonState> emit) async {
    final result = await _getCurrentLocationDetails(NoParams());
    result.fold((failed) => emit(LocationFailedState(message: failed.message)),
        (success) => emit(LocationSuccessState(location: success)));
  }

  // FutureOr<void> _onUpdateProductToFavoriteEvent(
  //     UpdateProductToFavoriteEvent event, Emitter<CommonState> emit) async {
  //   final result = await _updateProductToFavorite(UpdateProductToFavoriteParams(
  //       isFavorited: event.isFavorited, product: event.product));
  //       result.
  // }
}
