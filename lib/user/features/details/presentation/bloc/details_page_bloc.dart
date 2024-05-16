import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_images_for_product.dart';
import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:tech_haven/core/entities/product.dart';

part 'details_page_event.dart';
part 'details_page_state.dart';

class DetailsPageBloc extends Bloc<DetailsPageEvent, DetailsPageState> {
  final GetImagesForProduct _getImagesForProduct;
  DetailsPageBloc({required GetImagesForProduct getImagesForProduct})
      : _getImagesForProduct = getImagesForProduct,
        super(DetailsPageInitial()) {
    on<DetailsPageEvent>((event, emit) {
      emit(DetailsPageLoadingState());
    });

    on<GetAllImagesForProductEvent>(_onGetAllImagesForProductEvent);
    on<EmitInitial>((event, emit) {
      emit(DetailsPageInitial());
    });
  }

  FutureOr<void> _onGetAllImagesForProductEvent(
      GetAllImagesForProductEvent event, Emitter<DetailsPageState> emit) async {
    emit(DetailsPageInitial());

    final allProductImages = await _getImagesForProduct(
        GetImagesForProductParams(productID: event.productID));
    // print(allProductImages);
      await Future.delayed(const Duration(seconds: 1));
    allProductImages.fold(
        (failure) =>
            emit(GetAllImagesForProductFailed(message: failure.message)),
        (success) {
      // print('success');
      return emit(GetAllImagesForProductSuccess(allImages: success));
    });
  }
}
