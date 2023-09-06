// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class LineDataHelper {
  Storage localStorage = window.localStorage;

  void lineDataGrabber(String key, String value) {
    switch (key) {
      case "code":
        localStorage.addAll({"code": value});
        break;
      case "state":
        localStorage.addAll({"state": value});
        break;
      case "liffClientId":
        localStorage.addAll({"liffClientId": value});
        break;
      case "liffRedirectUri":
        localStorage.addAll({"liffRedirectUri": value});
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
}
