import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/entities/banner.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_banner_home_page.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_cart_home_page.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_favorited_products_home_page.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_products_home_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tech_haven/user/features/home/domain/usecase/update_product_to_cart_home_page.dart';
import 'package:tech_haven/user/features/home/domain/usecase/update_product_to_favorite_home_page.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

EventTransformer<Event> debounceSequential<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetAllProductsHomePage _getAllProductsHomePage;
  final GetAllBannerHomePage _getAllBannerHomePage;
  final GetAllCartHomePage _getAllCartHomePage;
  final UpdateProductToFavoriteHomePage _updateProductToFavoriteHomePage;
  final GetAllFavoritedProductsHomePage _getAllFavoritedProductsHomePage;
  final UpdateProductToCartHomePage _updateProductToCartHomePage;
  HomePageBloc(
      {required GetAllProductsHomePage getAllProductsHomePage,
      required GetAllBannerHomePage getAllBannerHomePage,
      required GetAllCartHomePage getAllCartHomePage,
      required UpdateProductToFavoriteHomePage updateProductToFavoriteHomePage,
      required GetAllFavoritedProductsHomePage getAllFavoritedProductsHomePage,
      required UpdateProductToCartHomePage updateProductToCartHomePage})
      : _getAllProductsHomePage = getAllProductsHomePage,
        _getAllBannerHomePage = getAllBannerHomePage,
        _getAllCartHomePage = getAllCartHomePage,
        _updateProductToFavoriteHomePage = updateProductToFavoriteHomePage,
        _getAllFavoritedProductsHomePage = getAllFavoritedProductsHomePage,
        _updateProductToCartHomePage = updateProductToCartHomePage,
        super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {
      emit(HomePageLoadingState());
    });
    on<GetAllProductsEvent>(_onGetAllProductsEvent);
    on<GetAllBannerEvent>(_onGetAllBannerEvent);
    on<GetAllCartEvent>(_onGetAllCartEvent);
    on<UpdateProductToFavoriteEvent>(
      _onUpdateProductToFavoriteEvent,
      // transformer: debounceSequential(
      //   const Duration(
      //     milliseconds: 3000,
      //   ),
      // ),
    );
    on<UpdateProductToCartEvent>(
      _onUpdateProductToCartEvent,
      // transformer: debounceSequential(
      //   const Duration(
      //     milliseconds: 300,
      //   ),
      // ),
    );
    // on<UpdateProductToCart>(_onUpdateProductToCart);
  }

  FutureOr<void> _onGetAllProductsEvent(
      GetAllProductsEvent event, Emitter<HomePageState> emit) async {
    final allCarted = await _getAllCartHomePage(NoParams());
    final allFavorited = await _getAllFavoritedProductsHomePage(NoParams());
    final allProducts = await _getAllProductsHomePage(NoParams());
    List<String> listOfAllFavorited = [];
    String messageOfFavoriteError = 'error';
    allCarted.fold(
        (failure) => emit(CartLoadedFailedState(
              message: failure.message,
            )), (success) {
      return emit(CartLoadedSuccessState(
        listOfCart: success,
      ));
    });
    allFavorited.fold((failure) {
      messageOfFavoriteError = failure.message;
    }, (success) {
      listOfAllFavorited = success; // Assigning value here
    });

    allProducts.fold((failure) {
      emit(HorizontalProductsListViewFailed(message: failure.message));
    }, (success) {
      emit(HorizontalProductsListViewSuccess(
        listOfProducts: success,
        listOfFavoritedProducts: listOfAllFavorited,
      ));
    });
  }

  FutureOr<void> _onGetAllBannerEvent(
      GetAllBannerEvent event, Emitter<HomePageState> emit) async {
    final result = await _getAllBannerHomePage(NoParams());

    result.fold((failure) {
      emit(GetAllBannerFailed(message: failure.message));
    }, (success) {
      emit(GetAllBannerSuccess(listOfBanners: success));
    });
  }

  FutureOr<void> _onUpdateProductToFavoriteEvent(
      UpdateProductToFavoriteEvent event, Emitter<HomePageState> emit) async {
    final result = await _updateProductToFavoriteHomePage(
      UpdateProductToFavoriteHomePageParams(
        isFavorited: event.isFavorited,
        product: event.product,
      ),
    );

    result.fold(
        (failure) => emit(ProductAddedToCartFailed(
              message: failure.message,
            )),
        (success) =>
            emit(ProductUpdatedToFavoriteSuccess(updatedSuccess: success)));
  }

  FutureOr<void> _onUpdateProductToCartEvent(
      UpdateProductToCartEvent event, Emitter<HomePageState> emit) async {
    emit(ProductUpdatedToCartLoading());
    final result = await _updateProductToCartHomePage(
        UpdateProductToCartHomePageParams(
            itemCount: event.itemCount,
            product: event.product,
            cart: event.cart));

    result.fold(
        (failed) => emit(CartLoadedFailedState(message: failed.message)),
        (success) => emit(CartLoadedSuccessState(
              listOfCart: success,
            )));
    // await Future.delayed(const Duration(seconds: 3));
    // emit(ProductUpdatedToCartSuccess(updatedSuccess: true));
  }

  FutureOr<void> _onGetAllCartEvent(
      GetAllCartEvent event, Emitter<HomePageState> emit) async {
    final result = await _getAllCartHomePage(NoParams());

    result.fold(
        (failure) => emit(CartLoadedFailedState(
              message: failure.message,
            )), (success) {
      return emit(CartLoadedSuccessState(
        listOfCart: success,
      ));
    });
  }
}
