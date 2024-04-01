
class UserDataModel {
  final String phonenumberVerifiedUID;
  final String signUpUID;
  final String phonenumber;
  final String username;
  final String email;
  final bool isprofilephotoUploaded;
  final String profilephoto;
  final bool isVendore;

  UserDataModel(
      {required this.phonenumberVerifiedUID,
      required this.signUpUID,
      required this.username,
      required this.phonenumber,
      required this.email,
      required this.isprofilephotoUploaded,
      required this.profilephoto,
      required this.isVendore,});
}
