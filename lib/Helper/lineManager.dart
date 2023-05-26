// ignore_for_file: file_names, use_build_context_synchronously
// ignore: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:js_util';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:mkp_line_web/config.dart';
import 'package:mkp_line_web/Helper/lineliff.dart';
import 'package:mkp_line_web/Model/lineProfile.dart';

class LineUtility {
  late LineProfile _profile = LineProfile();

  /// Generate JWT ID Token for make a authenticate to API Services
  Future<String> lineGenerateIDToken() async {
    String uid = await checkLogin();
    String resultJs = await promiseToFuture(uid);
    _profile = LineProfile.fromJson(jsonDecode(resultJs));

    String jwtToken;
    final jwt = JWT(
      {'uuid': _profile.userId, 'lineName': _profile.displayName, 'linePicture': _profile.pictureUrl.toString(), 'accessToken': _profile.accessToken},
    );

    // Sign it
    jwtToken = jwt.sign(
      SecretKey(KEY_ENCODE_AUTH_FLUTTER),
      algorithm: JWTAlgorithm.HS512,
    );

    print("LINE JWT: $jwtToken");
    return jwtToken;
  }
}
