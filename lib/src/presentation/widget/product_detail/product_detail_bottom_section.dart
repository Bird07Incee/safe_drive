import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_keys.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/utils/truncated_html_text.dart';

class PDBottomSection extends StatefulWidget {
  const PDBottomSection({super.key});

  @override
  State<PDBottomSection> createState() => _PDBottomSectionState();
}

class _PDBottomSectionState extends State<PDBottomSection> with TickerProviderStateMixin {
  late final TabController _tabController;
  String? remarkHtmlString;
  bool isPressedSpecReadMore = false;
  bool isPressedDescReadMore = false;
  bool isReadMoreSpecVisible = false;
  bool isReadMoreDescVisible = false;
  bool isBuildFinish = false;
  double descriptionHeight = 0;
  final GlobalKey _descriptionGetHeightKey = GlobalKey();
  String? truncatedHtmlContent;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getDescriptionHeight();
    });
    super.initState();
  }

  void _getDescriptionHeight() {
    final RenderBox renderBox = _descriptionGetHeightKey.currentContext!.findRenderObject() as RenderBox;
    if (renderBox.size.height != 0) {
      descriptionHeight = renderBox.size.height;
    }
  }

  checkProductDetailTab(Product product, Widget noDataFromSeller, Widget technicalSpecWidget, Widget technicalSpecHaveMoreWidget,
      Widget descriptionMaxWidget, Widget descriptionHaveReadMoreWidget) {
    switch (_tabController.index) {
      case 0:
        if (product.technicalSpec.isEmpty) {
          return noDataFromSeller;
        } else {
          if (isPressedSpecReadMore || product.technicalSpec.contains("<table")) {
            return technicalSpecWidget;
          } else {
            return technicalSpecHaveMoreWidget;
          }
        }
      case 1:
        if (product.description.isEmpty) {
          return noDataFromSeller;
        } else {
          if (isPressedDescReadMore || product.description.contains("<table")) {
            return descriptionMaxWidget;
          } else {
            return descriptionHaveReadMoreWidget;
          }
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        List<Widget> listRemark = [];
        Widget? textMerchantName;
        for (var text in state.product.remark) {
          textMerchantName = null;
          String mobileNo = "";
          String homeNo = "";
          if (text.contains(state.product.merchantFullName)) {
            var list = text.split(state.product.merchantFullName);
            String phone = state.product.merchantMobile;
            if (phone.replaceAll("-", "").length == 9) {
              text.replaceAllMapped(
                RegExp(r'(\d{2}-\d{3}-\d{4})'),
                (match) {
                  mobileNo = '${match.group(0)}';
                  text = text.replaceAll(mobileNo, "");
                  list.last = list.last.replaceAll(mobileNo, "");
                  return "";
                },
              );
            } else if (phone.replaceAll("-", "").length == 10) {
              text.replaceAllMapped(
                RegExp(r'(\d{3}-\d{3}-\d{4})'),
                (match) {
                  mobileNo = '${match.group(0)}';
                  text = text.replaceAll(mobileNo, "");
                  list.last = list.last.replaceAll(mobileNo, "");
                  return "";
                },
              );
            }
            textMerchantName = Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("  •  ", style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2.4)),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                        text: list.first,
                        style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2.4),
                      )),
                      Wrap(
                        children: [
                          Text(state.product.merchantFullName, style: AlvaStyles().headingSize12w600(spaceGrey).copyWith(height: 2.4)),
                          Text(list.last, style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2.4)),
                          GestureDetector(
                            onTap: () {
                              String phoneNumber = mobileNo.replaceAll("-", "");
                              callPhone(phoneNumber);
                            },
                            child: Text(mobileNo.isNotEmpty ? mobileNo : "", style: AlvaStyles().headingSize12w600(spaceGrey).copyWith(height: 2.4)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            text.replaceAllMapped(
              RegExp(r'(\d{2}-\d{3}-\d{4})'),
              (match) {
                homeNo = '${match.group(0)}';
                text = text.replaceAll(homeNo, "");
                listRemark.add(Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("  •  ", style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2.4)),
                    Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: text,
                              style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2.4),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              String phoneNumber = homeNo.replaceAll("-", "");
                              callPhone(phoneNumber);
                            },
                            child: Text(homeNo.isNotEmpty ? homeNo : "", style: AlvaStyles().headingSize12w600(spaceGrey).copyWith(height: 2.4)),
                          )
                        ],
                      ),
                    )
                  ],
                ));
                return "";
              },
            );
            if (homeNo.isNotEmpty) {
              continue;
            }
          }
          listRemark.add(Row(
            children: [
              Expanded(
                  child: textMerchantName ??
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  •  ",
                            style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2.4),
                          ),
                          Expanded(flex: 10, child: Text(text, style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2.4))),
                        ],
                      )),
            ],
          ));
        }

        final replaceInnerTagP = state.product.description.isNotEmpty
            ? state.product.description.substring(3, state.product.description.length - 4).replaceAll("<p>", "<br><br>").replaceAll("</p>", "")
            : "";
        var dataDescription = state.product.description.isNotEmpty ? "<p>$replaceInnerTagP<p/>" : "";
        dataDescription = dataDescription.replaceAll("<<", "<").replaceAll(">>", ">");

        return Stack(
          children: [
            Opacity(
              opacity: 0,
              child: HtmlWidget(
                dataDescription.isNotEmpty ? dataDescription : AppStrings().noDataFromSeller,
                key: _descriptionGetHeightKey,
                buildAsync: false,
                customStylesBuilder: (element) {
                  if (element.localName == "table") {
                    return {'width': '100%'};
                  }
                  if (element.localName == "td") {
                    return {
                      'width': '50%',
                      'font-family': "'Krungsri Condensed'",
                      'vertical-align': 'top;',
                      'padding-top': '8px;',
                      'padding-bottom': '8px;',
                      'font-size': '14px',
                      'line-height': '24px',
                      'color': '#2c2626'
                    };
                  }
                  if (element.localName == "th" || element.localName == "thead") {
                    return null;
                  }
                  if (element.localName == "p") {
                    return {
                      'font-family': "'Krungsri Condensed'",
                      'font-size': '14px',
                      'line-height': '24px',
                      'color': '#2c2626',
                    };
                  }
                  return {
                    'font-family': "'Krungsri Condensed'",
                    'font-size': '14px',
                    'line-height': '24px',
                    'color': '#2c2626',
                  };
                },
                customWidgetBuilder: (element) {
                  if (element.localName == "th" || element.localName == "thead") {
                    return SizedBox.shrink();
                  }
                  return null;
                },
                factoryBuilder: () => _MyFactory(title: AppStrings().productDetailProductDescription),
              ),
            ),
            Column(
              children: [
                buildProductDescriptionWidget(state.product),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: cloudWhite, // Replace with your color
                        width: 2.0, // Adjust the border width as needed
                      ),
                    ),
                  ),
                ),
                buildDetailCardWidget(context, state.product,
                    titleKey: AppKeys().productDetailAboutSellerTitleKey,
                    title: AppStrings().aboutSellerTitle,
                    bodyPage: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: AlvaText(title: state.product.merchantFullName, textStyle: AlvaStyles().headingSize14Height22()))
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: AlvaText(
                                    title: state.product.merchantAddress,
                                    textStyle: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 20 / 12)))
                          ],
                        ),
                      ],
                    )),
                Visibility(
                  visible: state.product.promotionTag.isNotEmpty,
                  child: Column(
                    children: [
                      Container(
                        height: 16,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: cloudWhite, // Replace with your color
                              width: 2.0, // Adjust the border width as needed
                            ),
                          ),
                        ),
                      ),
                      buildDetailCardWidget(context, state.product,
                          titleKey: AppKeys().productDetailPromotionDetailTitleKey,
                          title: AppStrings().promotionDetailTitle,
                          bodyPage: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.product.promotionTag.length > 3 ? 3 : state.product.promotionTag.length,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                      padding: EdgeInsets.only(top: index == 0 ? 0 : 8, bottom: 8),
                                      child: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.bookmark,
                                                size: 16,
                                                color: cloudSoftDeepWhite,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Flexible(
                                                  child: AlvaText(
                                                      title: state.product.promotionTag[index],
                                                      textStyle: AlvaStyles().headingSize12w500WithHeightFixed(spaceGrey)))
                                            ],
                                          )
                                        ],
                                      ));
                                })),
                          )),
                    ],
                  ),
                ),
                Visibility(
                  visible: state.product.remark.isNotEmpty,
                  child: Column(
                    children: [
                      Container(
                        height: 16,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: cloudWhite, // Replace with your color
                              width: 2.0, // Adjust the border width as needed
                            ),
                          ),
                        ),
                      ),
                      buildDetailCardWidget(context, state.product,
                          titleKey: AppKeys().productDetailRemarkTitleKey,
                          title: AppStrings().remarkTitle,
                          bodyPage: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: listRemark,
                            // remarkHtmlString ?? "",
                            // buildAsync: false,
                            // customStylesBuilder: (element) {
                            //   if (element.localName == 'b') {
                            //     return {'font-family': 'Krungsri Condensed', 'font-size': '12px', 'line-height': '24px', 'font-weight': 'Bold'};
                            //   }
                            //   return {'font-family': 'Krungsri Condensed', 'font-size': '12px', 'line-height': '24px'};
                            // },
                            // textStyle: TextStyle(fontWeight: FontWeight.w400),
                            // customWidgetBuilder: (element) {
                            // if (element.localName == 'b') {
                            //   String text = element.text;
                            //   return SizedBox(
                            //     child: OutlinedButton(
                            //       onPressed: () {
                            //         String phoneNumber = text.replaceAll("-", "");
                            //         callPhone(phoneNumber);
                            //       },
                            //       style: AlvaStyles().outlineButtonStyle(Colors.transparent, whitePure, 0),
                            //       child: Text(text, style: AlvaStyles().headingSize12w600(BTN_SELECTED_TEXT_COLOR_NEW)),
                            //     ),
                            //   );
                            // }
                            // },
                          )),
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void setDescriptionState(bool state) {
    if (_tabController.index == 0) {
      isReadMoreSpecVisible = state;
    } else if (_tabController.index == 1) {
      isReadMoreDescVisible = state;
    }
  }

  String findLineFinal(int? lineFinal, String truncatedHtmlContent, List<String> bigText) {
    if (truncatedHtmlContent.length >= 285) {
      truncatedHtmlContent = truncatedHtmlContent.substring(0, 285);
      lineFinal = 4;
      setDescriptionState(true);

      for (int i = 0; i < bigText.length; i++) {
        if (truncatedHtmlContent.contains(bigText[i])) {
          if (bigText[i] == "<h1>") {
            truncatedHtmlContent = truncatedHtmlContent.substring(0, 80);
          } else {
            truncatedHtmlContent = truncatedHtmlContent.substring(0, 210);
          }
        }
      }
    } else if (truncatedHtmlContent.length >= 150 && truncatedHtmlContent.length <= 284) {
      if (lineFinal != null) lineFinal = 3;
      for (int i = 0; i < bigText.length; i++) {
        if (truncatedHtmlContent.contains(bigText[i])) {
          if (bigText[i] == "<h1>") {
            truncatedHtmlContent = truncatedHtmlContent.substring(0, 80);
            setDescriptionState(true);
          } else {
            truncatedHtmlContent = truncatedHtmlContent.substring(0, 150);
            setDescriptionState(true);
          }
        }
      }
    } else {
      truncatedHtmlContent = truncatedHtmlContent.substring(0, truncatedHtmlContent.length);
    }
    return truncatedHtmlContent;
  }

  Widget buildProductDescriptionWidget(Product product) {
    return Container(
        decoration: BoxDecoration(
          color: whitePure,
        ),
        child: StatefulBuilder(builder: (context, setState) {
          var originalDescription = product.description;
          var originalSpec = product.technicalSpec;
          var data = "";

          if (_tabController.index == 0) {
            data = originalSpec.isNotEmpty
                ? originalSpec.contains("<table")
                    ? originalSpec
                    : !originalSpec.contains("<p>")
                        ? "<p>$originalSpec</p>"
                        : originalSpec
                : "";
          } else if (_tabController.index == 1) {
            data = originalDescription.isNotEmpty
                ? originalDescription.contains("<table")
                    ? originalDescription
                    : !originalDescription.contains("<p>")
                        ? "<p>$originalDescription</p>"
                        : originalDescription
                : "";
          }

          // originalDescription = """<a id="test_photo_1"></a>![ดด](<img src="%E0%B8%81%E0%B8%81" alt="test photo" />""";
          // var dataDescription = originalDescription.isNotEmpty ? originalDescription.replaceAll("<p>", "").replaceAll("</p>", "") : "";

          data = data.replaceAll("<<", "<").replaceAll(">>", ">");

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
          data = truncatedHtmlText.decodeHtmlEntities(data);
          data = data.replaceAll(emojiRegex, "");

          String? truncatedHtmlContent;
          int maxLines = 4;
          List<String> lines;
          int lineFinal = 0;
          String? textString;
          List<String> bigText = ['<h1>', '<h2>'];
          // check empty html string input

          if (data != "") {
            data = data.replaceAll("<br >", "<br>");
            data = data.replaceAll("<br />", "<br/>");
            data = truncatedHtmlText.removeHtmlForbiddenTagsTags(data);
            // dataDescription = removeInvalidWords(dataDescription);
            // check html tag in string input
            if (!truncatedHtmlText.containsHtmlTags(data)) {
              // insert <p> in title or first line
              data = truncatedHtmlText.insertPTag(data);
              // check expended content
              if (data.length >= 291) {
                // cut content string show 100 char
                setDescriptionState(true);

                textString = data.substring(0, 290);
                //set toggleDescription

                // myBloc.updateToggleTapDescription(toggleDescription: false);
                //set maxLines lineFinal for lineFinal<=maxLines
                maxLines = 1;
                lineFinal = 2;
                // check html tag in textString
                if (truncatedHtmlText.containsHtmlTags(textString)) {
                  // set truncatedHtmlContent in textString
                  setDescriptionState(false);

                  truncatedHtmlContent = textString;
                }
                // Verify that the data in characters does not exceed a line but is <br>Many items beyond the line.
              } else if (data.length <= 169 && truncatedHtmlText.countBrTags(data) >= 3) {
                // cut content string show characters to delete (20% of total characters)
                textString = truncatedHtmlText.deleteCharacters(data);
                //set toggleDescription
                setDescriptionState(true);

                // myBloc.updateToggleTapDescription(toggleDescription: false);
                //set maxLines lineFinal for lineFinal<=maxLines
                maxLines = 1;
                lineFinal = 2;
                // check html tag in textString
                if (truncatedHtmlText.containsHtmlTags(textString)) {
                  // set truncatedHtmlContent in textString
                  truncatedHtmlContent = textString;
                }
              } else {
                // set toggleDescription adn textNotMoreThan When text does not exceed a line
                setDescriptionState(false);
              }
              //  This string does not contain any html tags.
            } else {
              // This string contains html tags.
              // List of tags that you want to delete the entire line of tags and do not want to show
              data = truncatedHtmlText.removeTags(data, ['img', 'nav']);

              // logic for replacing variables for replacements
              for (var replacement in ProductDetailConst().replacements) {
                replacement.forEach((key, value) {
                  data = data.replaceAll(key, value);
                });
              }
              // refactor html content to one line, example, <p>text</p><p>text</p
              data = truncatedHtmlText.refactorHtml(data);
              // Delete/unnecessary from content
              data = data.replaceAll(' /', "");
              // Separate the dataDescription variable one line at a time by separating it from </,<br> and put it in lines.

              lines = data.split('</').expand((s) => s.split('<br>')).toList();

              // The process of counting lines and checking how many characters each line has and maxLine should be set.
              setDescriptionState(false);
              List<dynamic> truncatedHtmlTextResponse = truncatedHtmlText
                  .truncatedHtmlContentBlock(lines, bigText, maxLines, lineFinal, truncatedHtmlContent ?? "", Section.description, null, () {
                setDescriptionState(true);
              });
              truncatedHtmlContent = truncatedHtmlTextResponse[0];
              maxLines = truncatedHtmlTextResponse[1];
              lineFinal = truncatedHtmlTextResponse[2];

              if (maxLines == 1 || maxLines == 2 || maxLines == 3) {
                truncatedHtmlContent = findLineFinal(null, truncatedHtmlContent ?? "", bigText);
              } else {
                truncatedHtmlContent = findLineFinal(3, truncatedHtmlContent ?? "", bigText);
              }
            }
          }

          truncatedHtmlContent ??= "";
          if (!truncatedHtmlContent.startsWith("<p>") || !truncatedHtmlContent.endsWith("</p>")) {
            truncatedHtmlContent = "<p>$truncatedHtmlContent</p>";
          }
          if (!data.startsWith("<p>") || !data.endsWith("</p>")) {
            data = "<p>$data</p>";
          }
          if (data.contains("<table")) {
            data = truncatedHtmlText.minifyHtml(data);
          }

          int count = 0;

          Widget noDataFromSeller = Container(
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Text(
              AppStrings().noDataFromSeller,
              style: AlvaStyles().headingSize14RegHeight22(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 2.4),
            ),
          );

          Widget technicalSpecMaxWidget = HtmlWidget(data.isNotEmpty ? data : AppStrings().noDataFromSeller,
              buildAsync: false,
              textStyle: AlvaStyles().headingSize14w400(blackGoMunTo).copyWith(height: 22 / 14),
              customStylesBuilder: (element) {
                if (element.localName == "table") {
                  return {'width': '100%'};
                }
                if (element.localName == "td") {
                  count += 1;
                  if (count.isOdd) {
                    return {
                      'font-family': "'Krungsri Condensed'",
                      'width': '50%',
                      'vertical-align': 'top;',
                      'font-size': '14px',
                      'line-height': '22px',
                      'font-weight': '400',
                      'color': '#858282'
                    };
                  } else {
                    return {
                      'font-family': "'Krungsri Condensed'",
                      'width': '50%',
                      'vertical-align': 'top;',
                      'font-size': '14px',
                      'line-height': '22px',
                      'font-weight': '400',
                      'color': '#292828'
                    };
                  }
                }
                if (element.localName == "th" || element.localName == "thead") {
                  return null;
                }
                if (element.localName == "p") {
                  return {
                    'font-family': "'Krungsri Condensed'",
                    'font-size': '14px',
                    'line-height': '22px',
                    'font-weight': '400',
                    'color': '#2c2626',
                  };
                }
                if (element.localName == "b") {
                  return {
                    'font-family': "'Krungsri Condensed'",
                    'font-size': '14px',
                    'line-height': '22px',
                    'font-weight': '600',
                    'color': '#2c2626',
                  };
                }
                return {
                  'font-family': "'Krungsri Condensed'",
                  'font-size': '14px',
                  'line-height': '22px',
                  'color': '#2c2626',
                };
              },
              customWidgetBuilder: (element) {
                if (element.localName == "th" || element.localName == "thead") {
                  return SizedBox.shrink();
                }
                return null;
              },
              factoryBuilder: () => _MyFactory(title: AppStrings().productDetailProductDescription),
              onErrorBuilder: (context, el, e) {
                return noDataFromSeller;
              });

          Widget technicalSpecHaveReadMoreWidget = HtmlWidget(
              data.contains("<table")
                  ? data.trim()
                  : truncatedHtmlContent.isNotEmpty
                      ? isReadMoreSpecVisible
                          ? "$truncatedHtmlContent..."
                          : truncatedHtmlContent
                      : AppStrings().noDataFromSeller,
              buildAsync: false,
              textStyle: AlvaStyles().headingSize14w400(blackGoMunTo).copyWith(height: 22 / 14),
              customStylesBuilder: (element) {
                if (element.localName == "table") {
                  return {'width': '100%'};
                }
                if (element.localName == "td") {
                  count += 1;
                  if (count.isOdd) {
                    return {
                      'font-family': "'Krungsri Condensed'",
                      'width': '50%',
                      'vertical-align': 'top;',
                      'font-size': '14px',
                      'line-height': '22px',
                      'font-weight': '400',
                      'color': '#858282'
                    };
                  } else {
                    return {
                      'font-family': "'Krungsri Condensed'",
                      'width': '50%',
                      'vertical-align': 'top;',
                      'font-size': '14px',
                      'line-height': '22px',
                      'font-weight': '400',
                      'color': '#292828'
                    };
                  }
                }
                if (element.localName == "th" || element.localName == "thead") {
                  return null;
                }
                if (element.localName == "p") {
                  return {
                    'font-family': "'Krungsri Condensed'",
                    'font-size': '14px',
                    'line-height': '22px',
                    'font-weight': '400',
                    'color': '#2c2626',
                  };
                }
                if (element.localName == "b") {
                  return {
                    'font-family': "'Krungsri Condensed'",
                    'font-size': '14px',
                    'line-height': '22px',
                    'font-weight': '600',
                    'color': '#2c2626',
                  };
                }
                return {
                  'font-family': "'Krungsri Condensed'",
                  'font-size': '14px',
                  'line-height': '22px',
                  'color': '#2c2626',
                };
              },
              customWidgetBuilder: (element) {
                if (element.localName == "th" || element.localName == "thead") {
                  return SizedBox.shrink();
                }
                return null;
              },
              factoryBuilder: () => _MyFactory(title: AppStrings().productDetailProductDescription),
              onErrorBuilder: (context, el, e) {
                return noDataFromSeller;
              });

          Widget descriptionMaxWidget = SizedBox(
            child: HtmlWidget(
              data.isNotEmpty ? data : AppStrings().noDataFromSeller,
              buildAsync: false,
              textStyle: AlvaStyles().headingSize14w400(blackGoMunTo).copyWith(height: 22 / 14),
              customStylesBuilder: (element) {
                if (element.localName == "table") {
                  return {'width': '100%'};
                }
                if (element.localName == "td") {
                  // return {
                  //   'width': '50%',
                  //   'vertical-align': 'top;',
                  //   'font-family': "'Krungsri Condensed'",
                  //   'font-size': '14px',
                  //   'line-height': '22px',
                  //   'font-weight': '400',
                  //   'color': '#2c2626'
                  // };
                  count += 1;
                  if (count.isOdd) {
                    return {
                      'font-family': "'Krungsri Condensed'",
                      'width': '50%',
                      'vertical-align': 'top;',
                      'font-size': '14px',
                      'line-height': '22px',
                      'font-weight': '400',
                      'color': '#858282'
                    };
                  } else {
                    return {
                      'font-family': "'Krungsri Condensed'",
                      'width': '50%',
                      'vertical-align': 'top;',
                      'font-size': '14px',
                      'line-height': '22px',
                      'font-weight': '400',
                      'color': '#292828'
                    };
                  }
                }
                if (element.localName == "th" || element.localName == "thead") {
                  return null;
                }
                if (element.localName == "p") {
                  return {
                    'font-family': "'Krungsri Condensed'",
                    'font-size': '14px',
                    'line-height': '22px',
                    'font-weight': '400',
                    'color': '#2c2626',
                  };
                }
                if (element.localName == "b") {
                  return {
                    'font-family': "'Krungsri Condensed'",
                    'font-size': '14px',
                    'line-height': '22px',
                    'font-weight': '600',
                    'color': '#2c2626',
                  };
                }
                return {
                  'font-family': "'Krungsri Condensed'",
                  'font-size': '14px',
                  'line-height': '22px',
                  'color': '#2c2626',
                };
              },
              customWidgetBuilder: (element) {
                if (element.localName == "th" || element.localName == "thead") {
                  return SizedBox.shrink();
                }
                return null;
              },
              factoryBuilder: () => _MyFactory(title: AppStrings().productDetailProductDescription),
              onErrorBuilder: (context, el, e) {
                return noDataFromSeller;
              },
            ),
          );

          Widget descriptionHaveReadMoreWidget = SizedBox(
              child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: HtmlWidget(
                    data.contains("<table")
                        ? data
                        : truncatedHtmlContent.isNotEmpty
                            ? isReadMoreDescVisible
                                ? "$truncatedHtmlContent..."
                                : truncatedHtmlContent
                            : AppStrings().noDataFromSeller,
                    buildAsync: false,
                    textStyle: AlvaStyles().headingSize14w400(blackGoMunTo).copyWith(height: 22 / 14),
                    customStylesBuilder: (element) {
                      if (element.localName == "table") {
                        return {'width': '100%'};
                      }
                      if (element.localName == "td") {
                        // return {
                        //   'width': '50%',
                        //   'vertical-align': 'top;',
                        //   'font-family': "'Krungsri Condensed'",
                        //   'font-size': '14px',
                        //   'line-height': '22px',
                        //   'font-weight': '400',
                        //   'color': '#2c2626'
                        // };
                        count += 1;
                        if (count.isOdd) {
                          return {
                            'font-family': "'Krungsri Condensed'",
                            'width': '50%',
                            'vertical-align': 'top;',
                            'font-size': '14px',
                            'line-height': '22px',
                            'font-weight': '400',
                            'color': '#858282'
                          };
                        } else {
                          return {
                            'font-family': "'Krungsri Condensed'",
                            'width': '50%',
                            'vertical-align': 'top;',
                            'font-size': '14px',
                            'line-height': '22px',
                            'font-weight': '400',
                            'color': '#292828'
                          };
                        }
                      }
                      if (element.localName == "th" || element.localName == "thead") {
                        return null;
                      }
                      if (element.localName == "p") {
                        return {
                          'font-family': "'Krungsri Condensed'",
                          'font-size': '14px',
                          'line-height': '22px',
                          'font-weight': '400',
                          'color': '#2c2626',
                        };
                      }
                      if (element.localName == "b") {
                        return {
                          'font-family': "'Krungsri Condensed'",
                          'font-size': '14px',
                          'line-height': '22px',
                          'font-weight': '600',
                          'color': '#2c2626',
                        };
                      }
                      return {
                        'font-family': "'Krungsri Condensed'",
                        'font-size': '14px',
                        'line-height': '22px',
                        'color': '#2c2626',
                      };
                    },
                    customWidgetBuilder: (element) {
                      if (element.localName == "th" || element.localName == "thead") {
                        return SizedBox.shrink();
                      }
                      return null;
                    },
                    factoryBuilder: () => _MyFactory(title: AppStrings().productDetailProductDescription),
                    onErrorBuilder: (context, el, e) {
                      return noDataFromSeller;
                    },
                  )));

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: AlvaText(
                    key: AppKeys().productDetailProductDescriptionKey,
                    title: AppStrings().productDetailProductDescription,
                    textStyle: AlvaStyles().headingSize16w500(BTN_SELECTED_TEXT_COLOR_NEW),
                  ),
                ),
              ),
              Stack(fit: StackFit.passthrough, alignment: Alignment.bottomCenter, children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: neutral100, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TabBar(
                      controller: _tabController,
                      labelColor: BTN_SELECTED_TEXT_COLOR_NEW,
                      indicatorColor: mintGreen,
                      unselectedLabelColor: whiteGray,
                      //  unselectedLabelColor: cloudSoftDeepWhite,
                      labelStyle: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        height: 22 / 14,
                        fontWeight: FontWeight.w700,
                      ),
                      onTap: (int index) {
                        setState(() {});
                        if (index == 0) {
                          AmplitudeWebHelper.getInstance().logTapOnGeneralInfoButton(
                              productName: product.productName, contentId: product.productId, merchantName: product.merchantFullName);
                        } else {
                          AmplitudeWebHelper.getInstance().logTapOnConditionsButton(
                              productName: product.productName, contentId: product.productId, merchantName: product.merchantFullName);
                        }
                      },
                      tabs: [
                        Tab(
                          key: AppKeys().productDetailGeneralDetailTabKey,
                          text: AppStrings().generalDetail,
                        ),
                        Tab(key: AppKeys().productDetailEtcDetailTabKey, text: AppStrings().etcDetail),
                      ]),
                )
              ]),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                key: const Key("read_more_product_detail"),
                onHorizontalDragEnd: (details) async {
                  if (_tabController.index == 0) {
                    if (details.primaryVelocity! < 0) {
                      _tabController.animateTo(1, duration: const Duration(milliseconds: 300));
                      setState(() {});
                    }
                  } else {
                    if (details.primaryVelocity! > 0) {
                      _tabController.animateTo(0, duration: const Duration(milliseconds: 300));
                      setState(() {});
                    }
                  }
                },
                child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: checkProductDetailTab(product, noDataFromSeller, technicalSpecMaxWidget, technicalSpecHaveReadMoreWidget,
                        descriptionMaxWidget, descriptionHaveReadMoreWidget)),
              ),
              truncatedHtmlContent.isNotEmpty
                  ? Container(
                      padding: truncatedHtmlContent.length > 150 ? null : EdgeInsets.only(top: 0),
                      child: Visibility(
                          visible: (_tabController.index == 0 && isReadMoreSpecVisible && !data.contains("<table")) ||
                              (_tabController.index == 1 && isReadMoreDescVisible && !data.contains("<table")),
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      height: 24,
                                      child: OutlinedButton(
                                          onPressed: () async {
                                            setState(() {
                                              if (_tabController.index == 0) {
                                                isPressedSpecReadMore = !isPressedSpecReadMore;
                                              } else if (_tabController.index == 1) {
                                                isPressedDescReadMore = !isPressedDescReadMore;
                                              }
                                            });
                                          },
                                          style: AlvaStyles().outlineNoneBorderButtonStyle(Colors.transparent, BlueFantasy),
                                          child: _tabController.index == 0
                                              ? AlvaText(
                                                  title: _tabController.index == 0
                                                      ? isPressedSpecReadMore
                                                          ? AppStrings().btnHideDescription
                                                          : AppStrings().btnReadMore
                                                      : isPressedDescReadMore
                                                          ? AppStrings().btnHideDescription //||isPressedInfoReadMore
                                                          : AppStrings().btnReadMore,
                                                  textStyle: AlvaStyles().headingSize14Height24(BlueFantasy),
                                                  // AlvaStyles().headingSize14Height24(BlueFantasy),
                                                  disableSelectableText: true,
                                                )
                                              : AlvaText(
                                                  title: _tabController.index == 1
                                                      ? isPressedDescReadMore
                                                          ? AppStrings().btnHideDescription
                                                          : AppStrings().btnReadMore
                                                      : isPressedSpecReadMore
                                                          ? AppStrings().btnHideDescription //||isPressedInfoReadMore
                                                          : AppStrings().btnReadMore,
                                                  textStyle: AlvaStyles().headingSize14Height24(BlueFantasy),
                                                  disableSelectableText: true,
                                                )),
                                    ),
                                  )
                                ],
                              ))))
                  : Container()
            ],
          );
        }));
  }

  Widget buildDetailCardWidget(BuildContext context, Product product, {Key? titleKey, String? title, Widget? bodyPage}) {
    return Container(
        decoration: BoxDecoration(
          color: whitePure,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: AlvaText(
                  key: titleKey!,
                  title: title!,
                  textStyle: AlvaStyles().headingSize16w500(BTN_SELECTED_TEXT_COLOR_NEW),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: bodyPage),
            title == AppStrings().aboutSellerTitle
                ? Column(
                    children: [
                      SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () async {
                            AmplitudeWebHelper.getInstance().logTapOnCallMerchantButton(
                                productName: product.productName, contentId: product.productId, merchantName: product.merchantFullName);
                            String mobile = product.merchantMobile.replaceAll('-', '');
                            callPhone(mobile);
                          },
                          style: AlvaStyles().outlineButtonStyle(
                              side: const BorderSide(
                                color: YellowKrungsri,
                                width: 2,
                              ),
                              Colors.transparent,
                              Colors.transparent,
                              8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.phone_in_talk_sharp,
                                color: BTN_SELECTED_TEXT_COLOR_NEW,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text("ติดต่อ ${product.merchantMobile}", style: AlvaStyles().heading2(BTN_SELECTED_TEXT_COLOR_NEW)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 16,
            ),
          ],
        ));
  }
}

class _MyFactory extends WidgetFactory {
  _MyFactory({this.title = ""});

  String title;

  @override
  void parse(BuildTree meta) {
    final e = meta.element;
    if (title == AppStrings().productDetailProductDescription) {
      if (e.localName == 'tr') {
        for (int i = 0; i < e.nodes.length; i++) {
          if (i == 0) {
            meta.element.nodes[i].nodes[0].attributes = {
              "style":
                  "color:#5a5a5a; font-size:14px; font-family:'Krungsri Condensed'; line-height:22px; font-weight: 400;", //padding-top: 8px; padding-bottom: 8px;
            } as LinkedHashMap<Object, String>;
          } else {
            meta.element.nodes[i].nodes[0].attributes = {
              "style": "color:#2c2626;  font-size:14px; font-family:'Krungsri Condensed'; line-height:22px; font-weight: 400;",
            } as LinkedHashMap<Object, String>;
          }
        }
        return;
      }
    }

    return super.parse(meta);
  }
}
