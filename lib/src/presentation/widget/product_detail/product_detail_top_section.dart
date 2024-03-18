import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/custom_tap_down_details.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/produc_detail_tagline_toggle/product_detail_description_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PDTopSection extends StatefulWidget {
  const PDTopSection({super.key});

  @override
  State<PDTopSection> createState() => _PDTopSectionState();
}

class _PDTopSectionState extends State<PDTopSection> {
  Widget promos(Product p) {
    List<InlineSpan> l = [];
    int len = p.promotionTag.length > 3 ? 3 : p.promotionTag.length;
    for (var i = 0; i < len; i++) {
      l.add(TextSpan(text: p.promotionTag[i], style: AlvaStyles().headingSize12w400(spaceGrey)));
      if (i != len - 1) {
        l.add(WidgetSpan(
          child: Container(
            width: 1,
            height: 16,
            margin: EdgeInsets.only(left: 6, right: 6),
            color: cloudSoftDeepWhite,
          ),
        ));
      }
    }
    return RichText(
      text: TextSpan(children: l),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myBloc = BlocProvider.of<ProductDetailDescriptionCubit>(context);
    double maxWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        final replaceInnerTagP = state.product.tagline.isNotEmpty ? state.product.tagline : "";
        var tagline = state.product.tagline.isNotEmpty ? replaceInnerTagP : "";
        // print("tagline ${state.product.tagline}");
        // {"<br >": "<br>", "<br />": "<br/>"},
        // -----------process for unSupport emoji,icon in text-------------------
        RegExp emojiRegex = RegExp(
          r"[\u{1F600}-\u{1F64F}" // Emoticons
          r"\u{1F300}-\u{1F5FF}" // Symbols & Pictographs
          r"\u{1F680}-\u{1F6FF}" // Transport & Map Symbols
          r"\u{1F700}-\u{1F77F}" // Alphanumeric Supplement
          r"\u{1F780}-\u{1F7FF}" // Geometric Shapes Extended
          r"\u{1F800}-\u{1F8FF}" // Supplemental Arrows-C
          r"\u{1F900}-\u{1F9FF}" // Supplemental Symbols and Pictographs
          r"\u{1FA00}-\u{1FA6F}" // Chess Symbols
          r"\u{1FA70}-\u{1FAFF}" // Symbols and Pictographs Extended-A
          r"\u{2702}-\u{27B0}" // Dingbat
          r"]+",
          unicode: true,
        );
        tagline = tagline.replaceAll(emojiRegex, "");
        // -----------process for unSupport emoji,icon in text-------------------
        String? truncatedHtmlContent;
        int maxLines = 4;
        List<String> lines;
        int lineFinal = 0;
        String? textString;
        List<String> bigText = ['<h1>', '<h2>'];

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

        // check empty html string input

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
          // print("taglinenamo ${tagline}");
          // check html tag in string input
          if (!containsHtmlTags(tagline)) {
            // print("not containsHtmlTags");
            // insert <p> in title or first line
            tagline = insertPTag(tagline);
            // check expended content
            if (tagline.length >= 291) {
              // cut content string show 100 char
              textString = tagline.substring(0, 290);
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
            tagline = removeTags(tagline, ['table', 'th', 'tr', 'td', 'img', 'nav']);

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
                if (lines[3].length >= 100 && lines[3].length >= 169 && lines[2].length <= 100 && lines[1].length <= 80 && lines[0].length <= 149) {
                  maxLines = 3;
                  //log(("case 4"));
                } else if (lines[3].length <= 10 &&
                    lines[3].length >= 169 &&
                    lines[2].length <= 100 &&
                    lines[1].length <= 80 &&
                    lines[0].length <= 149) {
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
                        truncatedHtmlContent =
                            "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[1].substring(0, 220)].take(maxLines).join('</'))}";
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
                      //log("(${(lines[0].contains("<h1>") || lines[0].contains("<h2>"))})");
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
                        //log("h1");
                        truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([lines[1].substring(0, 73)].take(maxLines).join('</'))}";
                      } else {
                        truncatedHtmlContent = "$truncatedHtmlContent${fixIncompleteHtmlTags([
                          lines[1].substring(0, (lines[1].length * 0.9).round())
                        ].take(maxLines).join('</'))}";
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
                  truncatedHtmlContent = [lines[0]].take(maxLines).join('\n');
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
              truncatedHtmlContent = lines.take(maxLines).join('</');
            }
            if (maxLines == 3 && lines[2].length >= 170 && lines[0].length <= 149 && lines[1].length <= 80) {
              lineFinal = 4;
            }
            if (maxLines == 1) {
              if (truncatedHtmlContent!.length >= 285) {
                truncatedHtmlContent = truncatedHtmlContent.substring(0, 285);
                lineFinal = 4;
                for (int i = 0; i < bigText.length; i++) {
                  if (truncatedHtmlContent!.contains(bigText[i])) {
                    if (bigText[i] == "<h1>") {
                      truncatedHtmlContent = truncatedHtmlContent.substring(0, 80);
                    } else {
                      truncatedHtmlContent = truncatedHtmlContent.substring(0, 100);
                    }
                  }
                }
              } else if (truncatedHtmlContent.length >= 100 && truncatedHtmlContent.length <= 284) {
                for (int i = 0; i < bigText.length; i++) {
                  if (truncatedHtmlContent!.contains(bigText[i])) {
                    if (bigText[i] == "<h1>") {
                      truncatedHtmlContent = truncatedHtmlContent.substring(0, 80);
                    } else {
                      truncatedHtmlContent = truncatedHtmlContent.substring(0, 100);
                    }
                  }
                }
              } else {
                truncatedHtmlContent = truncatedHtmlContent.substring(0, truncatedHtmlContent.length);
              }
            }
          }
        }
        // print("${tagline}");
        // print("truncatedHtmlContent ${truncatedHtmlContent}");
        // print(
        //     "(lineFinal(${lineFinal}) <= maxLines(${maxLines}) && containsHtmlTags(tagline)(${containsHtmlTags(tagline)})) == ${(lineFinal <= maxLines && containsHtmlTags(tagline))}");
        return BlocBuilder<ImgGalleryZoomBloc, TransformationController>(
          builder: (context, zoomarguments) {
            return BlocBuilder<ProductDetailCarouselScrollControllerBloc, PageController>(
              builder: (context, carouselarguments) {
                return Container(
                  decoration: BoxDecoration(
                    color: whitePure,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 16.0 / 9.0,
                            child: PageView.builder(
                                itemCount: state.product.productionAssets.length == 1
                                    ? state.product.productionAssets.length
                                    : state.product.productionAssets.length + 1,
                                controller: carouselarguments,
                                onPageChanged: (val) {
                                  context.read<ProductDetailCarouselScrollControllerBloc>().add(CarouselScrollAction(index: val));
                                  if (val == state.product.productionAssets.length && val != 1) {
                                    carouselarguments.jumpToPage(0);
                                  }
                                },
                                itemBuilder: (ctx, i) {
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        key: const Key("image_slide_action"),
                                        onTap: () {
                                          context.read<ViewImgDetailPageSwitchBloc>().add(SwitchPageAction(statePage: true));
                                          context
                                              .read<ProductDetailCarouselScrollControllerBloc>()
                                              .add(CarouselScrollAction(index: carouselarguments.initialPage));
                                          context.read<PreviousScaleBloc>().add(const PreviousScaleEvent(previousScale: 0.5));
                                          if (zoomarguments.value != Matrix4.identity()) {
                                            context
                                                .read<ImgGalleryZoomBloc>()
                                                .add(ZoomImageAction(details: customTapDownDetails(const Offset(100, 100))));
                                          }
                                        },
                                        child: AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: SizedBox(
                                            width: maxWidth,
                                            height: 576,
                                            child: FadeInImage(
                                              placeholder: const AssetImage('assets/homepage/img_default.png'),
                                              // Replace with your placeholder image path
                                              image: NetworkImage(
                                                i == state.product.productionAssets.length
                                                    ? state.product.productionAssets[0]
                                                    : state.product.productionAssets[i],
                                              ),
                                              fit: BoxFit.fitWidth,
                                              imageErrorBuilder: (context, error, stackTrace) =>
                                                  Image.asset('assets/homepage/img_default.png', fit: BoxFit.fitWidth),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          Visibility(
                            visible: state.product.productionAssets.length > 1,
                            child: Positioned.fill(
                                child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                                width: 41,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: cloudyWhite.withOpacity(0.8),
                                ),
                                child: Center(
                                  child: AlvaText(
                                      title: "${carouselarguments.initialPage + 1}/${state.product.productionAssets.length}",
                                      textStyle: AlvaStyles().headingSize10w500(BTN_SELECTED_TEXT_COLOR_NEW)),
                                ),
                              ),
                            )),
                          ),
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.bottomRight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                child: Image.network(
                                  state.product.merchantLogo,
                                  height: 32,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                                ),
                              ),
                            ),
                          )),
                          Visibility(
                            visible: state.product.percentDiscountPrice != 0 && state.product.productionOptionals.isEmpty,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              decoration: const BoxDecoration(color: BlueFantasy, borderRadius: BorderRadius.only(bottomRight: Radius.circular(8))),
                              child: AlvaText(
                                title: "ถูกลง ${state.product.percentDiscountPrice} %",
                                textStyle: AlvaStyles().headingSize12w600(Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        color: whitePure,
                        width: maxWidth,
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: state.product.productionAssets.length == 1 ? false : true,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: SmoothPageIndicator(
                                    controller: carouselarguments,
                                    count: state.product.productionAssets.length <= carouselShowLimit
                                        ? state.product.productionAssets.length
                                        : carouselShowLimit,
                                    effect: const ExpandingDotsEffect(
                                      expansionFactor: 2,
                                      dotHeight: 6,
                                      dotWidth: 6,
                                      activeDotColor: BlueFantasy,
                                      dotColor: cloudSoftDeepWhite,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AlvaText(
                              title: state.product.productName,
                              textStyle: AlvaStyles().headingSize22w700(BTN_SELECTED_TEXT_COLOR_NEW),
                            ),
                            state.product.promotionTag.isEmpty ? SizedBox() : promos(state.product),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: maxWidth - 32,
                              height: 1,
                              color: cloudWhite,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            BlocBuilder<ProductDetailDescriptionCubit, ProductDetailDescriptionCubitState>(
                              builder: (context, descriptionState) {
                                return GestureDetector(
                                  onTap: () {
                                    if (!descriptionState.textNotMoreThan) {
                                      if (descriptionState.toggleDescription) {
                                        myBloc.updateToggleTapDescription(toggleDescription: false);
                                      } else {
                                        myBloc.updateToggleTapDescription(toggleDescription: true);
                                      }
                                    }
                                  },
                                  child: HtmlWidget(
                                      descriptionState.toggleDescription || (lineFinal <= maxLines && containsHtmlTags(tagline))
                                          ? "$tagline${lineFinal <= maxLines ? "" : " <p1>ซ่อนรายละเอียด<p1> "}"
                                          : !containsHtmlTags(tagline)
                                              ? tagline != ""
                                                  ? "${textString!}...<p1>อ่านต่อ</p1>"
                                                  : ""
                                              : "$truncatedHtmlContent...${"<p1>อ่านต่อ</p1>"}",
                                      buildAsync: false,
                                      textStyle: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 20 / 12), customStylesBuilder: (element) {
                                    if (element.attributes['style'] != null && element.attributes['style'].toString().contains('color')) {
                                      if (element.attributes['style'].toString().contains('9c9c9c')) {
                                        element.attributes['style'] = 'color:#9c9c9c';
                                      } else {
                                        element.attributes['style'] = 'color:#6699ff';
                                      }
                                    } else {
                                      element.attributes['style'] = '';
                                    }
                                    if (element.localName == "p1") {
                                      return {
                                        'color': "#40A9FC",
                                        'font-weight': 'bold',
                                        'font-family': 'Krungsri Condensed',
                                        'font-size': '12px',
                                        'line-height': '20px',
                                      };
                                    }
                                    if (element.localName == "table") {
                                      return {'width': '100%'};
                                    } else if (element.localName == "td") {
                                      return {'width': '50%'};
                                    }

                                    return null;
                                  }),
                                );
                              },
                            ),
                            Visibility(
                              visible: state.product.discountPrice != 0 && state.product.productionOptionals.isEmpty,
                              child: Row(
                                children: [
                                  AlvaText(
                                    title: state.product.price.toDecimalFormat(),
                                    textStyle: AlvaStyles().discountPriceTxt14w400(smockGrey).copyWith(height: 1.714),
                                  ),
                                  AlvaText(
                                    title: ' บาท',
                                    textStyle: AlvaStyles().bodySize14w400(smockGrey).copyWith(height: 1.714),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AlvaText(
                                  title: state.product.discountPrice == 0
                                      ? state.product.price.toDecimalFormat()
                                      : state.product.discountPrice.toDecimalFormat(),
                                  textStyle: AlvaStyles()
                                      .headingSize22w700(state.product.discountPrice == 0 ? BTN_SELECTED_TEXT_COLOR_NEW : RedWordShow)
                                      .copyWith(height: 1.454),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 2, top: tagline != "" ? 16 : 1),
                                  child: AlvaText(
                                    title: ' บาท',
                                    textStyle: AlvaStyles()
                                        .headingSize18w700(state.product.discountPrice == 0 ? BTN_SELECTED_TEXT_COLOR_NEW : RedWordShow)
                                        .copyWith(height: 1.454),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
