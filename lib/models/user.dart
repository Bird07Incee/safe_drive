import 'package:marketplace_line_oa/models/line_auth.dart';

class User {
  final String umid;
  final LineAuth? lineAuth;

  User({required this.umid, this.lineAuth});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      umid: data['umid'],
    );
  }

}