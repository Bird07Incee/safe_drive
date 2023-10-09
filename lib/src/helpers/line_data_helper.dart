// // ignore: avoid_web_libraries_in_flutter
// import 'dart:convert';
// import 'package:universal_html/html.dart';
//
// class LineDataHelper {
//   Storage localStorage = window.localStorage;
//
//   void lineDataGrabber(String key, String value) {
//     switch (key) {
//       case "code":
//         localStorage.addAll({"code": value});
//         break;
//       case "liff.state":
//         String code = value.split("&")[0].replaceAll("?code=", "");
//
//         localStorage.addAll({"code": code});
//         break;
//       default:
//         break;
//     }
//   }
//
//   String getLineCode() {
//     String code = "";
//
//     localStorage.forEach((key, value) {
//       if (key == "code" && value.isNotEmpty) {
//         code = value;
//       }
//     });
//
//     return code;
//   }
//
//   bool isLineCodeExist() {
//     bool exist = false;
//
//     localStorage.forEach((key, value) {
//       if (key == "code" && value.isNotEmpty) {
//         exist = true;
//       }
//     });
//
//     return exist;
//   }
//
//   void saveSocialDataToLocalStorage(dynamic data) {
//     localStorage.addAll({"socialData": data});
//   }
//
//   Map<dynamic, dynamic> _getSocialData() {
//     var socialData = {};
//
//     localStorage.forEach((key, value) {
//       if (key == "socialData" && value.isNotEmpty) {
//         socialData = json.decode(value);
//       }
//     });
//
//     return socialData;
//   }
//
//   String getLineUid() {
//     return _getSocialData()["uid"];
//   }
//
//   String getLineAccessToken() {
//     return _getSocialData()["access_token"] ?? '';
//   }
// }

import 'dart:convert';

import 'package:marketplace_line_oa/src/helpers/shared_preference_helper.dart';

class LineDataHelper {
  void lineDataGrabber(String key, String value) {
    switch (key) {
      case "code":
        PreferencesHelper.setString("code", value);
        break;
      case "liff.state":
        String code = value.split("&")[0].replaceAll("?code=", "");
        PreferencesHelper.setString("code", code);
        break;
      default:
        break;
    }
  }

  Future<String> getLineCode() {
    return PreferencesHelper.getString("code");
  }

  void saveSocialDataToLocalStorage(String data) {
    PreferencesHelper.setString("socialData", data);
  }

  Future<Map<dynamic, dynamic>> _getSocialData() async {
    var value = await PreferencesHelper.getString("socialData");
    return value != '' ? json.decode(value) : {};
  }

  Future<String> getLineUid() async {
    var data = await _getSocialData();
    return data["uid"] ?? '';
  }

  Future<String> getLineAccessToken() async {
    var data = await _getSocialData();
    return data["access_token"] ?? '';
  }
}
