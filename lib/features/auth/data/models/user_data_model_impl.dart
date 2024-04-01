
import 'package:tech_haven/core/common/entities/user_data_model.dart';

class UserDataModelImpl extends UserDataModel {
  UserDataModelImpl({
    required super.phonenumberVerifiedUID,
    required super.signUpUID,
    required super.phonenumber,
    required super.email,
    required super.username,
    required super.isprofilephotoUploaded,
    required super.profilephoto,
    required super.isVendore,
  });
//must send the snapshot of the document after 
  factory UserDataModelImpl.fromJson(Map<String, dynamic> map) {
    return UserDataModelImpl(
      phonenumberVerifiedUID: map['phonenumberVerifiedUID'],
      signUpUID: map['signUpUID'],
      phonenumber: map['phonenumber'],
      email: map['email'],
      username: map['username'],
      isprofilephotoUploaded: map['isprofilephotoUploaded'],
      profilephoto: map['profilephoto'],
      isVendore: map['isVendor'],
    );
  }

  Map<String, dynamic> toJson() => {
        "phonenumberVerifiedUID": phonenumberVerifiedUID,
        "signUpUID": signUpUID,
        "phonenumber": phonenumber,
        "email": email,
        "username": username,
        "isprofilephotoUploaded" : isprofilephotoUploaded,
        "profilephoto": profilephoto,
        "isVendor" : isVendore,
      };

  // UserDataModel copyWith({
  //   String? userId,
  //   String? phonenumber,
  //   String? email,
  //   String? username,
  //   Uint8List? profilephoto,
  // }) {
  //   return UserModel(
  //     userId: userId ?? this.userId,
  //     phonenumber: phonenumber ?? this.phonenumber,
  //     email: email ?? this.email,
  //     username: username ?? this.username,
  //     profilephoto: profilephoto ?? this.profilephoto,
  //   );
  // }
}
