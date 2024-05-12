import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_haven/core/common/cubits/app_cubit/app_user_cubit.dart';
import 'package:tech_haven/core/common/datasource/data_source.dart';
import 'package:tech_haven/core/common/datasource/data_source_impl.dart';
import 'package:tech_haven/user/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tech_haven/user/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:tech_haven/user/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tech_haven/user/features/auth/domain/repository/auth_repository.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/forgot_password_send_email.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/google_sign_up.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/send_otp_to_phone_number.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/create_user.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/user_signin.dart';
import 'package:tech_haven/user/features/auth/domain/usecases/verify_phone_number_and_sign_up.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/cart/data/datasource/cart_page_data_source.dart';
import 'package:tech_haven/user/features/cart/data/datasource/cart_page_data_source_impl.dart';
import 'package:tech_haven/user/features/cart/data/repositories/cart_page_repository_impl.dart';
import 'package:tech_haven/user/features/cart/domain/repository/cart_page_repository.dart';
import 'package:tech_haven/user/features/cart/domain/usecase/get_all_cart_cart_page.dart';
import 'package:tech_haven/user/features/cart/domain/usecase/get_all_favorited_products_cart_page.dart';
import 'package:tech_haven/user/features/cart/domain/usecase/get_all_products_cart_page.dart';
import 'package:tech_haven/user/features/cart/domain/usecase/update_product_to_cart_cart_page.dart';
import 'package:tech_haven/user/features/cart/domain/usecase/update_product_to_favorite_cart_page.dart';
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/favorite/data/favorite_page_data_source.dart';
import 'package:tech_haven/user/features/favorite/data/favorite_page_data_source_impl.dart';
import 'package:tech_haven/user/features/favorite/data/repositories/favorite_page_repository_impl.dart';
import 'package:tech_haven/user/features/favorite/domain/repository/favorite_page_repository.dart';
import 'package:tech_haven/user/features/favorite/domain/usecase/get_all_favorited_products.dart';
import 'package:tech_haven/user/features/favorite/domain/usecase/remove_product_from_favorite.dart';
import 'package:tech_haven/user/features/favorite/presentation/bloc/favorite_page_bloc.dart';
import 'package:tech_haven/user/features/home/data/datasource/home_page_data_source.dart';
import 'package:tech_haven/user/features/home/data/datasource/home_page_data_source_impl.dart';
import 'package:tech_haven/user/features/home/data/repositories/home_page_repository_impl.dart';
import 'package:tech_haven/user/features/home/domain/repository/home_page_repository.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_banner_home_page.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_cart_home_page.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_favorited_products_home_page.dart';
import 'package:tech_haven/user/features/home/domain/usecase/get_all_products_home_page.dart';
import 'package:tech_haven/user/features/home/domain/usecase/update_product_to_cart_home_page.dart';
import 'package:tech_haven/user/features/home/domain/usecase/update_product_to_favorite_home_page.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/user/features/searchcategory/data/datasource/search_category_data_source.dart';
import 'package:tech_haven/user/features/searchcategory/data/datasource/search_category_data_source_impl.dart';
import 'package:tech_haven/user/features/searchcategory/data/repositories/search_category_repository_impl.dart';
import 'package:tech_haven/user/features/searchcategory/domain/repository/search_category_repository.dart';
import 'package:tech_haven/user/features/searchcategory/domain/usecase/get_all_category.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/bloc/search_category_bloc.dart';
import 'package:tech_haven/user/features/searchcategory/presentation/cubit/search_category_cubit.dart';
import 'package:tech_haven/vendor/features/manageproduct/data/datasource/manage_product_data_source.dart';
import 'package:tech_haven/vendor/features/manageproduct/data/datasource/manage_product_data_source_impl.dart';
import 'package:tech_haven/vendor/features/manageproduct/data/repositories/manage_product_repository_impl.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/repository/manage_product_repository.dart';
import 'package:tech_haven/vendor/features/manageproduct/domain/usecase/get_all_products.dart';
import 'package:tech_haven/vendor/features/manageproduct/presentation/bloc/manage_product_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/datasource/register_product_data_source.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/datasource/register_product_data_source_impl.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/repositories/register_product_repostory_imp.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/repository/register_product_repository.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/delete_product.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/get_all_category.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/get_images_for_the_product.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/register_new_product.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/update_existing_product.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/bloc/get_images_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/bloc/register_product_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseStorage.instance);
  _initAuth();
  _initHomePage();
  _initDataSource();
  _initSearchCategory();
  _initRegisterProduct();
  _initManageProduct();
  _initFavorite();
  _initCart();
}

_initAuth() {
  //for user cubit

  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseStorage: serviceLocator(),
        firebaseAuth: serviceLocator(),
        firebaseFirestore: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    // phonenumberverification
    ..registerFactory(
      () => SendOTPToPhoneNumber(serviceLocator()),
    )
    ..registerFactory(() => VerifyPhoneAndSignUpUser(serviceLocator()))
    ..registerFactory(() => CreateUser(authRepository: serviceLocator()))
    ..registerFactory(() => UserSignIn(authRepository: serviceLocator()))
    // ..registerFactory(() => UserSignUp(serviceLocator()))
    // ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
    ..registerFactory(() => GoogleSignUp(authRepository: serviceLocator()))
    ..registerFactory(
        () => ForgotPasswordSendEmail(authRepository: serviceLocator()))
    // ..registerFactory(() => UserProfileUpload(authRepository: serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
          // currentUser: serviceLocator(),
          sendOTPToPhoneNumber: serviceLocator(),
          verifyPhoneAndSignUpUser: serviceLocator(),
          createUser: serviceLocator(),
          userSignIn: serviceLocator(),
          // userProfileUpload: serviceLocator(),
          googleSignUp: serviceLocator(),
          appUserCubit: serviceLocator(),
          forgotPasswordSendEmail: serviceLocator()),
    );
}

_initDataSource() {
  serviceLocator.registerFactory<DataSource>(() => DataSourceImpl(
      firebaseFirestore: serviceLocator(), firebaseAuth: serviceLocator()));
}

void _initHomePage() {
  serviceLocator
    ..registerFactory<HomePageDataSource>(() => HomePageDataSourceImpl(
        dataSource: serviceLocator(), firebaseFirestore: serviceLocator()))
    ..registerFactory<HomePageRepository>(
        () => HomePageRepositoryImpl(homePageDataSource: serviceLocator()))
    ..registerFactory(
        () => GetAllProductsHomePage(homePageRepository: serviceLocator()))
    ..registerFactory(
        () => GetAllBannerHomePage(homePageRepository: serviceLocator()))
    ..registerFactory(() =>
        UpdateProductToFavoriteHomePage(homePageRepository: serviceLocator()))
    ..registerFactory(() =>
        GetAllFavoritedProductsHomePage(homePageRepository: serviceLocator()))
    ..registerFactory(
        () => UpdateProductToCartHomePage(homePageRepository: serviceLocator()))
    ..registerFactory(
        () => GetAllCartHomePage(homePageRepository: serviceLocator()))
    ..registerLazySingleton(() => HomePageBloc(
        getAllProductsHomePage: serviceLocator(),
        getAllBannerHomePage: serviceLocator(),
        updateProductToFavoriteHomePage: serviceLocator(),
        getAllFavoritedProductsHomePage: serviceLocator(),
        updateProductToCartHomePage: serviceLocator(),
        getAllCartHomePage: serviceLocator()));
}

void _initSearchCategory() {
  serviceLocator
    ..registerFactory<SearchCategoryDataSource>(
        () => SearchCategoryDataSourceImpl(dataSource: serviceLocator()))
    ..registerFactory<SearchCategoryRepository>(() =>
        SearchCategoryRepositoryImpl(
            searchCategoryDataSource: serviceLocator()))
    ..registerFactory(
        () => GetAllCategory(searchCategoryRepository: serviceLocator()))
    ..registerLazySingleton(
        () => SearchCategoryBloc(getAllCategory: serviceLocator()))
    ..registerLazySingleton(
      () => SearchCategoryCubit(),
    );
}

_initRegisterProduct() {
  serviceLocator
    ..registerFactory<RegisterProductDataSource>(() =>
        RegisterProductDataSourceImpl(
            dataSource: serviceLocator(),
            firebaseAuth: serviceLocator(),
            firebaseFirestore: serviceLocator(),
            firebaseStorage: serviceLocator()))
    ..registerFactory<RegisterProductRepository>(() =>
        RegisterProductRepositoryImpl(
            registerProductDataSource: serviceLocator()))
    ..registerFactory(() => GetAllCategoryForRegister(
          registerProductRepository: serviceLocator(),
        ))
    ..registerFactory(
        () => RegisterNewProduct(registerProductRepository: serviceLocator()))
    ..registerFactory(() =>
        GetImagesForTheProduct(registerProductRepository: serviceLocator()))
    ..registerFactory(
        () => DeleteProduct(registerProductRepository: serviceLocator()))
    ..registerFactory(() =>
        UpdateExistingProduct(registerProductRepository: serviceLocator()))
    ..registerLazySingleton(() => RegisterProductBloc(
          getAllCategoryForRegister: serviceLocator(),
          registerNewProduct: serviceLocator(),
          deleteProduct: serviceLocator(),
          updateExistingProduct: serviceLocator(),
        ))
    ..registerLazySingleton(
        () => GetImagesBloc(getImagesForTheProduct: serviceLocator()));
  // ..registerLazySingleton(() => ChangeCategoryModelBloc());
}

_initManageProduct() {
  serviceLocator
    ..registerFactory<ManageProductDataSource>(
      () => ManageProductDataSourceImpl(
        dataSource: serviceLocator(),
      ),
    )
    ..registerFactory<ManageProductRepository>(() =>
        ManageProductRepositoryImpl(manageProductDataSource: serviceLocator()))
    // ..registerFactory(() => GetAllCategoryForRegister(
    //       registerProductRepository: serviceLocator(),
    //     ))
    ..registerFactory(
        () => GetAllProducts(manageProductRepository: serviceLocator()))
    ..registerLazySingleton(
        () => ManageProductBloc(getAllProducts: serviceLocator()));
  // ..registerLazySingleton(() => ChangeCategoryModelBloc());
}

_initFavorite() {
  serviceLocator
    ..registerFactory<FavoritePageDataSource>(() => FavoritePageDataSourceImpl(
        dataSource: serviceLocator(), firebaseFirestore: serviceLocator()))
    ..registerFactory<FavoritePageRepository>(() =>
        FavoritePageRepositoryImpl(favoritePageDataSource: serviceLocator()))
    // ..registerFactory(() => GetAllCategoryForRegister(
    //       registerProductRepository: serviceLocator(),
    //     ))
    ..registerFactory(() => GetAllFavoritedProductFavoritePage(
        favoritePageRepository: serviceLocator()))
    ..registerFactory(
        () => RemoveProductFavorite(favoritePageRepository: serviceLocator()))
    ..registerLazySingleton(() => FavoritePageBloc(
        getAllFavoritedProduct: serviceLocator(),
        removeProductFavorite: serviceLocator()));
  // ..registerLazySingleton(() => ChangeCategoryModelBloc());
}

_initCart() {
  serviceLocator
    ..registerFactory<CartPageDataSource>(() => CartPageDataSourceImpl(
        dataSource: serviceLocator(), firebaseFirestore: serviceLocator()))
    ..registerFactory<CartPageRepository>(
        () => CartPageRepositoryImpl(cartPageDataSource: serviceLocator()))
    // ..registerFactory(() => GetAllCategoryForRegister(
    //       registerProductRepository: serviceLocator(),
    //     ))
    ..registerFactory(
        () => GetAllProductsCartPage(cartPageRepository: serviceLocator()))
    // ..registerFactory(() => GetAllBannerCartPage(CartPageRepository: serviceLocator()))
    ..registerFactory(() =>
        UpdateProductToFavoriteCartPage(cartPageRepository: serviceLocator()))
    ..registerFactory(() =>
        GetAllFavoritedProductsCartPage(cartPageRepository: serviceLocator()))
    ..registerFactory(
        () => UpdateProductToCartCartPage(cartPageRepository: serviceLocator()))
    ..registerFactory(
        () => GetAllCartCartPage(cartPageRepository: serviceLocator()))
    ..registerLazySingleton(() => CartPageBloc(
        getAllProductsCartPage: serviceLocator(),
        // getAllBannerCartPage: serviceLocator(),
        updateProductToFavoriteCartPage: serviceLocator(),
        getAllFavoritedProductsCartPage: serviceLocator(),
        updateProductToCartCartPage: serviceLocator(),
        getAllCartCartPage: serviceLocator()));
}
