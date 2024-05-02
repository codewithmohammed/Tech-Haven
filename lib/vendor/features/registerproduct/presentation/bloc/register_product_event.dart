part of 'register_product_bloc.dart';

sealed class RegisterProductEvent {
  const RegisterProductEvent();
}

final class GetAllCategoryEvent extends RegisterProductEvent {
  final bool refreshPage;
  GetAllCategoryEvent({required this.refreshPage});
}

final class RegisterNewProductEvent extends RegisterProductEvent {
  final String brandName;
  final String productName;
  final double productPrize;
  final int productQuantity;
  final String mainCategory;
  final String mainCategoryID;
  final String subCategory;
  final String subCategoryID;
  final String variantCategory;
  final String variantCategoryID;
  final String productOverview;
  final double shippingCharge;
  final Map<int, List<File>> productImages;
  final bool isPublished;

  RegisterNewProductEvent({
    required this.brandName,
    required this.productName,
    required this.productPrize,
    required this.productQuantity,
    required this.mainCategory,
    required this.mainCategoryID,
    required this.subCategory,
    required this.subCategoryID,
    required this.variantCategory,
    required this.variantCategoryID,
    required this.productOverview,
    required this.shippingCharge,
    required this.productImages,
    required this.isPublished,
  });
}
