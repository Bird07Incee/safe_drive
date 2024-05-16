import 'package:autoStation_promptBuy/src/constants/my_constants.dart';

class TruncatedHtmlText {
  String removeHtmlForbiddenTagsTags(String input) {
    for (String tag in ProductDetailConst().forbiddenTags) {
      String ht = '<$tag[^>]*>';
      RegExp tagRegex = RegExp(ht);
      input = input.replaceAll(tagRegex, '');
    }
    return input;
  }

  // Function for  delete the entire line of tags and do not want to show
  String removeTags(String html, List<String> tagsToRemove) {
    // Create a regular expression pattern for specified HTML tags
    String pattern = '<(?:${tagsToRemove.join('|')})[^>]*>.*?</(?:${tagsToRemove.join('|')})>';
    RegExp exp = RegExp(pattern, caseSensitive: false, multiLine: true);

    // Remove the specified HTML tags from the string
    String result = html.replaceAll(exp, '');
    return result;
  }

  // Function for refactor html content to one line, example, <p>textt</p><p>textt</p
  String refactorHtml(String html) {
    String updatedHtml = html;
    // updatedHtml = html.replaceAll('</p>', '\n');
    updatedHtml = updatedHtml.replaceAll('&ndash;', '-');
    updatedHtml = updatedHtml.replaceAll('&nbsp;', ' ');
    updatedHtml = updatedHtml.split('\n').map((line) => line).join();
    return updatedHtml;
  }

  String fixIncompleteHtmlTags(String input) {
    // Split the input string into characters
    List<String> characters = input.split('');

    // Track the opening and closing brackets
    int openingCount = 0;
    int closingCount = 0;

    // Iterate through the characters
    for (int i = 0; i < characters.length; i++) {
      if (characters[i] == '<') {
        openingCount++;
      } else if (characters[i] == '>') {
        closingCount++;
      }
    }

    // Check if there are missing opening brackets at the beginning
    while (openingCount < closingCount) {
      characters.insert(0, '</');
      openingCount++;
    }

    // Check if there are missing closing brackets at the end
    while (closingCount < openingCount) {
      characters.add('>');
      closingCount++;
    }

    // Join the characters back into a string
    String result = characters.join('');

    return result;
  }

  // Function for cut content string show characters to delete (20% of total characters)
  String deleteCharacters(String input) {
    if (input.isEmpty) {
      // Handle empty string if needed
      return input;
    }

    // Calculate the number of characters to delete (20% of total characters)
    int charactersToDelete = (input.length * 0.2).round();

    // Ensure that at least one character is deleted
    charactersToDelete = charactersToDelete == 0 ? 1 : charactersToDelete;

    // Delete characters from the end of the string
    String result = input.substring(0, input.length - charactersToDelete);

    return result;
  }

  // Function for checking topics and insert <p>
  String insertPTag(String input) {
    int brIndex = input.indexOf("<br>");

    if (brIndex != -1) {
      // Extract the substring before the first <br> tag
      String beforeBr = input.substring(0, brIndex);

      // Insert <p> tag at the end of the substring before <br>
      input = input.replaceFirst(beforeBr, "<p>$beforeBr</p>");
    }

    return input;
  }

  // Function for checking whether input has html tags or not, excluding <br>
  bool containsHtmlTags(String input) {
    input = input.replaceAll("<br/>", "<br>");
    RegExp htmlTagRegExp = RegExp(r'<[^br/>]+>');
    return htmlTagRegExp.hasMatch(input);
  }

  // Function for checking tags br
  int countBrTags(String htmlString) {
    RegExp regex = RegExp('<br>', caseSensitive: false);
    Iterable<RegExpMatch> matches = regex.allMatches(htmlString);
    return matches.length;
  }
}
