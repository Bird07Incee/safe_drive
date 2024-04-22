import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';

void main() {
  test('Should return string as the decimal number formatted', () {
    String expectedStr = '1,000,000';
    double number = 1000000;
    expect(number.toDecimalFormat(), expectedStr);
  });
}
