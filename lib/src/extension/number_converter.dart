import 'package:intl/intl.dart';

extension NumberConverter on double {
  String toDecimalFormat() {
    return NumberFormat.decimalPatternDigits(decimalDigits: 2).format(this);
  }
}
