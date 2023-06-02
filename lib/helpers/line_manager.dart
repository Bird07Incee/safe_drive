// ignore_for_file: file_names, use_build_context_synchronously
// ignore: avoid_web_libraries_in_flutter

class LineUtility {
  // late LineProfile _profile = LineProfile();

  /// Generate JWT ID Token for make a authenticate to API Services
  Future<String> lineGenerateIDToken() async {
    // String uid = await checkLogin();
    // String resultJs = await promiseToFuture(uid);
    // _profile = LineProfile.fromJson(jsonDecode(resultJs));

    String jwtToken;
    // final jwt = JWT(
    //   {'uuid': _profile.userId, 'lineName': _profile.displayName, 'linePicture': _profile.pictureUrl.toString(), 'accessToken': _profile.accessToken},
    // );
    //
    // // Sign it
    // jwtToken = jwt.sign(
    //   SecretKey(KEY_ENCODE_AUTH_FLUTTER),
    //   algorithm: JWTAlgorithm.HS512,
    // );

    // print("LINE JWT: $jwtToken");
    // return jwtToken;
    return "";
  }
}
