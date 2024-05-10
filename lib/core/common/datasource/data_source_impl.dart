import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_haven/core/common/datasource/data_source.dart';
import 'package:tech_haven/core/common/model/image_model.dart';
import 'package:tech_haven/core/common/model/product_model.dart';
import 'package:tech_haven/core/common/model/user_model.dart' as model;
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/common/model/category_model.dart';
// import 'package:tech_haven/user/features/auth/data/models/user_model.dart';
// import 'package:tech_haven/core/models/category.dart';

class DataSourceImpl implements DataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  DataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  List<CategoryModel> mainCategories = [];

// Fetch sub-subcollection data
  Future<List<DocumentSnapshot>> fetchSubsubcollectionData(
      DocumentReference subDocRef) async {
    var subsubcollectionSnapshot =
        await subDocRef.collection('variantCategories').get();
    return subsubcollectionSnapshot.docs;
  }

  @override
  Future<model.UserModel?> getUserData() async {
    model.UserModel? userModel;
    try {
      // Get current user
      final User? user = firebaseAuth.currentUser;

      if (user != null) {
        // Query Firestore for user document with current user ID
        DocumentSnapshot userSnapshot =
            await firebaseFirestore.collection('users').doc(user.uid).get();

        // Check if user document exists
        if (userSnapshot.exists) {
          // Convert document data to UserModel
          userModel = model.UserModel.fromJson(
              userSnapshot.data() as Map<String, dynamic>);
        }
      }
      return userModel;
    } catch (e) {
      print('Error fetching user data: $e');
      return null; // Return null in case of error
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategoryData(bool refresh) async {
    if (mainCategories.isNotEmpty && !refresh) {
      return mainCategories;
    }
    mainCategories.clear();
    try {
      final mainSnapshot =
          await firebaseFirestore.collection('categories').get();
      for (var mainCategoryDoc in mainSnapshot.docs) {
        List<CategoryModel> subcategories = [];
        var mainDocumentData = mainCategoryDoc.data();
        CategoryModel mainCategory = CategoryModel.fromJson(mainDocumentData);
        //list of mainCategories

        //[mainCategory]
        mainCategories.add(mainCategory); //one category is added.
        final subSnapshotDocs =
            await fetchSubcollectionData(mainCategoryDoc.reference);

        for (var subCategoryDoc in subSnapshotDocs) {
          List<CategoryModel> variants = [];
          var subDocumentData = subCategoryDoc.data() as Map<String, dynamic>;
          CategoryModel subCategory = CategoryModel.fromJson(subDocumentData);
          // print(subCategory.categoryName);
          subcategories.add(subCategory); //one category is added
          final variantSnapshotDocs =
              await fetchSubsubcollectionData(subCategoryDoc.reference);

          for (var variantCategoryDoc in variantSnapshotDocs) {
            var variantDocumentData =
                variantCategoryDoc.data() as Map<String, dynamic>;
            CategoryModel variantCategory =
                CategoryModel.fromJson(variantDocumentData);
            variants.add(
                variantCategory); //one category is added if there is only one variant category it goes outside of loop.
          }
          subCategory.subCategories =
              variants; //variants have only one category model in it.
        }
        mainCategory.subCategories = subcategories;
      }

      return mainCategories.reversed.toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<DocumentSnapshot>> fetchSubcollectionData(
      DocumentReference mainDocRef) async {
    var subcollectionSnapshot =
        await mainDocRef.collection('subCategories').get();
    return subcollectionSnapshot.docs;
  }

  @override
  Future<List<ProductModel>> getAllProductsData() async {
    try {
      QuerySnapshot productSnapshot =
          await firebaseFirestore.collection('products').get();

      List<ProductModel> products = [];
      for (var doc in productSnapshot.docs) {
        products.add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      return products;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map<int, List<ImageModel>>> getImageForTheProduct(
      {required String productID}) async {
    try {
      Map<int, List<ImageModel>> resultMap = {};

      // Retrieve the document containing the image map
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore
              .collection('products')
              .doc(productID)
              .collection('images')
              .get();
      int count = 0;
      for (var document in snapshot.docs) {
        Map<String, dynamic> mapOfImages = document.data();
        mapOfImages.forEach((key, value) {
          if (resultMap.containsKey(count)) {
            resultMap[count]!.add(ImageModel(imageID: key, imageURL: value));
          } else {
            resultMap[count] = [ImageModel(imageID: key, imageURL: value)];
          }
        });
        count++;
      }

      return resultMap;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> updateProductToFavorite(
      {required bool isFavorited, required Product product}) async {
    try {
      final userData = await getUserData();
      if (userData != null) {
        DocumentSnapshot snapshot = await firebaseFirestore
            .collection('favorite')
            .doc(userData.uid)
            .get();
        //there is no data and want to create new and add the favorite
        if (!snapshot.exists && isFavorited) {
          await firebaseFirestore.collection('favorite').doc(userData.uid).set({
            'listOfProducts': [product.productID],
          });
          //there is data and want to update the the list by adding new value
        } else if (snapshot.exists && isFavorited) {
          await firebaseFirestore
              .collection('favorite')
              .doc(userData.uid)
              .update({
            'listOfProducts': FieldValue.arrayUnion([product.productID]),
          });
          //delete the favorited from the existed data.
        } else if (!isFavorited && snapshot.exists) {
          await firebaseFirestore
              .collection('favorite')
              .doc(userData.uid)
              .update(
            {
              'listOfProducts': FieldValue.arrayRemove(
                [product.productID],
              ),
            },
          );
        }
      }
      print('updated the favorite');
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> getAllFavoritedProducts() async {
    try {
      // print('updating the favorite');
      List<String> listOfFavoritedProduct = [];
      final userData = await getUserData();
      if (userData != null) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await firebaseFirestore
                .collection('favorite')
                .doc(userData.uid)
                .get();
        print(snapshot.exists && snapshot.data() != null);
        if (snapshot.exists && snapshot.data() != null) {
          listOfFavoritedProduct =
              List<String>.from(snapshot.data()!['listOfProducts']);
          // print(listOfFavoritedProduct.first);
        }
      }
      return listOfFavoritedProduct;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
