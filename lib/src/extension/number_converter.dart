import 'package:intl/intl.dart';

extension NumberConverter on int {
  String toDecimalFormat() {
    return NumberFormat.decimalPattern().format(this);
  }
}
