// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class TermAndConHelper {
  Storage localStorage = window.localStorage;

  bool isTermAndConAccepted() {
    var accepted = false;

    localStorage.forEach((key, value) {
      if (key == "termAndConAccepted") {
        accepted = true;
      }
    });

    return accepted;
  }

  void setTermAndConToAccept() {
    localStorage.addAll({"termAndConAccepted": "true"});
  }
}
