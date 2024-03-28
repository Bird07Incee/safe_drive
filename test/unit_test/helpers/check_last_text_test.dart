import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/helpers/check_last_text.dart';

void main() {
  group('CheckLastText', () {
    test('checkLastWord returns true if last word matches', () {
      CheckLastText checkLastText = CheckLastText();
      String text = 'This is a sample text';
      String lastWord = 'text';
      bool result = checkLastText.checkLastWord(text, lastWord);
      expect(result, true);
    });
    test('checkLastWord returns false if text is empty', () {
      CheckLastText checkLastText = CheckLastText();
      String text = '';
      String lastWord = 'text';
      bool result = checkLastText.checkLastWord(text, lastWord);
      expect(result, false);
    });

    test('checkLastWord returns false if lastWord is empty', () {
      CheckLastText checkLastText = CheckLastText();
      String text = 'This is a sample text';
      String lastWord = '';
      bool result = checkLastText.checkLastWord(text, lastWord);
      expect(result, false);
    });

    test('checkLastWord returns false if last word does not match', () {
      CheckLastText checkLastText = CheckLastText();
      String text = 'This is a sample text';
      String lastWord = 'different';
      bool result = checkLastText.checkLastWord(text, lastWord);
      expect(result, false);
    });
  });
}
