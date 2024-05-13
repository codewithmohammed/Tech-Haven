import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/entities/banner.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
import 'package:tech_haven/user/features/cart/domain/usecase/get_all_cart_cart_page.dart';
import 'package:tech_haven/user/features/cart/domain/usecase/get_all_favorited_products_cart_page.dart';
import 'package:tech_haven/user/features/cart/domain/usecase/get_all_products_cart_page.dart';
import 'package:tech_haven/user/features/cart/domain/usecase/update_product_to_cart_cart_page.dart';
import 'package:tech_haven/user/features/cart/domain/usecase/update_product_to_favorite_cart_page.dart';

part 'cart_page_event.dart';
part 'cart_page_state.dart';

class CartPageBloc extends Bloc<CartPageEvent, CartPageState> {
  final GetAllProductsCartPage _getAllProductsCartPage;
  // final GetAllBannerCartPage _getAllBannerCartPage;
  final GetAllCartCartPage _getAllCartCartPage;
  final UpdateProductToFavoriteCartPage _updateProductToFavoriteCartPage;
  final GetAllFavoritedProductsCartPage _getAllFavoritedProductsCartPage;
  final UpdateProductToCartCartPage _updateProductToCartCartPage;
  CartPageBloc(
      {required GetAllProductsCartPage getAllProductsCartPage,
      // required GetAllBannerCartPage getAllBannerCartPage,
      required GetAllCartCartPage getAllCartCartPage,
      required UpdateProductToFavoriteCartPage updateProductToFavoriteCartPage,
      required GetAllFavoritedProductsCartPage getAllFavoritedProductsCartPage,
      required UpdateProductToCartCartPage updateProductToCartCartPage})
      : _getAllProductsCartPage = getAllProductsCartPage,
        // _getAllBannerCartPage = getAllBannerCartPage,
        _getAllCartCartPage = getAllCartCartPage,
        _updateProductToFavoriteCartPage = updateProductToFavoriteCartPage,
        _getAllFavoritedProductsCartPage = getAllFavoritedProductsCartPage,
        _updateProductToCartCartPage = updateProductToCartCartPage,
        super(CartPageInitial()) {
    on<CartPageEvent>((event, emit) {
      emit(CartPageLoadingState());
    });
    on<GetAllProductsEvent>(_onGetAllProductsEvent);
    on<GetAllCartEvent>(_onGetAllCartEvent);
    on<UpdateProductToFavoriteEvent>(
      _onUpdateProductToFavoriteEvent,
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
      GetAllProductsEvent event, Emitter<CartPageState> emit) async {
    // final allCarted = await _getAllCartCartPage(NoParams());
    // final allFavorited = await _getAllFavoritedProductsCartPage(NoParams());

    // final allCartsResults = await _getAllCartCartPage(NoParams());

    final allCarted = await _getAllCartCartPage(NoParams());
    final allFavorited = await _getAllFavoritedProductsCartPage(NoParams());
    final allProductsResult = await _getAllProductsCartPage(NoParams());
    List<String> listOfFavorites = [];
    // List<Cart> listOfCarts = [];
    allFavorited.fold(
      (failure) => failure,
      (favorites) {
        listOfFavorites = favorites;
      },
    );
    allProductsResult.fold((failure) {
      emit(CartProductsListViewFailed(message: failure.message));
    }, (products) {
      // List<Product> filteredList = getAllProductsThatIsCarted(
      //     products: products, cartModels: listOfCarts);
      print(products);
      emit(CartProductsListViewSuccess(
        listOfProducts: products,
        listOFAllFavorites: listOfFavorites,
      ));
    });
  }

  // FutureOr<void> _onGetAllBannerEvent(
  //     GetAllBannerEvent event, Emitter<CartPageState> emit) async {
  //   final result = await _getAllBanner(NoParams());

  //   result.fold((failure) {
  //     emit(GetAllBannerFailed(message: failure.message));
  //   }, (success) {
  //     emit(GetAllBannerSuccess(listOfBanners: success));
  //   });
  // }

  FutureOr<void> _onUpdateProductToFavoriteEvent(
      UpdateProductToFavoriteEvent event, Emitter<CartPageState> emit) async {
    final result = await _updateProductToFavoriteCartPage(
      UpdateProductToFavoriteCartPageParams(
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
      UpdateProductToCartEvent event, Emitter<CartPageState> emit) async {
    emit(CartUpdatedToCartLoading());
    final result = await _updateProductToCartCartPage(
        UpdateProductToCartCartPageParams(
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
      GetAllCartEvent event, Emitter<CartPageState> emit) async {
    emit(CartUpdatedToCartLoading());
    final result = await _getAllCartCartPage(NoParams());

    result.fold(
        (failure) => emit(CartLoadedFailedState(
              message: failure.message,
            )), (success) {
      print(success);
      return emit(CartLoadedSuccessState(
        listOfCart: success,
      ));
    });
  }
}
