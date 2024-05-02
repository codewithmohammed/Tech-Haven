import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tech_haven/core/common/datasource/data_source.dart';
import 'package:tech_haven/core/common/model/category_model.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/datasource/register_product_data_source.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/models/image_model.dart';
import 'package:uuid/uuid.dart';

class RegisterProductDataSourceImpl extends RegisterProductDataSource {
  final DataSource dataSource;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  RegisterProductDataSourceImpl(
      {required this.dataSource,
      required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.firebaseStorage});
  @override
  Future<List<CategoryModel>> getAllCategoryModel(bool refresh) async {
    try {
      final listOfCategories = await dataSource.getAllCategoryData(refresh);
      return listOfCategories;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> registerNewProduct({
    required String brandName,
    required String name,
    required double prize,
    required int quantity,
    required String mainCategory,
    required String mainCategoryID,
    required String subCategory,
    required String subCategoryID,
    required String variantCategory,
    required String variantCategoryID,
    required String overview,
    required Map<String, String>? specifications,
    required double? shippingCharge,
    required Map<int, List<File>> productImages,
    required bool isPublished,
  }) async {
    try {
      final productID = const Uuid().v1();
      //get user name and ids

      final List<Image> listOfImage = await saveImagesInStorage(
          productID: productID, productImages: productImages);
      Product product = Product(
          productID: productID,
          vendorID: vendorID,
          vendorName: vendorName,
          brandName: brandName,
          name: name,
          prize: prize,
          quantity: quantity,
          mainCategory: mainCategory,
          mainCategoryID: mainCategoryID,
          subCategory: subCategory,
          subCategoryID: subCategoryID,
          variantCategory: variantCategory,
          variantCategoryID: variantCategoryID,
          overview: overview,
          specifications: specifications,
          shippingCharge: shippingCharge,
          listOfImages: listOfImages,
          rating: 0,
          isPublished: isPublished);
      firebaseFirestore.collection('products').doc(productID).set(data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<Image>> saveImagesInStorage({
    required String productID,
    required Map<int, List<File>> productImages,
  }) async {
    try {
      final reference = firebaseStorage.ref('products');
      final List<Image> imageModels = [];

      for (final entry in productImages.entries) {
        // final int index = entry.key;
        final List<File> images = entry.value;

        for (final image in images) {
          final String imageID = const Uuid().v4();
          final Reference imageReference =
              reference.child(productID).child(imageID);

          final UploadTask uploadTask = imageReference.putFile(image);
          final TaskSnapshot taskSnapshot = await uploadTask;
          final String downloadURL = await taskSnapshot.ref.getDownloadURL();

          final ImageModel imageModel =
              ImageModel(imageID: imageID, imageURL: downloadURL);

          // await firebaseFirestore
          //     .collection('products')
          //     .doc(productID)
          //     .collection('images')
          //     .doc(imageID)
          //     .set(
          //       imageModel.toJson(),
          //     );

          imageModels.add(imageModel);
        }
      }
      return imageModels;
    } catch (e) {
      rethrow;
    }
  }
}
//the folder of the image storage must be like products/productID/image1ID,image2ID,image3ID,image4ID
