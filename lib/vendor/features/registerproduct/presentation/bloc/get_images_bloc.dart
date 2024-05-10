import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/entities/image.dart';

import '../../domain/usecase/get_images_for_the_product.dart';

part 'get_images_event.dart';
part 'get_images_state.dart';

class GetImagesBloc extends Bloc<GetImagesEvent, GetImagesState> {
  final GetImagesForTheProduct _getImagesForTheProduct;
  GetImagesBloc({required GetImagesForTheProduct getImagesForTheProduct})
      : _getImagesForTheProduct = getImagesForTheProduct,
        super(GetImagesInitial()) {
    on<GetImagesEvent>((event, emit) {
      emit(GetImagesInitial());
    });
    on<EmitInitialEvent>((event, emit) {
      emit(GetImagesInitial());
    });

    on<GetImagesForTheProductEvent>(_onGetImagesForTheProductEvent);
  }
  FutureOr<void> _onGetImagesForTheProductEvent(
      GetImagesForTheProductEvent event, Emitter<GetImagesState> emit) async {
    emit(GetImagesInitial());
    final hello = await _getImagesForTheProduct(
        GetImagesForTheProductParams(productID: event.productID));
    hello.fold(
        (failure) =>
            emit(GetImagesForRegisterProductFailed(message: failure.message)),
        (mapOfListOfImages) {
      return emit(GetImagesForRegisterProductSuccess(
          mapOfListOfImages: mapOfListOfImages));
    });
  }
}
