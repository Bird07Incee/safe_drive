import 'package:autoStation_promptBuy/src/helpers/shared_preference_helper.dart';

class MaintenanceHelper {
  Future<void> saveMaintenanceDataToLocalStorage(String data) async {
    await PreferencesHelper.setString("maintenanceData", data);
  }

  Future<String> getMaintenanceData() async {
    var value = await PreferencesHelper.getString("maintenanceData");
    return value != '' ? value : "false";
  }
}
