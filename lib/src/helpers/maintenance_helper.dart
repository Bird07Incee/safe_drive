import 'dart:convert';

import 'package:marketplace_line_oa/src/helpers/shared_preference_helper.dart';

class MaintenanceHelper {
  Future<void> saveMaintenanceDataToLocalStorage(String data) async {
    await PreferencesHelper.setString("maintenanceData", data);
  }

  Future<String> getMaintenanceDataForCreateTransaction() async {
    var value = await PreferencesHelper.getString("maintenanceData");
    Map valueMap = json.decode(value);
    String ma = valueMap["create"] ?? "False";
    return ma != '' ? ma : "False";
  }
}
