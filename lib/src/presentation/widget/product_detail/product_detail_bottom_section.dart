import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_keys.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/product_detail/product_detail_args.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';

class PDBottomSection extends StatefulWidget {
  const PDBottomSection({super.key, required this.args});
  final ProductDetailArgs args;

  @override
  State<PDBottomSection> createState() => _PDBottomSectionState();
}

class _PDBottomSectionState extends State<PDBottomSection> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final Product product;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    product = widget.args.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildProductDescriptionWidget(),
        const SizedBox(
          height: 16,
        ),
        buildDetailCardWidget(context,
            titleKey: AppKeys().productDetailAboutSellerTitleKey,
            title: AppStrings().aboutSellerTitle,
            bodyPage: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: AlvaText(
                            title: product.merchantFullName,
                            textStyle: AlvaStyles().headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                        child: AlvaText(
                            title: product.merchantAddress, textStyle: AlvaStyles().headingSize10w400(spaceGrey)))
                  ],
                ),
              ],
            )),
        const SizedBox(
          height: 16,
        ),
        buildDetailCardWidget(context,
            titleKey: AppKeys().productDetailPromotionDetailTitleKey,
            title: AppStrings().promotionDetailTitle,
            bodyPage: Padding(
              padding: EdgeInsets.only(top: 8),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: product.promotionTag.length > 3 ? 3 : product.promotionTag.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                        padding: EdgeInsets.only(bottom: 8),
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
                                        title: product.promotionTag[index],
                                        textStyle: AlvaStyles().headingSize12w500WithHeightFixed(spaceGrey)))
                              ],
                            )
                          ],
                        ));
                  })),
            )),
        const SizedBox(
          height: 16,
        ),
        buildDetailCardWidget(context,
            titleKey: AppKeys().productDetailRemarkTitleKey,
            title: AppStrings().remarkTitle,
            bodyPage: HtmlWidget(
              product.remark,
              buildAsync: true,
              customStylesBuilder: (element) {
                return {'font-family': 'Krungsri Condensed', 'font-size': '12px', 'font-weight': '400'};
              },
              factoryBuilder: () => _MyFactory(title: AppStrings().remarkTitle),
            )),
      ],
    );
  }

  Widget buildProductDescriptionWidget() {
    bool isPressedReadMore = false;
    return Container(
        decoration: BoxDecoration(
          color: whitePure,
        ),
        child: StatefulBuilder(builder: (context, setState) {
          String data = "";
          if (_tabController.index == 0) {
            data = product.technicalSpec;
            log(data);
          } else {
            data = product.description;
          }
          List<String> line = data.split('<br>');
          log('line: ${line.length.toString()}');
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
                      bottom: BorderSide(color: cloudWhite, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TabBar(
                      controller: _tabController,
                      labelColor: BTN_SELECTED_TEXT_COLOR_NEW,
                      indicatorColor: BlueFantasy,
                      unselectedLabelColor: cloudSoftDeepWhite,
                      labelStyle: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      onTap: (int index) {
                        setState(() {});
                        log("TapBar index $index");
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
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: data.isEmpty ? 32 : 0),
                    child: Column(
                      children: [
                        isPressedReadMore
                            ? HtmlWidget(
                                data.isNotEmpty ? data : AppStrings().noDataFromSeller,
                                buildAsync: true,
                                factoryBuilder: () => _MyFactory(title: AppStrings().productDetailProductDescription),
                              )
                            : Container(),
                        !isPressedReadMore
                            ? HtmlWidget(
                                data.isNotEmpty ? data : AppStrings().noDataFromSeller,
                                buildAsync: true,
                                customStylesBuilder: (element) {
                                  return {
                                    'font-family': 'Krungsri Condensed',
                                    'font-size': '14px',
                                    'max-lines': '5',
                                    'text-overflow': 'ellipsis'
                                  };
                                },
                                factoryBuilder: () => _MyFactory(title: AppStrings().productDetailProductDescription),
                              )
                            : Container(),
                      ],
                    )),
              ),
              data.isNotEmpty
                  ? _tabController.index == 1
                      ? Padding(
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
                                      setState((() {
                                        isPressedReadMore = !isPressedReadMore;
                                      }));
                                      log(isPressedReadMore.toString());
                                    },
                                    style: AlvaStyles()
                                        .outlineNoneBorderButtonStyle(Colors.transparent, Colors.transparent),
                                    child: AlvaText(
                                      title: isPressedReadMore
                                          ? AppStrings().btnHideDescription
                                          : AppStrings().btnReadMore,
                                      textStyle: AlvaStyles().headingSize14w700(BlueFantasy),
                                      disableSelectableText: true,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                      : Container()
                  : Container()
            ],
          );
        }));
  }

  Widget buildDetailCardWidget(BuildContext context, {Key? titleKey, String? title, Widget? bodyPage}) {
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
            GestureDetector(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: bodyPage)),
            title == AppStrings().aboutSellerTitle
                ? Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () async {
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
                              AlvaText(
                                  title: "ติดต่อ ${product.merchantMobile}",
                                  textStyle: AlvaStyles().heading2(BTN_SELECTED_TEXT_COLOR_NEW)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 24,
            ),
          ],
        ));
  }
}

class _MyFactory extends WidgetFactory {
  _MyFactory({this.title = ""});

  String title;
  @override
  void parse(BuildMetadata meta) {
    final e = meta.element;
    log(e.toString());
    if (title == AppStrings().productDetailProductDescription) {
      if (e.localName == 'tr') {
        for (int i = 0; i < e.nodes.length; i++) {
          if (i == 0) {
            meta.element.nodes[i].nodes[0].attributes = {
              "style": "color:#9c9c9c; font-size:14px; font-family:Krungsri Condensed; line-height:24px;",
            } as LinkedHashMap<Object, String>;
          } else {
            meta.element.nodes[i].nodes[0].attributes = {
              "style": "color:#2c2626;  font-size:14px; font-family:Krungsri Condensed; line-height:24px;",
            } as LinkedHashMap<Object, String>;
          }
        }
        return;
      }
    } else if (title == AppStrings().remarkTitle) {
      if (e.nodes.isNotEmpty) {
        for (int i = 0; i < e.nodes.length; i++) {
          if (e.nodes[i].text!.contains('เบอร์ติดต่อ')) {
            // RegExp pattern = RegExp(r'เบอร์ติดต่อ \d{3}-\d{3}-\d{4}');
            // String stringBeforeReplace = "";
            // Iterable<RegExpMatch> match = pattern.allMatches(e.nodes[i].text!);

            // for (var match in match) {
            //   stringBeforeReplace =
            //       e.nodes[i].text!.substring(match.start, match.end);
            // }
            // meta.element.nodes[i].text =
            //     meta.element.nodes[i].text!.replaceAll(pattern, '');

            // meta.element.nodes.insert(i + 1, meta.element.nodes[i]);
            // meta.element.attributes = {
            //   "style":
            //       "font-size:12px; font-family:Krungsri Condensed; font-style:medium ; line-height:24px"
            // } as LinkedHashMap<Object, String>;
            return;
          }
        }
      }
    }
    return super.parse(meta);
  }
}
