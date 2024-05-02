import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/common/datasource/data_source.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/core/common/model/category_model.dart';
// import 'package:tech_haven/core/models/category.dart';

class DataSourceImpl implements DataSource {
  final FirebaseFirestore firebaseFirestore;
  DataSourceImpl({
    required this.firebaseFirestore,
  });

  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  get mainCategoryName => null;

  @override
  Stream<String> getUserData() {
    try{
      
    }
  }

  List<CategoryModel> mainCategories = [];
  // @override
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

// Fetch sub-subcollection data
  Future<List<DocumentSnapshot>> fetchSubsubcollectionData(
      DocumentReference subDocRef) async {
    var subsubcollectionSnapshot =
        await subDocRef.collection('variantCategories').get();
    return subsubcollectionSnapshot.docs;
  }
}
