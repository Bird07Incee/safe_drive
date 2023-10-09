import 'package:marketplace_line_oa/src/helpers/shared_preference_helper.dart';

class TermAndConHelper {
  Future<bool> isTermAndConAccepted() async {
    var accepted = PreferencesHelper.getBool("termAndConAccepted");
    return accepted;
  }

  void setTermAndConToAccept() {
    PreferencesHelper.setBool("termAndConAccepted", true);
  }
}
