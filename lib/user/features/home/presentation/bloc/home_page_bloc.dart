import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/entities/banner.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_banner.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_favorited_products.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_products_home_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tech_haven/user/features/home/domain/usecase/update_product_to_favorite.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

EventTransformer<Event> debounceSequential<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetAllProductsHomePage _getAllProductsHomePage;
  final GetAllBanner _getAllBanner;
  final UpdateProductToFavorite _updateProductToFavorite;
  final GetAllFavoritedProductsHomePage _getAllFavoritedProducts;
  HomePageBloc(
      {required GetAllProductsHomePage getAllProductsHomePage,
      required GetAllBanner getAllBanner,
      required UpdateProductToFavorite updateProductToFavorite,
      required GetAllFavoritedProductsHomePage getAllFavoritedProducts})
      : _getAllProductsHomePage = getAllProductsHomePage,
        _getAllBanner = getAllBanner,
        _updateProductToFavorite = updateProductToFavorite,
        _getAllFavoritedProducts = getAllFavoritedProducts,
        super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {
      emit(HomePageLoadingState());
    });
    on<GetAllProductsEvent>(_onGetAllProductsEvent);
    on<GetAllBannerEvent>(_onGetAllBannerEvent);
    on<UpdateProductToFavoriteEvent>(
      _onUpdateProductToFavoriteEvent,
      transformer: debounceSequential(const Duration(milliseconds: 3000)),
    );
    on<UpdateProductToCart>(
      _onUpdateProductToCart,
      transformer: debounceSequential(const Duration(milliseconds: 300)),
    );
  }

  FutureOr<void> _onGetAllProductsEvent(
      GetAllProductsEvent event, Emitter<HomePageState> emit) async {
    final allProducts = await _getAllProductsHomePage(NoParams());
    final allFavorited = await _getAllFavoritedProducts(NoParams());

    List<String> listOfAllFavorited = [];
    String messageOfFavoriteError = 'error';

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
    final result = await _getAllBanner(NoParams());

    result.fold((failure) {
      emit(GetAllBannerFailed(message: failure.message));
    }, (success) {
      emit(GetAllBannerSuccess(listOfBanners: success));
    });
  }

  FutureOr<void> _onUpdateProductToFavoriteEvent(
      UpdateProductToFavoriteEvent event, Emitter<HomePageState> emit) async {
    print('updating the favorite');
    final result = await _updateProductToFavorite(
      UpdateProductToFavoriteParams(
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

  FutureOr<void> _onUpdateProductToCart(
      UpdateProductToCart event, Emitter<HomePageState> emit) {}
}
