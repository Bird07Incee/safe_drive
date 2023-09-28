import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/custom_tap_down_details.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/model/product_detail/product_detail_args.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PDTopSection extends StatelessWidget {
  const PDTopSection({super.key, required this.args});
  final ProductDetailArgs args;

  Widget promos() {
    List<InlineSpan> l = [];
    int len = args.product.promotionTag.length > 3 ? 3 : args.product.promotionTag.length;
    for (var i = 0; i < len; i++) {
      l.add(TextSpan(text: args.product.promotionTag[i], style: AlvaStyles().headingSize10w500(spaceGrey)));
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
    return BlocBuilder<ImgGalleryZoomBloc, TransformationController>(
      builder: (context, zoomState) {
        return BlocBuilder<ProductDetailCarouselScrollControllerBloc, PageController>(
          builder: (context, carouselState) {
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
                            itemCount: args.product.productionAssets.length == 1
                                ? args.product.productionAssets.length
                                : args.product.productionAssets.length + 1,
                            controller: carouselState,
                            onPageChanged: (val) {
                              context
                                  .read<ProductDetailCarouselScrollControllerBloc>()
                                  .add(CarouselScrollAction(index: val));
                              if (val == args.product.productionAssets.length && val != 1) {
                                carouselState.jumpToPage(0);
                              }
                            },
                            itemBuilder: (ctx, i) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<ViewImgDetailPageSwitchBloc>()
                                          .add(SwitchPageAction(statePage: true));
                                      context
                                          .read<ProductDetailCarouselScrollControllerBloc>()
                                          .add(CarouselScrollAction(index: carouselState.initialPage));
                                      context
                                          .read<PreviousScaleBloc>()
                                          .add(const PreviousScaleEvent(previousScale: 0.5));
                                      if (zoomState.value != Matrix4.identity()) {
                                        context.read<ImgGalleryZoomBloc>().add(
                                            ZoomImageAction(details: customTapDownDetails(const Offset(100, 100))));
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
                                            i == args.product.productionAssets.length
                                                ? args.product.productionAssets[0]
                                                : args.product.productionAssets[i],
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
                        visible: args.product.productionAssets.length > 1,
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
                                  title: "${carouselState.initialPage + 1}/${args.product.productionAssets.length}",
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
                        visible: args.product.percentDiscountPrice > 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          decoration: const BoxDecoration(
                              color: BlueFantasy, borderRadius: BorderRadius.only(bottomRight: Radius.circular(8))),
                          child: AlvaText(
                            title: "ถูกลง ${args.product.percentDiscountPrice} %",
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
                          visible: args.product.productionAssets.length == 1 ? false : true,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: SmoothPageIndicator(
                                controller: carouselState,
                                count: args.product.productionAssets.length <= carouselShowLimit
                                    ? args.product.productionAssets.length
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
                          title: args.product.productName,
                          textStyle: AlvaStyles().headingSize22w700(BTN_SELECTED_TEXT_COLOR_NEW),
                        ),
                        args.product.promotionTag.isEmpty ? SizedBox() : promos(),
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
                        HtmlWidget(args.product.tagline,
                            buildAsync: true,
                            customWidgetBuilder: (element) {
                              if (element.localName == 'p' || element.localName == 'span') {
                                String text = element.text;
                                return Padding(
                                  padding: const EdgeInsets.only(left: 0, bottom: 16.0),
                                  child: ReadMoreText(
                                    text,
                                    trimLines: 3,
                                    preDataText: null,
                                    postDataText: null,
                                    style: AlvaStyles().headingSize10w400(spaceGrey),
                                    lessStyle: AlvaStyles().headingSize10w700(BlueFantasy),
                                    moreStyle: AlvaStyles().headingSize10w700(BlueFantasy),
                                    postDataTextStyle: AlvaStyles().headingSize10w400(spaceGrey),
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: ' อ่านต่อ ',
                                    trimExpandedText: '  ซ่อนรายละเอียด',
                                  ),
                                );
                              }
                              return null;
                            },
                            textStyle: AlvaStyles().headingSize10w400(spaceGrey),
                            customStylesBuilder: (element) {
                              if (element.attributes['style'] != null &&
                                  element.attributes['style'].toString().contains('color')) {
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
                          visible: args.product.discountPrice > 0,
                          child: Row(
                            children: [
                              AlvaText(
                                title: args.product.discountPrice.toDecimalFormat(),
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
                              title: args.product.price.toDecimalFormat(),
                              textStyle: AlvaStyles()
                                  .headingSize22w700(
                                      args.product.discountPrice > 0 ? RedWordShow : BTN_SELECTED_TEXT_COLOR_NEW)
                                  .copyWith(height: 1.454),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: AlvaText(
                                title: ' บาท',
                                textStyle: AlvaStyles()
                                    .headingSize18w700(
                                        args.product.discountPrice > 0 ? RedWordShow : BTN_SELECTED_TEXT_COLOR_NEW)
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
  }
}
