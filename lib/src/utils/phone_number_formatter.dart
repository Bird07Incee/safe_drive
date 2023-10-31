bool isNumeric(String s) {
  return double.tryParse(s) != null;
}

String phoneNumberFormatter(String text) {
  if (!isNumeric(text)) {
    return text;
  }

  if (text.length == 9 || text.length == 10) {
    String result = "";
    if (text.length == 9) {
      result = "${text.substring(0, 2)}-${text.substring(2, 5)}-${text.substring(5, 9)}";
    } else if (text.length == 10) {
      result = "${text.substring(0, 3)}-${text.substring(3, 6)}-${text.substring(6, 10)}";
    }
    return result;
  } else {
    return text;
  }
}
