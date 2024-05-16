import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:autoStation_promptBuy/src/helpers/line_data_helper.dart';
import 'package:autoStation_promptBuy/src/helpers/shared_preference_helper.dart';
import 'package:autoStation_promptBuy/src/helpers/term_and_con_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TermAndConHelper termAndConHelper = TermAndConHelper();
  final mockSocialDataPref = {
    "tcVersion": "1"
  };

  setUp(() {
    SharedPreferences.setMockInitialValues(mockSocialDataPref);
  });

  group('TermAndConHelper test', () {
    test('isTermAndConAccepted return false', () async {
      final tnc = await termAndConHelper.isTermAndConAccepted();
      expect(tnc, false);
    });

    test('isTermAndConAccepted return false', () async {
      final mock = {
        "tc_version": "1"
      };
      await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
      await PreferencesHelper.setString("tcVersion", "1");
      final tnc = await termAndConHelper.isTermAndConAccepted();
      expect(tnc, true);
    });

    test('setTermAndConToAccept', () async {
      final mock = {
        "tc_version": "2"
      };
      await LineDataHelper().saveSocialDataToLocalStorage(json.encode(mock));
      await termAndConHelper.setTermAndConToAccept();
      final tnc = await PreferencesHelper.getString("tcVersion");
      expect(tnc, "2");
    });
  });

}
