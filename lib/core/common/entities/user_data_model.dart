// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
class UserDataModel {
  final String uid;
  final String phoneNumber;
  final String username;
  final String email;
  final bool isProfilePhotoUploaded;
  final int color;
  final String profilePhoto;
  final bool isVendor;

  UserDataModel({
    required this.uid,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.isProfilePhotoUploaded,
    required this.color,
    required this.profilePhoto,
    required this.isVendor,
  });
}


// @JsonSerializable()
// class Location {
//   final String street;
//   final String city;
//   final String state;
//   final String zip;

//   Location({
//     required this.street,
//     required this.city,
//     required this.state,
//     required this.zip,
//   });

//   static fromJson(Map<String, dynamic> e) {}
// }
