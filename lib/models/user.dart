
import 'dart:typed_data';

late User? user;

class User {
  String name;
  String major;
  String dateBirth;
  String email;
  Uint8List? image;

  User({
    required this.name,
    required this.major,
    required this.dateBirth,
    required this.email,
  });
}
