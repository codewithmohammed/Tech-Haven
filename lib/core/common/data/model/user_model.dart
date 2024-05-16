import 'package:tech_haven/core/entities/user.dart';

class UserModel extends User{
  UserModel({required super.isVendor, required super.isProfilePhotoUploaded, required super.uid, required super.phoneNumber, required super.username, required super.email, required super.profilePhoto, required super.color});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      phoneNumber: json['phoneNumber'],
      username: json['username'],
      email: json['email'],
      profilePhoto: json['profilePhoto'],
      isVendor: json['isVendor'],
      isProfilePhotoUploaded: json['isProfilePhotoUploaded'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'username': username,
      'email': email,
      'profilePhoto': profilePhoto,
      'isVendor': isVendor,
      'isProfilePhotoUploaded': isProfilePhotoUploaded,
      'color': color,
    };
  }
}