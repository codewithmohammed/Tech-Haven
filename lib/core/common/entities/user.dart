import 'dart:typed_data';

class User {
  final String id;
  final String phonenumber;
  final String email;
  final String username;
  final Uint8List profilephoto;

  User({
    required this.id,
    required this.phonenumber,
    required this.email,
    required this.username,
    required this.profilephoto
  });
}
