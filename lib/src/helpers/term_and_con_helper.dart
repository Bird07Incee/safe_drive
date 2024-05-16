import 'package:autoStation_promptBuy/src/helpers/line_data_helper.dart';
import 'package:autoStation_promptBuy/src/helpers/shared_preference_helper.dart';

class TermAndConHelper {
  Future<bool> isTermAndConAccepted() async {
    String acceptedVersion = await PreferencesHelper.getString("tcVersion");
    String currentVersion = await LineDataHelper().getTAndC();
    return (acceptedVersion == currentVersion && currentVersion.isNotEmpty);
  }

  Future<void> setTermAndConToAccept() async {
    String tcVersion = await LineDataHelper().getTAndC();
    await PreferencesHelper.setString("tcVersion", tcVersion);
  }
}
