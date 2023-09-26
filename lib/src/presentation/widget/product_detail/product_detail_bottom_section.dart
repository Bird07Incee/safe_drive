import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
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
import 'package:url_launcher/url_launcher_string.dart';

class PDBottomSection extends StatefulWidget {
  const PDBottomSection({super.key, required this.args});
  final ProductDetailArgs args;

  @override
  State<PDBottomSection> createState() => _PDBottomSectionState();
}

class _PDBottomSectionState extends State<PDBottomSection>
    with TickerProviderStateMixin {
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
                    AlvaText(
                        title: product.merchantFullName,
                        textStyle: AlvaStyles().headingSize14w700(blackInBlack))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    AlvaText(
                        title: product.merchantAddress,
                        textStyle: AlvaStyles().headingSize10w400(smockGrey))
                  ],
                ),
              ],
            )),
        const SizedBox(
          height: 16,
        ),
        buildDetailCardWidget(
          context,
          titleKey: AppKeys().productDetailPromotionDetailTitleKey,
          title: AppStrings().promotionDetailTitle,
          bodyPage: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: product.promotionTag.length,
              itemBuilder: ((context, index) {
                return Row(
                  children: [
                    const Icon(
                      Icons.bookmark,
                      size: 12,
                      color: smockGrey,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    AlvaText(
                        title: product.promotionTag[index],
                        textStyle: AlvaStyles().headingSize12w700(blackInBlack))
                  ],
                );
              })),
        ),
        const SizedBox(
          height: 16,
        ),
        buildDetailCardWidget(context,
            titleKey: AppKeys().productDetailRemarkTitleKey,
            title: AppStrings().remarkTitle,
            bodyPage: HtmlWidget(product.remark, buildAsync: true,
                customStylesBuilder: (element) {
              return {'font-family': 'Krungsri Condensed', 'font-size': '14px'};
            })),
      ],
    );
  }

  Widget buildProductDescriptionWidget() {
    bool isPressedReadMore = false;
    return Container(
        decoration: BoxDecoration(
          color: whitePure,
          boxShadow: [
            BoxShadow(
              color: const Color(0xffdedede).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: StatefulBuilder(builder: (context, setState) {
          String data = "";
          if (_tabController.index == 0) {
            data = product.technicalSpec;
            log(data);
          } else {
            data = product.description;
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: AlvaText(
                        key: AppKeys().productDetailProductDescriptionKey,
                        title: AppStrings().productDetailProductDescription,
                        textStyle:
                            AlvaStyles().headingSize16w500(ModernDarkGray),
                      )),
                ),
              ),
              TabBar(
                  controller: _tabController,
                  labelColor: ModernDarkGray,
                  indicatorColor: BlueFantasy,
                  unselectedLabelColor: const Color(0xffA4A8AD),
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
                    Tab(
                        key: AppKeys().productDetailEtcDetailTabKey,
                        text: AppStrings().etcDetail),
                  ]),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onHorizontalDragEnd: (details) async {
                  if (_tabController.index == 0) {
                    if (details.primaryVelocity! < 0) {
                      _tabController.animateTo(1,
                          duration: const Duration(milliseconds: 300));
                      setState(() {});
                    }
                  } else {
                    if (details.primaryVelocity! > 0) {
                      _tabController.animateTo(0,
                          duration: const Duration(milliseconds: 300));
                      setState(() {});
                    }
                  }
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: data.isEmpty ? 32 : 0),
                    child: Column(
                      children: [
                        isPressedReadMore
                            ? HtmlWidget(
                                data.isNotEmpty
                                    ? data
                                    : AppStrings().noDataFromSeller,
                                buildAsync: true,
                                customStylesBuilder: (element) {
                                  return {
                                    'font-family': 'Krungsri Condensed',
                                    'font-size': '14px'
                                  };
                                },
                                factoryBuilder: () => _MyFactory(),
                              )
                            : Container(),
                        !isPressedReadMore
                            ? HtmlWidget(
                                data.isNotEmpty
                                    ? data
                                    : AppStrings().noDataFromSeller,
                                buildAsync: true,
                                customStylesBuilder: (element) {
                                return {
                                  'font-family': 'Krungsri Condensed',
                                  'font-size': '14px',
                                  'max-lines': '5',
                                  'text-overflow': 'ellipsis'
                                };
                              })
                            : Container(),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              data.isNotEmpty
                  ? _tabController.index == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                height: 48,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    setState((() {
                                      isPressedReadMore = !isPressedReadMore;
                                    }));
                                    log(isPressedReadMore.toString());
                                  },
                                  style: AlvaStyles()
                                      .outlineNoneBorderButtonStyle(
                                          Colors.transparent,
                                          Colors.transparent),
                                  child: AlvaText(
                                    title: isPressedReadMore
                                        ? AppStrings().btnHideDescription
                                        : AppStrings().btnReadMore,
                                    textStyle: AlvaStyles()
                                        .headingSize14w700(BlueFantasy),
                                    disableSelectableText: true,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Container()
                  : Container()
            ],
          );
        }));
  }

  switchStyleForHtml({String? title, bool isPressedReadMore = false}) {
    if (title == AppStrings().aboutSellerTitle) {
      return {
        'font-family': 'Krungsri Condensed',
        'font-size': '14px',
      };
    } else if (title == AppStrings().promotionDetailTitle) {
      return {
        'font-family': 'Krungsri Condensed',
        'font-size': '14px',
      };
    } else if (title == AppStrings().remarkTitle) {
      return {
        'font-family': 'Krungsri Condensed',
        'font-size': '14px',
      };
    }
  }

  Widget buildDetailCardWidget(BuildContext context,
      {Key? titleKey, String? title, Widget? bodyPage}) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: whitePure,
          boxShadow: [
            BoxShadow(
              color: const Color(0xffdedede).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: AlvaText(
                      key: titleKey!,
                      title: title!,
                      textStyle: AlvaStyles().headingSize16w500(ModernDarkGray),
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: bodyPage)),
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
                            if (Platform.isIOS) {
                              var alert = CupertinoAlertDialog(
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      String mobile = product.merchantMobile
                                          .replaceAll('-', '');
                                      callPhone(mobile);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.phone_in_talk_sharp,
                                          color: BTN_SELECTED_TEXT_COLOR_NEW,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        AlvaText(
                                            title:
                                                "ติดต่อ ${product.merchantMobile}",
                                            textStyle: AlvaStyles()
                                                .heading2(BlueFantasy)),
                                      ],
                                    ),
                                  ),
                                  CupertinoDialogAction(
                                      isDefaultAction: true,
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: Text('Cancel',
                                          style: AlvaStyles()
                                              .heading2(BlueFantasy))),
                                ],
                              );
                              bool isConfirmCall = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                              if (isConfirmCall) {
                                await launchUrlString(
                                    'tel:${product.merchantMobile}');
                              }
                            } else if (Platform.isAndroid) {
                              await launchUrlString(
                                  'tel:${product.merchantMobile}');
                            }
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
                                  textStyle: AlvaStyles()
                                      .heading2(BTN_SELECTED_TEXT_COLOR_NEW)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )
                : Container()
          ],
        ));
  }
}

class _MyFactory extends WidgetFactory {
  @override
  void parse(BuildMetadata meta) {
    final e = meta.element;
    log(e.toString());
    if (e.localName == 'tr') {
      for (int i = 0; i < e.nodes.length; i++) {
        if (i == 0) {
          meta.element.nodes[i].nodes.first.attributes = {
            "style": "color:#9c9c9c",
            "": "",
          } as LinkedHashMap<Object, String>;
        } else {
          meta.element.nodes[i].nodes.first.attributes = {
            "style": "color:#2c2626",
            "": "",
          } as LinkedHashMap<Object, String>;
        }
      }
      return;
    }
    return super.parse(meta);
  }
}
