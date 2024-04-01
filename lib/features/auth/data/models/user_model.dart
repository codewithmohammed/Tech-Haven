

import 'package:tech_haven/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.signUpUID,
    required super.phonenumber,
    required super.email,
    required super.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      signUpUID: map['signUpUID'],
      phonenumber: map['phonenumber'],
      email: map['email'],
      username: map['username'],
    );
  }
   Map<String, dynamic> toJson() => {
        "signUpUID": signUpUID,
        "phonenumber": phonenumber,
        "email": email,
        "username": username,
      };
}
