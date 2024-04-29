import 'package:tech_haven/core/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.uid,
    required super.phoneNumber,
    required super.email,
    required super.username,
    required super.profilePictureURL,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      username: map['username'],
      profilePictureURL: map['profilePictureURL'],
    );
  }
  Map<String, dynamic> toJson() => {
        "uid": uid ?? '',
        "phoneNumber": phoneNumber ?? '',
        "email": email ?? '',
        "username": username ?? '',
        "profilePictureURL": profilePictureURL ?? ''
      };
}
