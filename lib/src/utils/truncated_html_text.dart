import 'package:html/parser.dart' as html_parser;
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/produc_detail_tagline_toggle/product_detail_description_cubit.dart';

enum Section { tagLine, description }

class TruncatedHtmlText {
  removeForbiddenTagline(String tagline) {
    RegExp emojiRegex = RegExp(
        r'[\u{1F600}-\u{1F64F}' // Emoticons
        r'\u{1F300}-\u{1F5FF}' // Misc Symbols and Pictographs
        r'\u{1F680}-\u{1F6FF}' // Transport and Map
        r'\u{1F700}-\u{1F77F}' // Alchemical Symbols
        r'\u{1F780}-\u{1F7FF}' // Geometric Shapes Extended
        r'\u{1F800}-\u{1F8FF}' // Supplemental Arrows-C
        r'\u{1F900}-\u{1F9FF}' // Supplemental Symbols and Pictographs
        r'\u{1FA00}-\u{1FA6F}' // Chess Symbols
        r'\u{1FA70}-\u{1FAFF}' // Symbols and Pictographs Extended-A
        r'\u{2600}-\u{26FF}' // Miscellaneous Symbols
        r'\u{2700}-\u{27BF}' // Dingbats
        r'\u{2B50}' // Stars
        r'\u{2B55}' // Circles
        r'\u{23F0}' // Alarm Clock
        r'\u{23F3}' // Hourglass
        r'\u{231A}-\u{231B}' // Watches
        r'\u{1F004}' // Mahjong Tile Red Dragon
        r'\u{1F0CF}]' // Playing Card Black Joker
        r'|[\u{2702}-\u{27B0}]', // Additional Dingbats
        unicode: true,
        dotAll: true);

    TruncatedHtmlText truncatedHtmlText = TruncatedHtmlText();
    tagline = truncatedHtmlText.decodeHtmlEntities(tagline);
    tagline = tagline.replaceAll(emojiRegex, "");

    tagline = truncatedHtmlText.removeHtmlForbiddenTagsTags(tagline);
    //   final RegExp regExp = RegExp(r'<thead[^>]*>.*?<\/thead>', multiLine: true, caseSensitive: true, dotAll: true);
    //   tagline = tagline.replaceAll(regExp, '');

    for (var replacement in [
      //      {"<table>": "<p>", "</table>": "</p>"},
      {"<code>": "", "</code>": ""},
      {"<pre>": "<p>", "</pre>": "</p>"},
      {"<del>": "", "</del>": ""},
      //      {"<thead>": "", "</thead>": ""},
      //      {"<tr>": "", "</tr>": ""},
      //      {"<th>": "", "</th>": ""},
      //      {"<tbody>": "", "</tbody>": ""},
      //      {"<td>": "", "</td>": ""},
      {"<strong>": "<b>", "</strong>": "</b>"},
      {"<span>": "", "</span>": ""},
      {"<em>": "", "</em>": ""},
      // {"<b>": "", "</b>": ""},
      {"<i>": "", "</i>": ""},
      // {"<u>": "", "</u>": ""},
      {"<s>": "", "</s>": ""},
      {"<strike>": "", "</strike>": ""},
      {"<sub>": "", "</sub>": ""},
      {"<sup>": "", "</sup>": ""},
      {"<a>": "", "</a>": ""},
      {"<mark>": "", "</mark>": ""}
    ]) {
      replacement.forEach((key, value) {
        tagline = tagline.replaceAll(key, value);
      });
    }
    return tagline;
  }

  formatSubStringHtml(String tagline, ProductDetailDescriptionCubit myBloc, {int getMaxLines = 2}) {
    String? truncatedHtmlContent;
    int maxLines = getMaxLines;
    List<String> lines;
    int lineFinal = 0;
    String? textString;
    List<String> bigText = ['<h1>', '<h2>'];

    if (tagline != "") {
      // for (String tableTag in ProductDetailConst().htmlTableTag) {
      //   if (tagline.contains(tableTag)) {
      //     tagline = '''<h1>Table content is not supported</h1>''';
      //   }
      // }
      tagline = tagline.replaceAll("<br >", "<br>");
      tagline = tagline.replaceAll("<br />", "<br/>");
      tagline = removeHtmlForbiddenTagsTags(tagline);
      // tagline = removeInvalidWords(tagline);
      // check html tag in string input
      if (!containsHtmlTags(tagline)) {
        // insert <p> in title or first line
        tagline = insertPTag(tagline);
        // check expended content
        if (tagline.length >= 291) {
          // cut content string show 100 char
          //  isReadMoreVisible = true;
          textString = tagline.substring(0, 290);
          //set toggleDescription

          myBloc.updateToggleTapDescription(toggleDescription: false);
          //set maxLines lineFinal for lineFinal<=maxLines
          maxLines = 1;
          lineFinal = 2;
          // check html tag in textString
          if (containsHtmlTags(textString)) {
            // set truncatedHtmlContent in textString
            //  isReadMoreVisible = false;
            truncatedHtmlContent = textString;
          }
          // Verify that the data in characters does not exceed a line but is <br>Many items beyond the line.
        } else if (tagline.length <= 169 && countBrTags(tagline) >= 3) {
          // cut content string show characters to delete (20% of total characters)
          textString = deleteCharacters(tagline);
          //set toggleDescription
          myBloc.updateToggleTapDescription(toggleDescription: false);
          //set maxLines lineFinal for lineFinal<=maxLines
          maxLines = 1;
          lineFinal = 2;
          // check html tag in textString
          if (containsHtmlTags(textString)) {
            // set truncatedHtmlContent in textString
            truncatedHtmlContent = textString;
          }
        } else {
          // set toggleDescription adn textNotMoreThan When text does not exceed a line
          myBloc.updateToggleTapDescription(toggleDescription: true, textNotMoreThan: true);
        }
        //  This string does not contain any html tags.
      } else {
        // This string contains html tags.
        // List of tags that you want to delete the entire line of tags and do not want to show
        tagline = removeTags(tagline, ['table', 'th', 'tr', 'td', 'img', 'nav', 'mark']);

        // logic for replacing variables for replacements
        for (var replacement in ProductDetailConst().replacements) {
          replacement.forEach((key, value) {
            tagline = tagline.replaceAll(key, value);
          });
        }
        // refactor html content to one line, example, <p>text</p><p>text</p
        tagline = refactorHtml(tagline);
        // Delete/unnecessary from content
        tagline = tagline.replaceAll(' /', "");
        // Separate the tagline variable one line at a time by separating it from </,<br> and put it in lines.
        lines = tagline.split('</').expand((s) => s.split('<br>')).toList();

        // The process of counting lines and checking how many characters each line has and maxLine should be set.
        myBloc.updateToggleTapDescription(toggleDescription: true, textNotMoreThan: true);
        List<dynamic> truncatedHtmlTextResponse =
            truncatedHtmlContentBlock(lines, bigText, maxLines, lineFinal, truncatedHtmlContent ?? "", Section.tagLine, () {
          myBloc.updateToggleTapDescription(toggleDescription: false, textNotMoreThan: false);
        }, null);
        truncatedHtmlContent = truncatedHtmlTextResponse[0];
        maxLines = truncatedHtmlTextResponse[1];
        lineFinal = truncatedHtmlTextResponse[2];

        if (maxLines == 1 || maxLines == 2 || maxLines == 3) {
          if (truncatedHtmlContent!.length >= 285) {
            truncatedHtmlContent = truncatedHtmlContent.substring(0, 285);
            lineFinal = 4;
            myBloc.updateToggleTapDescription(toggleDescription: false, textNotMoreThan: false);
            for (int i = 0; i < bigText.length; i++) {
              if (truncatedHtmlContent!.contains(bigText[i])) {
                if (bigText[i] == "<h1>") {
                  truncatedHtmlContent = truncatedHtmlContent.substring(0, 80);
                } else {
                  truncatedHtmlContent = truncatedHtmlContent.substring(0, 210);
                }
              }
            }
          } else if (truncatedHtmlContent.length > 150 && truncatedHtmlContent.length <= 284) {
            lineFinal = 3;
            for (int i = 0; i < bigText.length; i++) {
              if (truncatedHtmlContent!.contains(bigText[i])) {
                if (bigText[i] == "<h1>") {
                  truncatedHtmlContent = truncatedHtmlContent.substring(0, 80);
                  myBloc.updateToggleTapDescription(toggleDescription: false, textNotMoreThan: false);
                } else {
                  truncatedHtmlContent = truncatedHtmlContent.substring(0, 150);
                  myBloc.updateToggleTapDescription(toggleDescription: false, textNotMoreThan: false);
                }
              }
            }
          } else {
            truncatedHtmlContent = truncatedHtmlContent.substring(0, truncatedHtmlContent.length);
          }
        }
      }
      truncatedHtmlContent ??= "";
      textString ??= "";
      return [lineFinal, maxLines, textString, truncatedHtmlContent];
    }
  }

  String removeHtmlForbiddenTagsTags(String input, {List<String> listForbidden = const []}) {
    for (String tag in listForbidden.isNotEmpty ? listForbidden : ProductDetailConst().forbiddenTags) {
      String ht = '<$tag[^>]*>';
      RegExp tagRegex = RegExp(ht);
      input = input.replaceAll(tagRegex, '');
    }
    return input;
  }

  String decodeHtmlEntities(String input) {
    final document = html_parser.parse(input);
    return document.body!.outerHtml;
  }

  String minifyHtml(String input) {
    // Remove new lines and multiple spaces
    input = input.replaceAll(RegExp(r'\s+'), ' ');

    // Remove spaces between HTML tags
    input = input.replaceAll(RegExp(r'> <'), '><');

    return input.trim();
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

  bool containsIncompleteTags(String input) {
    // Regular expressions to find incomplete tags
    RegExp incompleteStartTag = RegExp(r'(?<!<)[a-zA-Z]+>');
    RegExp incompleteEndTag = RegExp(r'<[a-zA-Z]+(?!>)');

    // Check if the input contains any incomplete tags
    return incompleteStartTag.hasMatch(input) || incompleteEndTag.hasMatch(input);
  }

  String fixIncompleteHtmlTags(String input) {
    // Split the input string into characters
    input = input.replaceAllMapped(RegExp(r'(?<!<)b>'), (match) => '</b>');

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

  List<dynamic> truncatedHtmlContentBlock(List<String> lines, List<String> bigText, int maxLines, int lineFinal, String truncatedHtmlContent,
      Section section, Function()? updateToggleTapDescription, Function()? setDescriptionState) {
    for (int i = 0; i < lines.length; i++) {
      //log("line[$i] ${lines[i].length} : ${lines[i]}");
      if (lines.length - 1 >= 1) {
        // If the first line is too long, then maxLine = 1.
        if (lines[0].length >= 150) {
          //log(("case 1"));
          maxLines = 1;
        }
      }
      if (lines.length - 1 >= 2) {
        // If the second line is too long and the first line is not too long, then maxLine = 2.
        if (lines[1].length >= 80 && lines[1].length <= 169 && lines[0].length <= 149) {
          maxLines = 2;
          //log(("case 2"));
          //log(("line ${lines.length} ${lines.length - 1 >= 3}"));
          for (int i = 0; i < bigText.length; i++) {
            if (lines[0].length >= 100 && lines[0].contains(bigText[i])) {
              maxLines = 1;
              //log(("case 2.0.1"));
            } else if (lines[0].length <= 100 &&
                !(lines[0].contains(bigText[i])) &&
                lines[1].length >= 80 &&
                lines[1].length <= 115 &&
                lines.length - 1 >= 3 &&
                lines[2].length >= 80 &&
                lines[2].length <= 115) {
              maxLines = 3;
              //log(("case 2.0.2"));
            }
          }

          // If the second line is too long and the first line is not too long, then maxLine = 2.
        } else if (lines[1].length >= 170 && lines[0].length <= 149) {
          maxLines = 2;
          //log(("case 2.1"));
          for (int i = 0; i < bigText.length; i++) {
            if (lines[0].length >= 100 && lines[0].contains(bigText[i])) {
              maxLines = 1;

              //log(("case 2.0.1"));
            }
          }
        }
        if (lines[1].length <= 80 && lines[0].length <= 149) {
          for (int i = 0; i < bigText.length; i++) {
            if (lines[0].length >= 70 && lines[0].contains(bigText[i])) {
              maxLines = 1;

              //log(("case 2.0.1"));
            }
            if (lines[0].length <= 69 && lines[0].contains(bigText[i]) && lines[1].contains(bigText[i])) {
              maxLines = 2;
              //log(("case 2.0.2"));
            }
          }
        }
      }
      if (lines.length - 1 >= 3) {
        // If the third line is too long and the second line is not too long and the first line is not too long, then maxLine = 3
        if (lines[2].length >= 100 && lines[2].length <= 169 && lines[1].length <= 80 && lines[0].length <= 149) {
          maxLines = 3;
          //log(("case 3"));
        } else if (lines[2].length >= 170 && lines[1].length <= 80 && lines[0].length <= 149) {
          maxLines = 3;
          //log(("case 3.1"));
        } else if (lines[2].length <= 10 && lines[1].length <= 80 && lines[0].length <= 149) {
          maxLines = 2;
          //log(("case 3.2"));
        }
        for (int i = 0; i < bigText.length; i++) {
          if (lines[2].length <= 169 && lines[2].contains(bigText[i]) && lines[1].length <= 80 && lines[0].length <= 149) {
            maxLines = 2;
            //log(("case 3.3"));
          }
        }
      }
      if (lines.length - 1 >= 4) {
        if (updateToggleTapDescription != null && section == Section.tagLine) {
          updateToggleTapDescription();
        } else if (setDescriptionState != null && section == Section.description) {
          setDescriptionState();
        }

        if (lines[3].length >= 100 && lines[3].length >= 169 && lines[2].length <= 100 && lines[1].length <= 80 && lines[0].length <= 149) {
          maxLines = 3;
          //log(("case 4"));
        } else if (lines[3].length <= 10 && lines[3].length >= 169 && lines[2].length <= 100 && lines[1].length <= 80 && lines[0].length <= 149) {
          //log(("case 4.2"));
          maxLines = 2;
        }
        for (int i = 0; i < bigText.length; i++) {
          if (lines[3].contains(bigText[i]) && lines[2].length <= 100 && lines[1].length <= 80 && lines[0].length <= 149) {
            //log(("case 4.3"));
            if ((lines[0].contains("<h1>") || lines[0].contains("<h2>")) &&
                lines[1].contains("<p>") &&
                lines[2].contains("<p>") &&
                (lines[3].contains("<h1>") || lines[3].contains("<h2>"))) {
              maxLines = 4;
            } else {
              maxLines = 2;
            }
          }
        }
      }
      // if (lines.length >= 5) {
      //   if(lines[4].length <= 10 && lines[3].length <= 100 && lines[2].length <= 100 && lines[1].length <= 80 && lines[0].length <= 149) {
      //     log("case 4.2");
      //     maxLines = 2;
      //   }
      // }
    }
    // process to count closest lines
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].length > 10) {
        lineFinal = lineFinal + 1;
      }
    }

    // process for substring. When the second line is found to be too long
    if (maxLines == 2) {
      for (int i = 0; i < lines.length; i++) {
        if (i == 0) {
          // Insert the first line into a variable.
          truncatedHtmlContent = [lines[0]].take(maxLines).join('\n');
          //log("maxLines 2 step 1");
        } else if (i == 1) {
          if (lines[1].length >= 170 && lines[0].length <= 149) {
            if (lineFinal == 2 && maxLines == 2) {
              lineFinal = 3;
              maxLines = 2;
            }
            // Merge the second line into the variable truncatedHtmlContent.
            if (lines[1].contains("<h1>") || lines[1].contains("<h2>")) {
              if (lines[0].contains("<h1>") || lines[0].contains("<h1>")) {
                truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[1].substring(0, 40)].take(maxLines).join('</'))}";
              } else {
                truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[1].substring(0, 70)].take(maxLines).join('</'))}";
              }

              //log("maxLines 2 step 2");
            } else {
              if (lines[1].length >= 220) {
                truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[1].substring(0, 220)].take(maxLines).join('</'))}";
                //log("maxLines 2 step 2");
              } else {
                lineFinal = 2;
                maxLines = 2;
                truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[1]].take(maxLines).join('</'))}";
                //log("maxLines 2 step 2");
              }
            }
          } else {
            if (lines[1].length <= 169 && lines[0].length <= 149) {
              // Merge the second line into the variable truncatedHtmlContent.
              if ((lines[0].contains("<h1>") || lines[0].contains("<h2>")) &&
                  lines[0].length >= 40 &&
                  lines[0].length <= 73 &&
                  (lines[1].contains("<h1>") || lines[1].contains("<h2>"))) {
                if (lineFinal == 2 && maxLines == 2) {
                  lineFinal = 3;
                  maxLines = 2;
                }
                //log("h1");
                truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[1].substring(0, 40)].take(maxLines).join('</'))}";
              } else if ((lines[0].contains("<h1>") || lines[0].contains("<h2>")) &&
                  lines[0].length <= 40 &&
                  (lines[1].contains("<h1>") || lines[1].contains("<h2>")) &&
                  lines[1].length >= 73) {
                if (lineFinal == 2 && maxLines == 2) {
                  lineFinal = 3;
                  maxLines = 2;
                }
                truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[1].substring(0, 73)].take(maxLines).join('</'))}";
              } else {
                truncatedHtmlContent =
                    "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[1].substring(0, lines[1].length.round())].take(maxLines).join('</'))}";
                //log("maxLines 2 step 2");
              }
            }
          }
        }
      }
      // process for substring. When the  line tree is found to be too long
    } else if (maxLines == 3 && lines[2].length >= 170 && lines[0].length <= 149 && lines[1].length <= 80) {
      //log("maxLines 3");
      for (int i = 0; i < lines.length; i++) {
        if (i == 0) {
          // Insert the first line into a variable.
          truncatedHtmlContent = fixIncompleteHtmlTags([lines[0]].take(maxLines).join('\n'));
          //log("maxLines 3 step 1");
        } else if (i == 1) {
          // Merge the second line into the variable truncatedHtmlContent.
          truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[1]].take(maxLines).join('\n'))}";
          //log("maxLines 3 step 2");
        } else if (i == 2) {
          if (lines[2].length >= 170 && lines[0].length <= 149 && lines[1].length <= 80) {
            // Merge the second line into the variable truncatedHtmlContent.
            // truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[2].substring(0, 90)].take(maxLines).join('</'))}";
            // log("maxLines 3 step 3");
            if (
                // (lines[0].contains("<h1>") || lines[0].contains("<h2>")) &&
                lines[0].length <= 40 &&
                    (lines[1].contains("<h1>") || lines[1].contains("<h2>")) &&
                    lines[1].length <= 43 &&
                    (lines[2].contains("<h1>") || lines[2].contains("<h2>")) &&
                    lines[2].length >= 40) {
              truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[2].substring(0, 40)].take(maxLines).join('</'))}";
              //log("maxLines 3 step 3 with out h1 in line 1(phh)");
            } else if (
                // (lines[0].contains("<h1>") || lines[0].contains("<h2>")) &&
                lines[0].length <= 40 &&
                    // (lines[1].contains("<h1>") || lines[1].contains("<h2>")) &&
                    lines[1].length <= 43 &&
                    (lines[2].contains("<h1>") || lines[2].contains("<h2>")) &&
                    lines[2].length >= 40) {
              truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[2].substring(0, 40)].take(maxLines).join('</'))}";
              //log("maxLines 3 step 3 with out h1 in line 1 and 2 (line 3 >= 40) (pph)");
            } else if ((lines[0].contains("<h1>") || lines[0].contains("<h2>")) &&
                lines[0].length <= 40 &&
                // (lines[1].contains("<h1>") || lines[1].contains("<h2>")) &&
                lines[1].length <= 43 &&
                (lines[2].contains("<h1>") || lines[2].contains("<h2>")) &&
                lines[2].length >= 40) {
              truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[2].substring(0, 40)].take(maxLines).join('</'))}";
              //log("maxLines 3 step 3 with out h1 in line 2 (hph)");
            } else if ((lines[0].contains("<h1>") || lines[0].contains("<h2>")) &&
                    lines[0].length <= 40 &&
                    // (lines[1].contains("<h1>") || lines[1].contains("<h2>")) &&
                    lines[1].length <= 43
                // (lines[2].contains("<h1>") || lines[2].contains("<h2>")) &&
                ) {
              if (lines[2].length >= 80) {
                truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[2].substring(0, 80)].take(maxLines).join('</'))}";
              } else {
                truncatedHtmlContent =
                    "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[2].substring(0, lines[2].length)].take(maxLines).join('</'))}";
              }
              //log("maxLines 3 step 3 with out h1 in line 2 and 3 >= 80 (hpp)");
            } else if (
                // (lines[0].contains("<h1>") || lines[0].contains("<h2>")) &&
                lines[0].length <= 40 && (lines[1].contains("<h1>") || lines[1].contains("<h2>")) && lines[1].length <= 43
                // (lines[2].contains("<h1>") || lines[2].contains("<h2>")) &&
                ) {
              if (lines[2].length >= 80) {
                truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[2].substring(0, 80)].take(maxLines).join('</'))}";
              } else {
                truncatedHtmlContent =
                    "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[2].substring(0, lines[2].length)].take(maxLines).join('</'))}";
              }

              //log("maxLines 3 step 3 with out h1 in line 2 and 3 >= 80 (php)");
            } else {
              truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[2].substring(0, 90)].take(maxLines).join('</'))}";
              //log("maxLines 3 step 3 all p");
            }
          }
        }
      }
    } else {
      // Merge the second line into the variable when all three lines are not too long.
      truncatedHtmlContent = fixIncompleteHtmlTags(lines.take(maxLines).join('</'));
    }
    if (maxLines == 3 && lines[2].length >= 170 && lines[0].length <= 149 && lines[1].length <= 80) {
      lineFinal = 4;
    }

    return [truncatedHtmlContent, maxLines, lineFinal];
  }
}
