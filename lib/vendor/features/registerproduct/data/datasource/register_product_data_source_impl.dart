import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tech_haven/core/common/data/datasource/data_source.dart';
import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/core/common/data/model/image_model.dart';
import 'package:tech_haven/core/common/data/model/product_info_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/vendor/features/registerproduct/data/datasource/register_product_data_source.dart';
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
  // static double _uploadProgress = 0.0;
//  StreamController<double> _progressController = StreamController<double>();

  // Stream<double> get uploadProgressStream => _progressController.stream;

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
    required String brandID,
    required String name,
    required double prize,
    required double oldPrize,
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
      print(brandID);
      final userdata = await dataSource.getUserData();
      if (userdata != null) {
        final productID = const Uuid().v1();
        final Map<int, List<ImageModel>> mapOfImageModels =
            await saveImagesInStorage(
          productID: productID,
          productImages: productImages,
        );

        ProductInfoModel productInfoModel = ProductInfoModel(
          brandID: brandID,
          brandName: brandName,
          mainCategoryName: mainCategory,
          mainCategoryID: mainCategoryID,
          subCategoryName: subCategory,
          subCategoryID: subCategoryID,
          variantCategoryName: variantCategory,
          variantCategoryID: variantCategoryID,
          productID: productID,
          productName: name,
        );

        firebaseFirestore
            .collection('categories')
            .doc(mainCategoryID)
            .collection('subCategories')
            .doc(subCategoryID)
            .collection('variantCategories')
            .doc(variantCategoryID)
            .collection('products')
            .doc(productID)
            .set(productInfoModel.toJson());
        print(oldPrize);
        ProductModel productModel = ProductModel(
            productID: productID,
            vendorName: userdata.username!,
            brandName: brandName,
            displayImageURL: mapOfImageModels.values.first.first.imageURL,
            name: name,
            prize: prize,
            oldPrize: oldPrize,
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
            rating: 0,
            isPublished: isPublished,
            brandID: brandID);
        firebaseFirestore
            .collection('products')
            .doc(productID)
            .set(productModel.toJson());

        print(productModel.toJson());

        for (final entry in mapOfImageModels.entries) {
          final List<ImageModel> imageModels = entry.value;
          Map<String, String> imageMap = {};
          for (final image in imageModels) {
            imageMap[image.imageID] = image.imageURL;
          }

// Now you can save this map directly to Firebase Firestore
          firebaseFirestore
              .collection('products')
              .doc(productID)
              .collection('images')
              .doc('${entry.key}') // or any suitable document name
              .set(imageMap);
        }
      }
      return true;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<Map<int, List<ImageModel>>> saveImagesInStorage({
    required String productID,
    required Map<int, List<File>> productImages,
  }) async {
    try {
      final reference = firebaseStorage.ref('products');
      final Map<int, List<ImageModel>> mapOfImageModels = {};

      for (final entry in productImages.entries) {
        // final int index = entry.key;
        final List<File> images = entry.value;

        for (final image in images) {
          final String imageID = const Uuid().v4();
          final Reference imageReference = reference
              .child(productID)
              .child('images')
              .child('${entry.key}')
              .child(imageID);

          final UploadTask uploadTask = imageReference.putFile(image);
          // uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            // Update upload progress
            // _uploadProgress =
                // (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            // _progressController.add(_uploadProgress);
          // }, onError: (error) {
            // Handle upload error
            // print('Error uploading image: $error');
          // });
          // await uploadTask.whenComplete(() {
            // print('Image uploaded successfully');
            // _progressController.close();
          // });
          final String downloadURL =
              await uploadTask.snapshot.ref.getDownloadURL();
          // = await taskSnapshot.ref.getDownloadURL();

          final ImageModel imageModel =
              ImageModel(imageID: imageID, imageURL: downloadURL);
          if (mapOfImageModels.containsKey(entry.key)) {
            mapOfImageModels[entry.key]!.add(imageModel);
          } else {
            mapOfImageModels[entry.key] = [imageModel];
          }
        }
      }
      return mapOfImageModels;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<int, List<Image>>> getImagesForTheProduct(
      {required String productID}) async {
    try {
      return dataSource.getImageForTheProduct(productID: productID);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> deleteProduct(
      {required Product productModel,
      required Map<int, List<Image>> mapOfListOfImages}) async {
    try {
      await firebaseFirestore
          .collection('products')
          .doc(productModel.productID)
          .collection('images')
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      }).then((value) => print('all the images deleted'));

      await firebaseFirestore
          .collection('products')
          .doc(productModel.productID)
          .delete()
          .then((value) => print('images deleted from firebase collection'));

      await firebaseStorage
          .ref('products/${productModel.productID}')
          .delete()
          .then((value) => print('images deleted from storage'));

      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> updateExistingProduct({
    required Product product,
    required String brandName,
    required String brandID,
    required String name,
    required double prize,
    required double oldPrize,
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
    required Map<int, List<File>>? productImages,
    required List<int> deleteImagesIndexes,
    required bool isPublished,
  }) async {
    try {
      final userdata = await dataSource.getUserData();
      if (userdata != null) {
        ProductInfoModel productInfoModel = ProductInfoModel(
            mainCategoryName: mainCategory,
            mainCategoryID: mainCategoryID,
            subCategoryName: subCategory,
            subCategoryID: subCategoryID,
            variantCategoryName: variantCategory,
            variantCategoryID: variantCategoryID,
            productID: product.productID,
            productName: name,
            brandName: brandName,
            brandID: brandID);
        firebaseFirestore
            .collection('categories')
            .doc(mainCategoryID)
            .collection('subCategories')
            .doc(subCategoryID)
            .collection('variantCategories')
            .doc(variantCategoryID)
            .collection('products')
            .doc(product.productID)
            .update(productInfoModel.toJson());

        if (deleteImagesIndexes.isNotEmpty) {
          final imagesCollection = firebaseFirestore
              .collection('products')
              .doc(product.productID)
              .collection('images');

          for (final docId in deleteImagesIndexes) {
            try {
              // Delete the document with the current ID
              await imagesCollection.doc(docId.toString()).delete();
              print('Document with ID $docId deleted successfully.');
            } catch (error) {
              print('Error deleting document with ID $docId: $error');
            }
          }
        }

        String newDisplayImageURL = product.displayImageURL;
        if (productImages != null) {
          final Map<int, List<ImageModel>> mapOfImageModels =
              await saveImagesInStorage(
            productID: product.productID,
            productImages: productImages,
          );
          newDisplayImageURL = deleteImagesIndexes.contains(0)
              ? mapOfImageModels.entries.first.value.first.imageURL
              : product.displayImageURL;
          for (final entry in mapOfImageModels.entries) {
            final List<ImageModel> imageModels = entry.value;
            Map<String, String> imageMap = {};
            for (final image in imageModels) {
              imageMap[image.imageID] = image.imageURL;
            }

// Now you can save this map directly to Firebase Firestore
            firebaseFirestore
                .collection('products')
                .doc(product.productID)
                .collection('images')
                .doc('${entry.key}') // or any suitable document name
                .set(imageMap);
          }
        }
        ProductModel productModel = ProductModel(
          productID: product.productID,
          vendorName: userdata.username!,
          brandName: brandName,
          brandID: brandID,
          oldPrize: oldPrize,
          displayImageURL: newDisplayImageURL,
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
          rating: product.rating,
          isPublished: isPublished,
        );
        firebaseFirestore
            .collection('products')
            .doc(product.productID)
            .update(productModel.toJson());
      }
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> getAllBrands() async {
    try {
      final allBrands = await firebaseFirestore.collection('brand').get();
      List<CategoryModel> listOfBrandModels = [];
      for (var brand in allBrands.docs) {
        listOfBrandModels.add(CategoryModel.fromJson(brand.data()));
      }
      print(listOfBrandModels[0].categoryName);
      print('notheing');
      return listOfBrandModels;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
//the folder of the image storage must be like products/productID/image1ID,image2ID,image3ID,image4ID
