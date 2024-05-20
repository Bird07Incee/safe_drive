import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/helpers/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  LineDataHelper lineDataHelper = LineDataHelper();
  final mockSocialDataPref = {
    "tcVersion": "1"
  };

  setUp(() {
    SharedPreferences.setMockInitialValues(mockSocialDataPref);
  });

  group('LineDataHelper test', () {
    test('method lineDataGrabber test case [code]', () async {
      await lineDataHelper.lineDataGrabber("code", "test");
      final expected = await PreferencesHelper.getString("code");
      expect(expected, "test");
    });

    test('method lineDataGrabber test case [liff.state]', () async {
      await lineDataHelper.lineDataGrabber("liff.state", "?code=abc&state=asd");
      final expected = await PreferencesHelper.getString("code");
      expect(expected, "abc");
    });

    test('method lineDataGrabber test case [default]', () async {
      await lineDataHelper.lineDataGrabber("default", "default");
      final expected = await PreferencesHelper.getString("default");
      expect(expected, "");
    });

    test('method getLineCode test', () async {
      await PreferencesHelper.setString("code", "test");
      final lineCode = await lineDataHelper.getLineCode();
      expect(lineCode, "test");
    });

    test('method getLineUid test', () async {
      final mock = {
        "tc_version": "2",
        "uid": "uid"
      };
      await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
      final lineUid = await lineDataHelper.getLineUid();
      expect(lineUid, "uid");
    });

    test('method getTokenExp test', () async {
      final mock = {
        "tc_version": "2",
        "uid": "uid",
        "expires_in": 1000
      };
      await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
      final exp = await lineDataHelper.getTokenExp();
      expect(exp, 1000);
    });
  });

}
