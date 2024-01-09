import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_keys.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';

class PDBottomSection extends StatefulWidget {
  const PDBottomSection({super.key});

  @override
  State<PDBottomSection> createState() => _PDBottomSectionState();
}

class _PDBottomSectionState extends State<PDBottomSection> with TickerProviderStateMixin {
  late final TabController _tabController;
  String? remarkHtmlString;
  bool isPressedReadMore = false;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        remarkHtmlString = state.product.remark.replaceAllMapped(
          RegExp(r'เบอร์ติดต่อ (\d{3}-\d{3}-\d{4})'),
          (match) {
            return '<strong>${match.group(0)}</strong>';
          },
        );
        return Column(
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
                        Expanded(
                            child: AlvaText(
                                title: state.product.merchantFullName, textStyle: AlvaStyles().headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)))
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(child: AlvaText(title: state.product.merchantAddress, textStyle: AlvaStyles().headingSize10w400(spaceGrey)))
                      ],
                    ),
                  ],
                )),
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
            Visibility(
              visible: state.product.promotionTag.isNotEmpty,
              child: buildDetailCardWidget(context, state.product,
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
            ),
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
            Visibility(
              visible: state.product.promotionTag.isNotEmpty,
              child: buildDetailCardWidget(context, state.product,
                  titleKey: AppKeys().productDetailRemarkTitleKey,
                  title: AppStrings().remarkTitle,
                  bodyPage: HtmlWidget(
                    remarkHtmlString ?? "",
                    buildAsync: true,
                    customStylesBuilder: (element) {
                      if (element.localName == 'strong') {
                        return {'font-family': 'Krungsri Condensed', 'font-size': '12px', 'line-height': '24px', 'font-weight': 'Bold'};
                      }
                      return {'font-family': 'Krungsri Condensed', 'font-size': '12px', 'line-height': '24px'};
                    },
                    textStyle: TextStyle(fontWeight: FontWeight.w400),
                  )),
            ),
          ],
        );
      },
    );
  }

  Widget buildProductDescriptionWidget(Product product) {
    return Container(
        decoration: BoxDecoration(
          color: whitePure,
        ),
        child: StatefulBuilder(builder: (context, setState) {
          String data = "";
          if (_tabController.index == 0) {
            data = product.technicalSpec;
          } else {
            final replaceInnerTagP = product.description.isNotEmpty
                ? product.description.substring(3, product.description.length - 4).replaceAll("<p>", "<br><br>").replaceAll("</p>", "")
                : "";
            data = product.description.isNotEmpty ? "<p>$replaceInnerTagP<p/>" : "";
          }
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
                    padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: data.isEmpty ? 16 : 0,
                        bottom: data.isEmpty
                            ? 32
                            : _tabController.index == 0
                                ? 16
                                : 0),
                    child: Column(
                      children: [
                        isPressedReadMore
                            ? HtmlWidget(
                                data.isNotEmpty ? data : AppStrings().noDataFromSeller,
                                buildAsync: true,
                                customStylesBuilder: (element) {
                                  return {'font-family': 'Krungsri Condensed', 'font-size': '14px', 'line-height': '24px', 'color': '#2c2626'};
                                },
                                factoryBuilder: () => _MyFactory(title: AppStrings().productDetailProductDescription),
                              )
                            : Container(),
                        !isPressedReadMore
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width - 32,
                                height: _tabController.index == 1 ? 120 : null,
                                child: HtmlWidget(
                                  data.isNotEmpty ? data : AppStrings().noDataFromSeller,
                                  buildAsync: true,
                                  customStylesBuilder: (element) {
                                    if (element.localName == "table") {
                                      return {'width': '100%'};
                                    }
                                    if (element.localName == "td") {
                                      return {
                                        'width': '50%',
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
                                      return {'font-family': 'Krungsri Condensed', 'font-size': '14px', 'line-height': '24px', 'color': '#2c2626'};
                                    }
                                    return null;
                                  },
                                  customWidgetBuilder: (element) {
                                    // if (_tabController.index == 1 && (element.localName == 'p' || element.localName == 'span')) {
                                    //   String text = element.text;
                                    //   return Text(
                                    //     text,
                                    //     style: TextStyle(
                                    //         fontSize: 14,
                                    //         fontFamily: 'Krungsri Condensed',
                                    //         overflow: TextOverflow.ellipsis,
                                    //         height: 24 / 14,
                                    //         color: BTN_SELECTED_TEXT_COLOR_NEW),
                                    //     overflow: TextOverflow.ellipsis,
                                    //   );
                                    // }
                                    if (element.localName == "th" || element.localName == "thead") {
                                      return SizedBox.shrink();
                                    }
                                    return null;
                                  },
                                  factoryBuilder: () => _MyFactory(title: AppStrings().productDetailProductDescription),
                                ),
                              )
                            : Container(),
                      ],
                    )),
              ),
              data.isNotEmpty
                  ? _tabController.index == 1
                      ? LayoutBuilder(builder: (context, constraints) {
                          data = data.replaceAll("<br/>", "\n");
                          final span = TextSpan(text: data, style: TextStyle(fontFamily: 'Krungsri Condensed', fontSize: 14));
                          final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
                          tp.layout(maxWidth: constraints.maxWidth);
                          final numLines = tp.computeLineMetrics().length;
                          return Container(
                              padding: numLines > 5 ? null : EdgeInsets.only(top: 16),
                              child: Visibility(
                                  visible: numLines > 5,
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
                                                  setState((() {
                                                    isPressedReadMore = !isPressedReadMore;
                                                  }));
                                                },
                                                style: AlvaStyles().outlineNoneBorderButtonStyle(Colors.transparent, Colors.transparent),
                                                child: AlvaText(
                                                  title: isPressedReadMore ? AppStrings().btnHideDescription : AppStrings().btnReadMore,
                                                  textStyle: AlvaStyles().headingSize14w700(BlueFantasy),
                                                  disableSelectableText: true,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ))));
                        })
                      : Container()
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
            GestureDetector(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: bodyPage)),
            title == AppStrings().aboutSellerTitle
                ? Column(
                    children: [
                      SizedBox(height: 16),
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
                              Text("ติดต่อ ${product.merchantMobile}", style: AlvaStyles().heading2(BTN_SELECTED_TEXT_COLOR_NEW)),
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
  void parse(BuildTree meta) {
    final e = meta.element;
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
    }
    return super.parse(meta);
  }
}
