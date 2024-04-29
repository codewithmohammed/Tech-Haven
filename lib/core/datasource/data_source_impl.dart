import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/core/datasource/data_source.dart';
import 'package:tech_haven/core/error/exceptions.dart';
import 'package:tech_haven/user/features/searchcategory/data/models/category_model.dart';
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
    // TODO: implement getAllCategories
    throw UnimplementedError();
  }

  // @override
  @override
  Future<List<CategoryModel>> getAllCategoryData() async {
    List<CategoryModel> mainCategories = [];
    List<CategoryModel> subcategories = [];
    List<CategoryModel> variants = [];
    try {
      final mainSnapshot =
          await firebaseFirestore.collection('categories').get();
      for (var mainCategoryDoc in mainSnapshot.docs) {
        var mainDocumentData = mainCategoryDoc.data();
        CategoryModel mainCategory = CategoryModel.fromJson(mainDocumentData);
        mainCategories.add(mainCategory);
        print(mainCategory.categoryName);
        final subSnapshotDocs =
            await fetchSubcollectionData(mainCategoryDoc.reference);

        for (var subCategoryDoc in subSnapshotDocs) {
          var subDocumentData = subCategoryDoc.data() as Map<String, dynamic>;
          CategoryModel subCategory = CategoryModel.fromJson(subDocumentData);
          print(subCategory.categoryName);
          subcategories.add(subCategory);
          final variantSnapshotDocs =
              await fetchSubsubcollectionData(subCategoryDoc.reference);

          for (var variantCategoryDoc in variantSnapshotDocs) {
            var variantDocumentData =
                variantCategoryDoc.data() as Map<String, dynamic>;
            CategoryModel variantCategory =
                CategoryModel.fromJson(variantDocumentData);
            variants.add(variantCategory);
          }
          subCategory.subCategories = variants;
        }
        mainCategory.subCategories = subcategories;
      }
      return mainCategories;
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
