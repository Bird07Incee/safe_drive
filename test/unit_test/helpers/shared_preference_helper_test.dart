import 'package:flutter_test/flutter_test.dart';
import 'package:autoStation_promptBuy/src/helpers/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final mockSocialDataPref = {
    "access_token": "test",
    "refresh_token": "test"
  };

  setUp(() {
    SharedPreferences.setMockInitialValues(mockSocialDataPref);
  });

  group('SharedPreferenceHelper test', () {
    test('case get, set boolean', () async{
      await PreferencesHelper.setBool("bool", true);
      final bool = await PreferencesHelper.getBool("bool");
      expect(bool, true);
    });

    test('case get, set int', () async{
      await PreferencesHelper.setInt("int", 0);
      final int = await PreferencesHelper.getInt("int");
      expect(int, 0);
    });

    test('case get, set double', () async{
      await PreferencesHelper.setDouble("double", 1000.5);
      final double = await PreferencesHelper.getDouble("double");
      expect(double, 1000.5);
    });

    test('case get, set string', () async{
      await PreferencesHelper.setString("string", "test");
      final string = await PreferencesHelper.getString("string");
      expect(string, "test");
    });

    test('case get, set list<String>', () async{
      await PreferencesHelper.setList("list", ["test"]);
      final list = await PreferencesHelper.getList("list");
      expect(list, ["test"]);
    });

    test('case remove by key', () async{
      await PreferencesHelper.setString("remove", "remove");
      await PreferencesHelper.remove("remove");
      final remove = await PreferencesHelper.getString("remove");
      expect(remove, "");
    });

    test('case isContains', () async{
      await PreferencesHelper.setList("list", ["test"]);
      final isContains = await PreferencesHelper.isContains("list");
      final isNotContains = await PreferencesHelper.isContains("xxx");
      expect(isContains, true);
      expect(isNotContains, false);
    });

    test('case remove all data', () async{
      await PreferencesHelper.setList("list", ["test"]);
      await PreferencesHelper.clear();
      final list = await PreferencesHelper.getList("list");
      expect(list, []);
    });
  });

}
