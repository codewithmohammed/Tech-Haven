
import 'package:tech_haven/core/common/entities/user_data_model.dart';

class UserDataModelImpl extends UserDataModel {
  
  UserDataModelImpl({
    required super.uid,
    required super.phoneNumber,
    required super.email,
    required super.username,
    required super.isProfilePhotoUploaded,
    required super.color,
    required super.profilePhoto,
    required super.isVendor,
  });
//must send the snapshot of the document after
factory UserDataModelImpl.fromJson(Map<String, dynamic> json) =>
      UserDataModelImpl(
        uid: json['uid'] as String,
        phoneNumber: json['phoneNumber'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
        isProfilePhotoUploaded: json['isProfilePhotoUploaded'] as bool,
        color: json['color'] as int,
        profilePhoto: json['profilePhoto'] as String,
        isVendor: json['isVendor'] as bool,
      );


 Map<String, dynamic> toJson() => {
        'uid': uid,
        'phoneNumber': phoneNumber,
        'email': email,
        'username': username,
        'isProfilePhotoUploaded': isProfilePhotoUploaded,
        'color' : color,
        'profilePhoto': profilePhoto,
        'isVendor': isVendor,
      };
}
