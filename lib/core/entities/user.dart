class User {
  final String? uid;
  final String? phoneNumber;
  final String? username;
  final String? email;
  final String? profilePhoto;
  final bool isVendor;
  final bool isProfilePhotoUploaded;
  final int color;

  User({
    required this.isVendor,
    required this.isProfilePhotoUploaded,
    required this.uid,
    required this.phoneNumber,
    required this.username,
    required this.email,
    required this.profilePhoto,
    required this.color,
  });


}
