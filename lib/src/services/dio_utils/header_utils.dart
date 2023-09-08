import 'dart:io';

import 'package:uuid/uuid.dart';

class HeaderUtil {
  static Map<String, dynamic> get baseHeader {
    String dateTime = DateTime.now().toUtc().add(const Duration(hours: 7)).toIso8601String();
    const uuid = Uuid();
    return {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      HttpHeaders.acceptHeader: "application/json",
      "nonce": "MARKETPLACE|${uuid.v4()}|$dateTime",
      "Access-Control-Allow-Origin": "*"
    };
  }
}
