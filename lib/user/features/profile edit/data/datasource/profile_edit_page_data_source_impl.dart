import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/user/features/profile%20edit/data/datasource/profile_edit_page_data_source.dart';
import 'package:uuid/uuid.dart';

class ProfileEditPageDataSourceImpl implements ProfileEditPageDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  ProfileEditPageDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseStorage});
  @override
  Future<void> updateUserData(UserModel userModel, File? newImage) async {
    String? imageUrl;
    String imageID = const Uuid().v1();
    if (newImage != null) {
      Reference reference = firebaseStorage
          .ref('user')
          .child('usersProfilePicture')
          .child(userModel.uid!)
          .child(userModel.userImageID ?? imageID);
      await reference.putFile(newImage);
      imageUrl = await reference.getDownloadURL();
    }
    final userData = userModel.toJson();
    if (imageUrl != null) {
      userData['profilePicture'] = imageUrl;
    }
    await firebaseFirestore.collection('users').doc(userModel.uid).update({
      'username': userModel.username,
      'profilePicture': newImage != null ? imageUrl : userModel.profilePhoto,
      'isProfilePictureUploader': userModel.isProfilePhotoUploaded,
    });
  }
}
