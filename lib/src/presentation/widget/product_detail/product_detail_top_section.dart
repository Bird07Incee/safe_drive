import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/custom_tap_down_details.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/produc_detail_tagline_toggle/product_detail_description_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/utils/truncated_html_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PDTopSection extends StatefulWidget {
  const PDTopSection({super.key});

  @override
  State<PDTopSection> createState() => _PDTopSectionState();
}

class _PDTopSectionState extends State<PDTopSection> {
  bool isPressedReadMore = false;
  bool isReadMoreVisible = false;
  double descriptionHeight = 0;

  Widget promos(Product p) {
    List<InlineSpan> l = [];
    int len = p.promotionTag.length > 3 ? 3 : p.promotionTag.length;
    for (var i = 0; i < len; i++) {
      l.add(TextSpan(text: p.promotionTag[i], style: AlvaStyles().headingSize12w500(spaceGrey).copyWith(height: 20 / 12)));
      if (i != len - 1 && len <= 3) {
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
    var myBloc = BlocProvider.of<ProductDetailDescriptionCubit>(context);
    double maxWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        final replaceInnerTagP = state.product.tagline.isNotEmpty ? state.product.tagline : "";
        var tagline = state.product.tagline.isNotEmpty ? replaceInnerTagP : "";

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
        TruncatedHtmlText truncatedHtmlText = TruncatedHtmlText();
        tagline = truncatedHtmlText.removeHtmlForbiddenTagsTags(tagline);
        for (var replacement in [
          {"<table>": "<p>", "</table>": "</p>"},
          {"<thead>": "", "</thead>": ""},
          {"<tr>": "", "</tr>": ""},
          {"<th>": "", "</th>": ""},
          {"<tbody>": "", "</tbody>": ""},
          {"<td>": "", "</td>": ""},
        ]) {
          replacement.forEach((key, value) {
            tagline = tagline.replaceAll(key, value);
          });
        }

        List<dynamic> listResult = truncatedHtmlText.formatSubStringHtml(tagline, myBloc) ?? [];

        int lineFinal = 0;
        int maxLines = 2;
        String textString = "";
        String truncatedHtmlContent = "";

        if (listResult.length == 4) {
          lineFinal = listResult[0];
          maxLines = listResult[1];
          textString = listResult[2];
          truncatedHtmlContent = listResult[3];
        }

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
                                          AmplitudeWebHelper.getInstance().logTapOniImageGallery(
                                              productName: state.product.productName,
                                              contentId: state.product.productId,
                                              merchantName: state.product.merchantFullName);
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
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                              margin: EdgeInsets.all(8),
                              padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                              child: Image.network(
                                state.product.merchantLogo,
                                height: 40,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                              ),
                            ),
                          )),
                          Visibility(
                            visible: state.product.percentDiscountPrice != 0 && state.product.productionOptionals.isEmpty,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              decoration: const BoxDecoration(color: mintGreen, borderRadius: BorderRadius.only(bottomRight: Radius.circular(8))),
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
                                      activeDotColor: mintGreen,
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
                                  // onTap: () {
                                  //   if (!descriptionState.textNotMoreThan) {
                                  //     if (descriptionState.toggleDescription) {
                                  //       myBloc.updateToggleTapDescription(toggleDescription: false);
                                  //     } else {
                                  //       myBloc.updateToggleTapDescription(toggleDescription: true);
                                  //     }
                                  //   }
                                  // },
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        key: const Key("read_more_product_detail"),
                                        child: Container(
                                          padding: EdgeInsets.only(right: 0),
                                          child: HtmlWidget(
                                              descriptionState.toggleDescription ||
                                                      (lineFinal <= maxLines && truncatedHtmlText.containsHtmlTags(tagline))
                                                  ? "$tagline${lineFinal <= maxLines ? "" : " "}" //<p1>ซ่อนรายละเอียด<p1>
                                                  : !truncatedHtmlText.containsHtmlTags(tagline)
                                                      ? tagline != ""
                                                          ? "$textString..." //<p1>อ่านต่อ</p1>
                                                          : ""
                                                      : "$truncatedHtmlContent...", //${"<p1>อ่านต่อ</p1>"}
                                              buildAsync: false,
                                              textStyle: AlvaStyles().headingSize12w500(blackGoMunTo).copyWith(height: 24 / 16),
                                              customStylesBuilder: (element) {
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
                                                'font-weight': '700',
                                                'font-family': "'Krungsri Condensed'",
                                                'font-size': '14px',
                                                'line-height': '24px',
                                                'color': '#40A9FC'
                                              };
                                            }
                                            if (element.localName == "p" || element.localName == "li") {
                                              return {
                                                'font-weight': '500',
                                                'font-family': "'Krungsri Condensed'",
                                                'font-size': '12px',
                                                'line-height': '20px',
                                                'color': '#5A5A5A'
                                              };
                                            }
                                            if (element.localName == "table") {
                                              return {'width': '100%'};
                                            } else if (element.localName == "td") {
                                              return {'width': '50%'};
                                            }
                                            return null;
                                          }),
                                        ),
                                      ),
                                      tagline != "" && !tagline.contains("<table")
                                          ? Visibility(
                                              visible: !descriptionState.textNotMoreThan, //lineFinal <= maxLines && containsHtmlTags(tagline),
                                              child: Container(
                                                  padding: EdgeInsets.only(top: 8),
                                                  child: Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          alignment: Alignment.centerLeft,
                                                          //  padding: const EdgeInsets.symmetric(horizontal: 16),
                                                          //  height: 24,
                                                          child: OutlinedButton(
                                                            onPressed: () async {
                                                              if (!descriptionState.textNotMoreThan) {
                                                                if (descriptionState.toggleDescription) {
                                                                  myBloc.updateToggleTapDescription(toggleDescription: false);
                                                                } else {
                                                                  myBloc.updateToggleTapDescription(toggleDescription: true);
                                                                }
                                                              }
                                                            },
                                                            style: AlvaStyles()
                                                                .outlineNoneBorderButtonStyle(Colors.transparent, BlueFantasy, padding: 0),
                                                            child: AlvaText(
                                                              title: descriptionState.toggleDescription
                                                                  ? AppStrings().btnHideDescription
                                                                  : AppStrings().btnReadMore,
                                                              textStyle: AlvaStyles().headingSize14Height24(BlueFantasy),
                                                              disableSelectableText: true,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ))) //"${textString!}..." //<p1>อ่านต่อ</p1>
                                          : Container(),
                                      // HtmlWidget(
                                      //     descriptionState.toggleDescription || (lineFinal <= maxLines && containsHtmlTags(tagline))
                                      //         ? "$tagline${lineFinal <= maxLines ? "" : " <p1>ซ่อนรายละเอียด<p1> "}"
                                      //         : !containsHtmlTags(tagline)
                                      //             ? tagline != ""
                                      //                 ? "${textString!}... <p1>อ่านต่อ</p1>" //<p1>อ่านต่อ</p1>
                                      //                 : ""
                                      //             : "$truncatedHtmlContent... ${"<p1>อ่านต่อ</p1>"}", //${"<p1>อ่านต่อ</p1>"}
                                      //     buildAsync: false,
                                      //     textStyle: AlvaStyles().headingSize12w500(blackGoMunTo).copyWith(height: 24 / 16), customStylesBuilder: (element) {
                                      //   if (element.attributes['style'] != null && element.attributes['style'].toString().contains('color')) {
                                      //     if (element.attributes['style'].toString().contains('9c9c9c')) {
                                      //       element.attributes['style'] = 'color:#9c9c9c';
                                      //     } else {
                                      //       element.attributes['style'] = 'color:#6699ff';
                                      //     }
                                      //   } else {
                                      //     element.attributes['style'] = '';
                                      //   }
                                      //   if (element.localName == "p1") {
                                      //     return {
                                      //       'font-weight': '700',
                                      //       'font-family': 'Krungsri Condensed',
                                      //       'font-size': '14px',
                                      //       'line-height': '24px',
                                      //       'color': '#40A9FC'
                                      //     };
                                      //   }
                                      //   if (element.localName == "p") {
                                      //     return {
                                      //       'font-weight': '500',
                                      //       'font-family': 'Krungsri Condensed',
                                      //       'font-size': '12px',
                                      //       'line-height': '20px',
                                      //       'color': '#5A5A5A'
                                      //     };
                                      //   }
                                      //   if (element.localName == "table") {
                                      //     return {'width': '100%'};
                                      //   } else if (element.localName == "td") {
                                      //     return {'width': '50%'};
                                      //   }
                                      //   return null;
                                      // }),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Visibility(
                              visible: state.product.discountPrice != 0 && state.product.productionOptionals.isEmpty,
                              child: Row(
                                children: [
                                  AlvaText(
                                    title: state.product.price.toDecimalFormat(),
                                    textStyle: AlvaStyles().discountPriceTxt14w400(RedWordShow).copyWith(height: 1.714),
                                  ),
                                  AlvaText(
                                    title: ' บาท',
                                    textStyle: AlvaStyles().bodySize14w400(RedWordShow).copyWith(height: 1.714), //smockGrey
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
                                  textStyle: AlvaStyles().headingSize22w700Height(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 1.454),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 3, top: 0),
                                  //  padding: EdgeInsets.only(bottom: 2, top: tagline != "" ? 16 : 1),
                                  child: AlvaText(
                                    title: ' บาท',
                                    textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 1.454),
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
