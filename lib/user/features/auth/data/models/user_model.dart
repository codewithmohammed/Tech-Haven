import 'package:tech_haven/core/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.uid,
    required super.phoneNumber,
    required super.email,
    required super.username,
    required super.profilePhoto,
    required super.isVendor,
    required super.isProfilePhotoUploaded,
    required super.color,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      username: json['username'],
      profilePhoto: json['profilePictureURL'],
      isVendor: json['isVendor'],
      isProfilePhotoUploaded: json['isProfilePhotoUploaded'],
      color: json['color'],
    );
  }
  Map<String, dynamic> toJson() => {
        "uid": uid ?? '',
        "phoneNumber": phoneNumber ?? '',
        "email": email ?? '',
        "username": username ?? '',
        "profilePictureURL": profilePhoto ?? '',
        "isVendor": isVendor,
        "color": color,
        "isProfilePhotoUploaded": isProfilePhotoUploaded,
      };
}
