import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_product.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/usecase/usecase.dart';
part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  // final SearchProducts searchProducts;
  final GetAllProduct _getAllProduct;
  final UpdateProductToFavorite _updateProductToFavorite;
  final UpdateProductToCart _updateProductToCart;
  final GetAllCart _getAllCart;
  final GetAllFavorite _getAllFavorite;
  List<Product> _allProducts = [];
  List<String> listOfFavorite = [];
  // Timer? _debounce;
  SearchPageBloc(
      {required GetAllProduct getAllProduct,
      required GetAllFavorite getAllFavorite,
required GetAllCart getAllCart,
      required UpdateProductToFavorite updateProductToFavorite,
      required UpdateProductToCart updateProductToCart})
      : _getAllProduct = getAllProduct,
        _getAllFavorite = getAllFavorite,
        _getAllCart = getAllCart,
        _updateProductToCart = updateProductToCart,
        _updateProductToFavorite = updateProductToFavorite,
        super(ProductSearchInitial()) {
    on<SearchProductsEvent>(_onSearchProductsEvent);
    on<UpdateProductToFavoriteSearchPageEvent>(
        _onUpdateProductToFavoriteSearchPageEvent);
    // on<GetAllCartProductsEvent>(_onGetAllCartProductsEvent);
    on<UpdateProductToCartSearchPageEvent>(
        _onUpdateProductToCartSearchPageEvent);
  }

  void _onSearchProductsEvent(
      SearchProductsEvent event, Emitter<SearchPageState> emit) async {
    emit(ProductSearchLoading());
    final allFavorited = await _getAllFavorite(NoParams());
    allFavorited.fold((failure) => emit(ProductSearchError(failure.message)),
        (success) {
      listOfFavorite = success; // Assigning value here
    });
    // Implement debouncing
    // if (_debounce?.isActive ?? false) _debounce!.cancel();
    // _debounce = Timer(const Duration(milliseconds: 300),
    // () async {
    if (_allProducts.isEmpty) {
      final result = await _getAllProduct(NoParams());
      result.fold(
        (error) => emit(ProductSearchError(error.toString())),
        (products) {
          _allProducts = products;
          _filterProducts(event.query, emit, listOfFavorite);
        },
      );
    } else {
      _filterProducts(event.query, emit, listOfFavorite);
    }
    // };
    // );
  }

  void _filterProducts(String? query, Emitter<SearchPageState> emit,
      List<String> listOfFavorites)async {
    if (query == null || query.isEmpty) {
      emit(ProductSearchLoaded(_allProducts, listOfFavorites));
    } else {
      final lowerCaseQuery = query.toLowerCase();
      final listOfFilteredProducts = _allProducts.where((product) {
        return product.brandName.toLowerCase().contains(lowerCaseQuery) ||
            product.name.toLowerCase().contains(lowerCaseQuery) ||
            product.overview.toLowerCase().contains(lowerCaseQuery) ||
            product.subCategory.toLowerCase().contains(lowerCaseQuery) ||
            product.mainCategory.toLowerCase().contains(lowerCaseQuery) ||
            product.variantCategory.toLowerCase().contains(lowerCaseQuery) ||
            product.vendorName.toLowerCase().contains(lowerCaseQuery);
      }).toList();

      emit(ProductSearchLoaded(listOfFilteredProducts, listOfFavorites));
    final allCarted = await _getAllCart(NoParams());
    allCarted.fold(
        (failure) => emit(CartLoadedFailedProductsState(
              message: failure.message,
            )), (success) {
      return emit(CartLoadedSuccessProductsState(
        listOfCart: success,
      ));
    });
    }
  }

  FutureOr<void> _onUpdateProductToFavoriteSearchPageEvent(
      UpdateProductToFavoriteSearchPageEvent event,
      Emitter<SearchPageState> emit) async {
    final result = await _updateProductToFavorite(
      UpdateProductToFavoriteParams(
        isFavorited: event.isFavorited,
        product: event.product,
      ),
    );

    result.fold(
        (failure) => emit(ProductUpdatedToFavoriteProductsFailed(
              message: failure.message,
            )),
        (success) => emit(
            ProductUpdatedToFavoriteProductsSuccess(updatedSuccess: success)));
  }

  FutureOr<void> _onUpdateProductToCartSearchPageEvent(
      UpdateProductToCartSearchPageEvent event,
      Emitter<SearchPageState> emit) async {}

  // FutureOr<void> _onGetAllCartProductsEvent(GetAllCartProductsEvent event, Emitter<SearchPageState> emit) {
  // }
}
