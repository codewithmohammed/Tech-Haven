import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_haven/core/common/bloc/common_bloc.dart';
import 'package:tech_haven/core/common/cubits/app_cubit/app_user_cubit.dart';
import 'package:tech_haven/core/common/data/datasource/data_source.dart';
import 'package:tech_haven/core/common/data/datasource/data_source_impl.dart';
import 'package:tech_haven/core/common/data/repositories/repository_impl.dart';
import 'package:tech_haven/core/common/domain/repository/repository.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_brand_related_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_cart_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_category.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_favorite_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_all_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_current_location_details.dart';
import 'package:tech_haven/core/common/domain/usecase/get_images_for_product.dart';
import 'package:tech_haven/core/common/domain/usecase/get_user_data.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_cart.dart';
import 'package:tech_haven/core/common/domain/usecase/update_product_to_favorite.dart';
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
import 'package:tech_haven/user/features/cart/presentation/bloc/cart_page_bloc.dart';
import 'package:tech_haven/user/features/checkout/data/datasource/checkout_data_source.dart';
import 'package:tech_haven/user/features/checkout/data/datasource/checkout_data_source_impl.dart';
import 'package:tech_haven/user/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:tech_haven/user/features/checkout/domain/repository/checkout_repository.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/show_present_payment_sheet.dart';
import 'package:tech_haven/user/features/checkout/domain/usecase/submit_payment_form.dart';
import 'package:tech_haven/user/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:tech_haven/user/features/details/presentation/bloc/details_page_bloc.dart';
import 'package:tech_haven/user/features/favorite/data/datasource/favorite_page_data_source.dart';
import 'package:tech_haven/user/features/favorite/data/datasource/favorite_page_data_source_impl.dart';
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
import 'package:tech_haven/user/features/home/domain/usecase/get_all_sub_categories_home_page.dart';
import 'package:tech_haven/user/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:tech_haven/user/features/map/domain/usecase/update_location.dart';
import 'package:tech_haven/user/features/map/presentation/bloc/map_page_bloc.dart';
import 'package:tech_haven/user/features/searchcategory/data/datasource/search_category_data_source.dart';
import 'package:tech_haven/user/features/searchcategory/data/datasource/search_category_data_source_impl.dart';
import 'package:tech_haven/user/features/searchcategory/data/repositories/search_category_repository_impl.dart';
import 'package:tech_haven/user/features/searchcategory/domain/repository/search_category_repository.dart';
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
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/get_all_brands.dart';
import 'package:tech_haven/vendor/features/registerproduct/domain/usecase/get_all_category.dart';
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
  _initDetailsPage();
  _initDataCommon();
  _initSearchCategory();
  _initRegisterProduct();
  _initManageProduct();
  _initFavorite();
  _initCart();
  _intiCheckout();
  _initMap();
}

void _intiCheckout() {
  serviceLocator
    ..registerFactory<CheckoutDataSource>(() => CheckoutDataSourceImpl())
    ..registerFactory<CheckoutRepository>(
        () => CheckoutRepositoryImpl(checkoutDataSource: serviceLocator()))
    ..registerFactory(
        () => ShowPresentPaymentSheet(checkoutRepository: serviceLocator()))
    ..registerFactory(
        () => SubmitPaymentForm(checkoutRepository: serviceLocator()))
    ..registerLazySingleton(() => CheckoutBloc(
        submitPaymentForm: serviceLocator(),
        showPresentPaymentSheet: serviceLocator()));
}

void _initMap() {
  serviceLocator.registerLazySingleton(() => MapPageBloc(
      updateLocation: serviceLocator(),
      getCurrentLocationDetails: serviceLocator(),
      getUserData: serviceLocator()));
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
    ..registerFactory(() => GoogleSignUp(authRepository: serviceLocator()))
    ..registerFactory(
        () => ForgotPasswordSendEmail(authRepository: serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
          sendOTPToPhoneNumber: serviceLocator(),
          verifyPhoneAndSignUpUser: serviceLocator(),
          createUser: serviceLocator(),
          userSignIn: serviceLocator(),
          googleSignUp: serviceLocator(),
          appUserCubit: serviceLocator(),
          forgotPasswordSendEmail: serviceLocator()),
    );
}

_initDataCommon() {
  serviceLocator
    ..registerFactory<DataSource>(() => DataSourceImpl(
        firebaseAuth: serviceLocator(), firebaseFirestore: serviceLocator()))
    ..registerFactory<Repository>(
        () => RepositoryImpl(dataSource: serviceLocator()))
    ..registerFactory(() => GetAllCategory(repository: serviceLocator()))
    ..registerFactory(() => GetAllProduct(repository: serviceLocator()))
    ..registerFactory(() => GetImagesForProduct(repository: serviceLocator()))
    ..registerFactory(() => GetAllCart(repository: serviceLocator()))
    ..registerFactory(() => GetUserData(repository: serviceLocator()))
    ..registerFactory(() => GetAllFavorite(repository: serviceLocator()))
    ..registerFactory(() => GetAllCartProduct(repository: serviceLocator()))
    ..registerFactory(
        () => GetAllBrandRelatedProduct(repository: serviceLocator()))
    ..registerFactory(() => UpdateLocation(repository: serviceLocator()))
    ..registerFactory(
        () => GetCurrentLocationDetails(repository: serviceLocator()))
    ..registerFactory(
        () => GetAllFavoritedProduct(repository: serviceLocator()))
    ..registerFactory(
        () => UpdateProductToFavorite(repository: serviceLocator()))
    ..registerFactory(() => UpdateProductToCart(repository: serviceLocator()))
    ..registerLazySingleton(
        () => CommonBloc(getCurrentLocationDetails: serviceLocator()));
}

void _initHomePage() {
  serviceLocator
    ..registerFactory<HomePageDataSource>(() => HomePageDataSourceImpl(
        dataSource: serviceLocator(), firebaseFirestore: serviceLocator()))
    ..registerFactory<HomePageRepository>(
        () => HomePageRepositoryImpl(homePageDataSource: serviceLocator()))
    ..registerFactory(
        () => GetAllSubCategoriesHomePage(homePageRepository: serviceLocator()))
    ..registerFactory(
        () => GetAllBannerHomePage(homePageRepository: serviceLocator()))
    ..registerLazySingleton(() => HomePageBloc(
        getAllProduct: serviceLocator(),
        getAllBannerHomePage: serviceLocator(),
        updateProductToFavorite: serviceLocator(),
        updateProductToCart: serviceLocator(),
        getAllCart: serviceLocator(),
        getAllSubCategoriesHomePage: serviceLocator(),
        getAllFavorite: serviceLocator()));
}

_initDetailsPage() {
  serviceLocator.registerLazySingleton(() => DetailsPageBloc(
      getImagesForProduct: serviceLocator(),
      getAllCart: serviceLocator(),
      getAllFavorite: serviceLocator(),
      updateProductToFavorite: serviceLocator(),
      getAllBrandRelatedProduct: serviceLocator(),
      updateProductToCart: serviceLocator()));
}

void _initSearchCategory() {
  serviceLocator
    ..registerFactory<SearchCategoryDataSource>(
        () => SearchCategoryDataSourceImpl(dataSource: serviceLocator()))
    ..registerFactory<SearchCategoryRepository>(() =>
        SearchCategoryRepositoryImpl(
            searchCategoryDataSource: serviceLocator()))
    ..registerLazySingleton(
        () => SearchCategoryBloc(getAllCategory: serviceLocator()))
    ..registerLazySingleton(
      () => SearchCategoryCubit(),
    )
    ..registerLazySingleton(() => SearchCategoryAccordionCubit());
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
    ..registerFactory(
        () => DeleteProduct(registerProductRepository: serviceLocator()))
    ..registerFactory(() =>
        UpdateExistingProduct(registerProductRepository: serviceLocator()))
    ..registerFactory(
        () => GetAllBrands(registerProductRepository: serviceLocator()))
    ..registerLazySingleton(() => RegisterProductBloc(
          getAllCategoryForRegister: serviceLocator(),
          registerNewProduct: serviceLocator(),
          deleteProduct: serviceLocator(),
          updateExistingProduct: serviceLocator(),
          getAllBrands: serviceLocator(),
        ))
    ..registerLazySingleton(
        () => GetImagesBloc(getImagesForProduct: serviceLocator()));
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
    ..registerFactory(
        () => GetAllProducts(manageProductRepository: serviceLocator()))
    ..registerLazySingleton(
        () => ManageProductBloc(getAllProducts: serviceLocator()));
}

_initFavorite() {
  serviceLocator
    ..registerFactory<FavoritePageDataSource>(() => FavoritePageDataSourceImpl(
        dataSource: serviceLocator(), firebaseFirestore: serviceLocator()))
    ..registerFactory<FavoritePageRepository>(() =>
        FavoritePageRepositoryImpl(favoritePageDataSource: serviceLocator()))
    ..registerFactory(() => GetAllFavoritedProductFavoritePage(
        favoritePageRepository: serviceLocator()))
    ..registerFactory(
        () => RemoveProductFavorite(favoritePageRepository: serviceLocator()))
    ..registerLazySingleton(() => FavoritePageBloc(
        getAllFavoritedProduct: serviceLocator(),
        removeProductFavorite: serviceLocator()));
}

_initCart() {
  serviceLocator.registerLazySingleton(() => CartPageBloc(
      getAllProduct: serviceLocator(),
      updateProductToFavorite: serviceLocator(),
      getAllCartProduct: serviceLocator(),
      getAllFavorite: serviceLocator(),
      updateProductToCart: serviceLocator(),
      getAllCart: serviceLocator()));
}
