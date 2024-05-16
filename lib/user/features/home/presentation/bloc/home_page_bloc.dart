import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_product.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
import 'package:tech_haven/core/entities/banner.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_banner_home_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_sub_categories_home_page.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

EventTransformer<Event> debounceSequential<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetAllProduct _getAllProduct;
  final GetAllBannerHomePage _getAllBannerHomePage;
  final GetAllCart _getAllCart;
  final UpdateProductToFavorite _updateProductToFavorite;
  final GetAllFavorite _getAllFavorite;
  final UpdateProductToCart _updateProductToCart;
  final GetAllSubCategoriesHomePage _getAllSubCategoriesHomePage;
  HomePageBloc({
    required GetAllProduct getAllProduct,
    required GetAllBannerHomePage getAllBannerHomePage,
    required GetAllCart getAllCart,
    required UpdateProductToFavorite updateProductToFavorite,
    required GetAllFavorite getAllFavorite,
    required UpdateProductToCart updateProductToCart,
    required GetAllSubCategoriesHomePage getAllSubCategoriesHomePage,
  })  : _getAllProduct = getAllProduct,
        _getAllBannerHomePage = getAllBannerHomePage,
        _getAllCart = getAllCart,
        _updateProductToFavorite = updateProductToFavorite,
        _getAllFavorite = getAllFavorite,
        _updateProductToCart = updateProductToCart,
        _getAllSubCategoriesHomePage = getAllSubCategoriesHomePage,
        super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {
      emit(HomePageLoadingState());
    });
    on<GetAllProductsEvent>(_onGetAllProductsEvent);
    on<GetAllBannerEvent>(_onGetAllBannerEvent);
    on<GetAllCartEvent>(_onGetAllCartEvent);
    on<UpdateProductToFavoriteEvent>(
      _onUpdateProductToFavoriteEvent,
    );

    on<UpdateProductToCartEvent>(
      _onUpdateProductToCartEvent,
    );
    on<GetAllSubCategoriesEvent>(_onGetAllSubCategoriesEvent);
    // on<UpdateProductToCart>(_onUpdateProductToCart);
  }

  FutureOr<void> _onGetAllProductsEvent(
      GetAllProductsEvent event, Emitter<HomePageState> emit) async {
    List<String> listOfAllFavorited = [];
    String messageOfFavoriteError = 'error';

    final allFavorited = await _getAllFavorite(NoParams());
    allFavorited.fold((failure) {
      messageOfFavoriteError = failure.message;
    }, (success) {
      listOfAllFavorited = success; // Assigning value here
    });
    final allProducts = await _getAllProduct(NoParams());
    allProducts.fold((failure) {
      emit(HorizontalProductsListViewFailed(message: failure.message));
    }, (success) {
      emit(HorizontalProductsListViewSuccess(
        listOfProducts: success,
        listOfFavoritedProducts: listOfAllFavorited,
      ));
    });

    final allCarted = await _getAllCart(NoParams());
    allCarted.fold(
        (failure) => emit(CartLoadedFailedState(
              message: failure.message,
            )), (success) {
      return emit(CartLoadedSuccessState(
        listOfCart: success,
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
    final result = await _updateProductToFavorite(
      UpdateProductToFavoriteParams(
        isFavorited: event.isFavorited,
        product: event.product,
      ),
    );

    result.fold(
        (failure) => emit(ProductUpdatedToFavoriteFailed(
              message: failure.message,
            )),
        (success) =>
            emit(ProductUpdatedToFavoriteSuccess(updatedSuccess: success)));
  }

  FutureOr<void> _onUpdateProductToCartEvent(
      UpdateProductToCartEvent event, Emitter<HomePageState> emit) async {
    emit(CartLoadingState());
    final result = await _updateProductToCart(UpdateProductToCartParams(
        itemCount: event.itemCount, product: event.product, cart: event.cart));

    result.fold(
        (failed) => emit(ProductUpdatedToCartFailed(message: failed.message)),
        (success) => emit(ProductUpdatedToCartSuccess(
              updatedSuccess: success,
            )));
  }

  FutureOr<void> _onGetAllCartEvent(
      GetAllCartEvent event, Emitter<HomePageState> emit) async {
    emit(CartLoadingState());
    final result = await _getAllCart(NoParams());

    result.fold(
        (failure) => emit(CartLoadedFailedState(
              message: failure.message,
            )), (success) {
      return emit(CartLoadedSuccessState(
        listOfCart: success,
      ));
    });
  }

  FutureOr<void> _onGetAllSubCategoriesEvent(
      GetAllSubCategoriesEvent event, Emitter<HomePageState> emit) async {
    final result = await _getAllSubCategoriesHomePage(NoParams());

    result.fold(
        (failure) => emit(GetAllSubCategoriesFailedState(
              message: failure.message,
            )), (success) {
      return emit(GetAllSubCategoriesSuccessState(
        listOfSubCategories: success,
      ));
    });
  }
}
