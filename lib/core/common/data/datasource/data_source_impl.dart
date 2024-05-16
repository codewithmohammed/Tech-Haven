import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_haven/core/common/data/datasource/data_source.dart';
import 'package:tech_haven/core/common/data/model/image_model.dart';
import 'package:tech_haven/core/common/data/model/product_model.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart' as model;
import 'package:tech_haven/core/entities/cart.dart';
import 'package:tech_haven/core/entities/image.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/common/data/model/category_model.dart';
import 'package:tech_haven/user/features/home/data/models/cart_model.dart';
import 'package:uuid/uuid.dart';
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
      throw ServerException(e.toString()); // Return null in case of error
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategory(bool refresh) async {
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
  Future<List<ProductModel>> getAllProduct() async {
    try {
      QuerySnapshot productSnapshot =
          await firebaseFirestore.collection('products').get();
      print(productSnapshot.docs[0].data());
      List<ProductModel> products = [];
      for (var doc in productSnapshot.docs) {
        products.add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      print(products[0].oldPrize);
      return products;
    } catch (e) {
      print(e.toString());
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
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> getAllFavorite() async {
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

  @override
  Future<List<CartModel>> getAllCart() async {
    try {
      List<CartModel> carts = [];
      final user = await getUserData();
      if (user != null) {
        final QuerySnapshot<Map<String, dynamic>> snapshot =
            await firebaseFirestore
                .collection('carts')
                .doc(user.uid)
                .collection('cart')
                .get();

        for (var document in snapshot.docs) {
          carts.add(CartModel.fromJson(document.data()));
        }
      }
      return carts;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> updateProductToCart(
      {required int itemCount,
      required Product product,
      required Cart? cart}) async {
    try {
      final user = await getUserData();
      if (user != null) {
        if (cart != null && itemCount != 0) {
          //for updation
          final cartModel = CartModel(
            cartID: cart.cartID,
            productID: product.productID,
            productCount: itemCount,
          );
          await firebaseFirestore
              .collection('carts')
              .doc(user.uid)
              .collection('cart')
              .doc(cart.cartID)
              .update(cartModel.toJson());
        } else if (cart == null && itemCount != 0) {
          //for creation
          String cartID = const Uuid().v1();
          final cartModel = CartModel(
            cartID: cartID,
            productID: product.productID,
            productCount: itemCount,
          );
          await firebaseFirestore
              .collection('carts')
              .doc(user.uid)
              .collection('cart')
              .doc(cartID)
              .set(cartModel.toJson());
        } else if (cart != null && itemCount == 0) {
          //for deletion of the data from the firebase
          await firebaseFirestore
              .collection('carts')
              .doc(user.uid)
              .collection('cart')
              .doc(cart.cartID)
              .delete();
        }
      } else {
        throw const ServerException('Unexpected Error Occured');
      }
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> getAllSubCategory() async {
    try {
      List<CategoryModel> subcategories = [];
      final mainSnapshot =
          await firebaseFirestore.collection('categories').get();
      for (var mainCategoryDoc in mainSnapshot.docs) {
        final subSnapshotDocs =
            await fetchSubcollectionData(mainCategoryDoc.reference);
        for (var subCategoryDoc in subSnapshotDocs) {
          var subDocumentData = subCategoryDoc.data() as Map<String, dynamic>;
          CategoryModel subCategory = CategoryModel.fromJson(subDocumentData);
          subcategories.add(subCategory);
        }
      }

      return subcategories;
    } on FirebaseException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllCartProduct() async {
    try {
      List<ProductModel> allProduct = await getAllProduct();
      List<CartModel> allCart = await getAllCart();

      List<ProductModel> filteredList =
          getAllProductsThatIsCarted(products: allProduct, cartModels: allCart);

      return filteredList;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllFavoriteProduct() async{
     try {
      List<ProductModel> allProduct = await getAllProduct();
      List<String> allFavorite = await getAllFavorite();

      List<ProductModel> filteredList =
          getAllProductsThatIsFavorited(products: allProduct, favoritedModels: allFavorite);

      return filteredList;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map<int, List<Image>>> getImagesForProduct({required String productID})async {
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
}

List<ProductModel> getAllProductsThatIsCarted({
  required List<ProductModel> products,
  required List<CartModel> cartModels,
}) {
  List<ProductModel> filteredList = [];
  for (var product in products) {
    for (var cart in cartModels) {
      if (product.productID == cart.productID) {
        filteredList.add(product);
      }
    }
  }
  return filteredList;
}


List<ProductModel> getAllProductsThatIsFavorited({
  required List<ProductModel> products,
  required List<String> favoritedModels,
}) {
  List<ProductModel> filteredList = [];
  for (var product in products) {
    for (var favorited in favoritedModels) {
      if (product.productID == favorited) {
        filteredList.add(product);
      }
    }
  }
  return filteredList;
}
