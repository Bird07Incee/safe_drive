import 'dart:developer';

import 'package:datadog_flutter_plugin/datadog_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
// import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/active_images_index.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({super.key, required this.maxWidth, required this.scrollController});

  final double maxWidth;
  final ScrollController scrollController;

  String cleanHtml(String text) {
    String temp = text;

    temp = temp.replaceAll("<p>", "");
    temp = temp.replaceAll("</p>", "<br>");

    temp = temp.replaceAll("<h1>", "<b>");
    temp = temp.replaceAll("<h2>", "<b>");
    temp = temp.replaceAll("<h3>", "<b>");
    temp = temp.replaceAll("<h4>", "<b>");

    temp = temp.replaceAll("</h1>", "</b><br><p>");
    temp = temp.replaceAll("</h2>", "</b><br><p>");
    temp = temp.replaceAll("</h3>", "</b><br><p>");
    temp = temp.replaceAll("</h4>", "</b><br><p>");

    temp += "</p>";

    return temp;
  }

  Widget promos(Product p) {
    List<InlineSpan> l = [];
    int len = p.promotionTag.length;
    for (var i = 0; i < len; i++) {
      l.add(TextSpan(text: p.promotionTag[i], style: AlvaStyles().headingSize12w500(spaceGrey).copyWith(height: 20 / 12)));
      //  }
      if (i != len - 1 && len <= 3) {
        l.add(WidgetSpan(
          child: Container(
            width: 1,
            height: 20,
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
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        var productList = state.productList;
        var products = state.productList.products;
        List<int> counters = List.generate(productList.products!.length, (index) => 1);
        context.read<ActiveImagesIndexCubit>().initialItems(counters);
        return BlocBuilder<ActiveImagesIndexCubit, List<int>>(
          builder: (context, activeIndex) {
            return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: productList.products?.length,
                itemBuilder: (BuildContext context, int index) {
                  late final PageController pageViewController = PageController(initialPage: 0);
                  return RumUserActionAnnotation(
                    description: "Tap product card",
                    child: GestureDetector(
                      key: const Key("product_card"),
                      onTap: () async {
                        log("product card");
                        AmplitudeWebHelper.getInstance().logTapOnProduct(
                            productName: products[index].productName,
                            productId: products[index].productId,
                            categoryId: products[index].categoryId.toString(),
                            price: products[index].price.toDecimalFormat().toString(),
                            discountPrice: products[index].discountPrice.toDecimalFormat().toString());
                        hideOneTrustCookieScript();
                        context.read<ProductDetailBloc>().add(SetProduct(product: products[index]));
                        context.read<ProductDetailBloc>().add(SetClickFromImage(isClickFromImage: false));
                        context.read<ProductListBloc>().add(SetScrollPosition(scrollController.offset));
                        await Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?pid=${products[index].productId}');
                        showOneTrustCookieScript();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          color: whitePure,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: whitePure.withOpacity(0.4),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            RumUserActionAnnotation(
                              description: "Tap see photos",
                              child: GestureDetector(
                                key: const Key("see_photo"),
                                onTap: () async {
                                  AmplitudeWebHelper.getInstance().logTapOnImageGallery(
                                      productName: products[index].productName,
                                      productId: products[index].productId,
                                      categoryId: products[index].categoryId.toString());
                                  hideOneTrustCookieScript();
                                  context.read<ViewImgDetailPageSwitchBloc>().add(SwitchPageAction(statePage: true));
                                  context.read<ProductDetailCarouselScrollControllerBloc>().add(CarouselScrollAction(index: activeIndex[index] - 1));
                                  context.read<PreviousScaleBloc>().add(const PreviousScaleEvent(previousScale: 0.5));
                                  context.read<ProductDetailBloc>().add(SetClickFromImage(isClickFromImage: true));
                                  context.read<ProductListBloc>().add(SetScrollPosition(scrollController.offset));
                                  context.read<ProductDetailBloc>().add(SetProduct(product: products[index]));
                                  final ctx = context.read<ProductDetailCarouselScrollControllerBloc>();
                                  await Navigator.pushNamed(context, '${Routes.productDetail.toStringPath()}?pid=${products[index].productId}');

                                  showOneTrustCookieScript();
                                  int detailPage = ctx.state.page as int;
                                  pageViewController.jumpToPage(detailPage);
                                },
                                child: Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 16.0 / 9.0,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                        child: PageView.builder(
                                            itemCount: products?[index].productionAssets.length == 1
                                                ? products![index].productionAssets.length
                                                : products![index].productionAssets.length + 1,
                                            controller: pageViewController,
                                            onPageChanged: (val) {
                                              context.read<ActiveImagesIndexCubit>().update(index, val + 1);
                                              if (val == products[index].productionAssets.length && val != 1) {
                                                pageViewController.jumpToPage(0);
                                              }
                                            },
                                            itemBuilder: (ctx, i) {
                                              return Stack(
                                                children: [
                                                  SizedBox(
                                                    width: maxWidth,
                                                    height: 576,
                                                    child: FadeInImage(
                                                      placeholder: const AssetImage('assets/homepage/img_default.png'),
                                                      // Replace with your placeholder image path
                                                      image: NetworkImage(
                                                        i == products[index].productionAssets.length
                                                            ? products[index].productionAssets[0]
                                                            : products[index].productionAssets[i],
                                                      ),
                                                      fit: BoxFit.fitWidth,
                                                      imageErrorBuilder: (context, error, stackTrace) =>
                                                          Image.asset('assets/homepage/img_default.png', fit: BoxFit.fitWidth),
                                                    ),
                                                  )
                                                ],
                                              );
                                            }),
                                      ),
                                    ),
                                    Positioned.fill(
                                        child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Visibility(
                                        visible: products[index].productionAssets.length == 1 ? false : true,
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                                          width: 41,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: cloudyWhite.withOpacity(0.5),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${activeIndex[index]} / ${products[index].productionAssets.length}",
                                              style: AlvaStyles().headingSize10w500(BTN_SELECTED_TEXT_COLOR_NEW),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                                    Positioned.fill(
                                        child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                                        margin: EdgeInsets.all(8),
                                        padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                                        child: Image.network(
                                          products[index].merchantLogo,
                                          height: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                                        ),
                                      ),
                                    )),
                                    Visibility(
                                      visible: products[index].percentDiscountPrice != 0 && products[index].productionOptionals.isEmpty,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                        decoration: const BoxDecoration(
                                            color: mintGreen,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(8))),
                                        child: Text(
                                          "ถูกลง ${products[index].percentDiscountPrice} %",
                                          style: AlvaStyles().headingSize12w600(Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: products[index].productionAssets.length == 1 ? false : true,
                              child: Container(
                                color: whitePure,
                                width: maxWidth,
                                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: true,
                                      child: SmoothPageIndicator(
                                          controller: pageViewController,
                                          count: products[index].productionAssets.length <= carouselShowLimit
                                              ? products[index].productionAssets.length
                                              : carouselShowLimit,
                                          effect: const ExpandingDotsEffect(
                                            expansionFactor: 2,
                                            dotHeight: 6,
                                            dotWidth: 6,
                                            activeDotColor: mintGreen,
                                            dotColor: cloudSoftDeepWhite,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: maxWidth - 64,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: products[index].productionAssets.length == 1 ? true : false,
                                        child: SizedBox(height: 16),
                                      ),
                                      Text(
                                        products[index].productName,
                                        style: AlvaStyles().headingSize22Height32(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Visibility(visible: products[index].promotionTag.isEmpty ? false : true, child: promos(products[index])),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        width: maxWidth - 64,
                                        height: 1,
                                        color: cloudSoftDeepWhite,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Visibility(
                                        visible: products[index].tagline == "" ? false : true,
                                        child: HtmlWidget(
                                          "<p>${cleanHtml(products[index].tagline)}</p>",
                                          customStylesBuilder: (element) {
                                            if (element.localName == "p") {
                                              return {
                                                'font-family': "'Krungsri Condensed'",
                                                'font-size': '12px',
                                                'line-height': '20px',
                                                'font-weight': '500',
                                                'color': '#5A5A5A',
                                                'max-lines': '3',
                                                'text-overflow': 'ellipsis'
                                              };
                                            } else if (element.localName == "b") {
                                              return {
                                                'font-family': "'Krungsri Condensed'",
                                                'font-size': '16px',
                                                'font-weight': '600',
                                                'line-height': '24px',
                                                'max-lines': '1',
                                                'color': '#2C2626'
                                              };
                                            } else {
                                              return {
                                                'font-family': "'Krungsri Condensed'",
                                                'font-size': '12px',
                                                'line-height': '20px',
                                                'font-weight': '500',
                                                'color': '#5A5A5A',
                                                'max-lines': '3',
                                                'text-overflow': 'ellipsis'
                                              };
                                            }
                                          },
                                        ),
                                      ),
                                      Visibility(
                                        visible: products[index].tagline == "" ? false : true,
                                        child: const SizedBox(
                                          height: 16,
                                        ),
                                      ),
                                      Visibility(
                                        visible: products[index].discountPrice != 0 && products[index].productionOptionals.isEmpty,
                                        child: Row(
                                          children: [
                                            Text(
                                              products[index].price.toDecimalFormat(),
                                              style: AlvaStyles().bodySize14W400MutedLine(),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "บาท",
                                              style: AlvaStyles().bodySize14W400Muted(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                products[index].discountPrice == 0
                                                    ? products[index].price.toDecimalFormat()
                                                    : products[index].discountPrice.toDecimalFormat(),
                                                style: AlvaStyles().headingSize22(BTN_SELECTED_TEXT_COLOR_NEW),
                                              ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                "บาท",
                                                style: AlvaStyles().headingSize18(BTN_SELECTED_TEXT_COLOR_NEW),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            height: 40,
                                            decoration:
                                                const BoxDecoration(color: YellowKrungsri, borderRadius: BorderRadius.all(Radius.circular(8))),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 32,
                                                ),
                                                Text(
                                                  'สนใจ',
                                                  style: AlvaStyles().bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW),
                                                ),
                                                const SizedBox(
                                                  width: 32,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        );
      },
    );
  }
}
