import 'package:intl/intl.dart';

extension NumberConverter on int {
  String toDecimalFormat() {
    return NumberFormat.decimalPattern().format(this);
  }
}


extension PathConverter on String {

  bool isLatLong() {
    RegExp latLng = RegExp(r'^((\-?|\+?)?\d+(\.\d+)?),\s*((\-?|\+?)?\d+(\.\d+)?)$');
    if (!contains(',')) {
      return false;
    }
    return latLng.hasMatch(this);
  }
}
