import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/custom_tap_down_details.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PDTopSection extends StatelessWidget {
  const PDTopSection({super.key});

  Widget promos(Product p) {
    List<InlineSpan> l = [];
    int len = p.promotionTag.length > 3 ? 3 : p.promotionTag.length;
    for (var i = 0; i < len; i++) {
      l.add(TextSpan(text: p.promotionTag[i], style: AlvaStyles().headingSize10w500(spaceGrey)));
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
    double maxWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        final replaceInnerTagP = state.product.tagline.isNotEmpty
            ? state.product.tagline.substring(3, state.product.tagline.length - 4).replaceAll("<p>", "<br><br>").replaceAll("</p>", "")
            : "";
        final tagline = state.product.tagline.isNotEmpty ? "<p>$replaceInnerTagP<p/>" : "";
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
                            child: Image.asset(
                              "assets/homepage/brand.png",
                              height: 32,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const SizedBox(),
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
                            HtmlWidget(tagline,
                                buildAsync: true,
                                customWidgetBuilder: (element) {
                                  if (element.localName == 'p' || element.localName == 'span') {
                                    String text = element.text;
                                    return ReadMoreText(
                                      text,
                                      trimLines: 3,
                                      preDataText: null,
                                      postDataText: null,
                                      style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 20 / 12),
                                      lessStyle: AlvaStyles().headingSize10w700(BlueFantasy),
                                      moreStyle: AlvaStyles().headingSize10w700(BlueFantasy),
                                      postDataTextStyle: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 20 / 12),
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: ' อ่านต่อ ',
                                      trimExpandedText: '  ซ่อนรายละเอียด',
                                    );
                                  }
                                  return null;
                                },
                                textStyle: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 20 / 12),
                                customStylesBuilder: (element) {
                                  if (element.attributes['style'] != null && element.attributes['style'].toString().contains('color')) {
                                    if (element.attributes['style'].toString().contains('9c9c9c')) {
                                      element.attributes['style'] = 'color:#9c9c9c';
                                    } else {
                                      element.attributes['style'] = 'color:#2c2626';
                                    }
                                  } else {
                                    element.attributes['style'] = '';
                                  }
                                  if (element.localName == "table") {
                                    return {'width': '100%'};
                                  } else if (element.localName == "td") {
                                    return {'width': '50%'};
                                  }

                                  return null;
                                }),
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
                                  padding: const EdgeInsets.only(bottom: 2),
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
