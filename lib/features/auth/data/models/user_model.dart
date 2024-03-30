import 'dart:typed_data';
import 'package:tech_haven/core/common/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.phonenumber,
      required super.email,
      required super.username,
      required super.profilephoto});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      profilephoto: map['profilephoto'] ?? '',
    );
  }

  UserModel copyWith({
    String? id,
    String? phonenumber,
    String? email,
    String? username,
    Uint8List? profilephoto,

  }) {
    return UserModel(
      id: id ?? this.id,
      phonenumber: phonenumber ?? this.phonenumber,
      email: email ?? this.email,
      username: username ?? this.username,
      profilephoto: profilephoto ?? this.profilephoto,
    );
  }
}
