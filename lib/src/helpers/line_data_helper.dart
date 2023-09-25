// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:html';

class LineDataHelper {
  Storage localStorage = window.localStorage;

  void lineDataGrabber(String key, String value) {
    switch (key) {
      case "code":
        localStorage.addAll({"code": value});
        break;
      case "liff.state":
        String code = value.split("&")[0].replaceAll("?code=", "");

        localStorage.addAll({"code": code});
        break;
      default:
        break;
    }
  }

  String getLineCode() {
    String code = "";

    localStorage.forEach((key, value) {
      if (key == "code" && value.isNotEmpty) {
        code = value;
      }
    });

    return code;
  }

  bool isLineCodeExist() {
    bool exist = false;

    localStorage.forEach((key, value) {
      if (key == "code" && value.isNotEmpty) {
        exist = true;
      }
    });

    return exist;
  }

  void saveSocialDataToLocalStorage(dynamic data) {
    localStorage.addAll({"socialData": data});
  }

  Map<dynamic, dynamic> _getSocialData() {
    var socialData = {};

    localStorage.forEach((key, value) {
      if (key == "socialData" && value.isNotEmpty) {
        socialData = json.decode(value);
      }
    });

    return socialData;
  }

  String getLineUid() {
    return _getSocialData()["uid"];
  }

  String getLineAccessToken() {
    return _getSocialData()["access_token"] ?? '';
  }
}
