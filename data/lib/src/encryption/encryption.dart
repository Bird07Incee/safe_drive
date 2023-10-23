import 'dart:math';

class Encrypt {
  static final _r = Random();
  static const _number = "0123456789";
  static const _alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  Encrypt();

  static String random(int len) {
    final lowerCase = _alphabet.toLowerCase();
    final upperCase = _alphabet.toUpperCase();
    final chars = lowerCase + upperCase + _number;
    String random = _random(_r, chars.length, chars);
    random = _random(_r, len, chars);
    return random.toLowerCase();
  }

  static _random(Random r, int len, String allowChars) {
    return List.generate(len, (index) {
      return allowChars[r.nextInt(allowChars.length)];
    }).join();
  }
}
