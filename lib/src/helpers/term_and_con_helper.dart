import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/helpers/shared_preference_helper.dart';

class TermAndConHelper {
  Future<bool> isTermAndConAccepted() async {
    String acceptedVersion = await PreferencesHelper.getString("tcVersion");
    String currentVersion = await LineDataHelper().getTAndC();
    return (acceptedVersion == currentVersion && currentVersion.isNotEmpty);
  }

  void setTermAndConToAccept() async {
    String tcVersion = await LineDataHelper().getTAndC();
    PreferencesHelper.setString("tcVersion", tcVersion);
  }
}
