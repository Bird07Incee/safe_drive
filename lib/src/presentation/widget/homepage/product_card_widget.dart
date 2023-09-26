import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/model/product_detail/product_detail_args.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({super.key, required this.maxWidth, required this.productList});

  final double maxWidth;
  final ProductList productList;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  List<int> counter = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.productList.products!.length; i++) {
      counter.add(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    var productList = widget.productList;
    var products = productList.products;

    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: productList.products?.length,
        itemBuilder: (BuildContext context, int index) {
          late final PageController pageViewController = PageController(initialPage: 0);
          return GestureDetector(
            onTap: () {
              // context.read<SelectedProductBloc>().add(SelectedProductEvent(products[index]));

              Navigator.pushNamed(context, Routes.productDetail.toStringPath(),
                  arguments: ProductDetailArgs(product: products[index]));
              // Navigator.of(context).pushNamed("${Routes.productDetail.toStringPath()}?id=1");
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: whitePure,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: whitePure.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                          child: PageView.builder(
                              itemCount: products?[index].productionAssets.length,
                              controller: pageViewController,
                              onPageChanged: (val) {
                                setState(() {
                                  counter[index] = val + 1;
                                });
                              },
                              itemBuilder: (ctx, i) {
                                return Stack(
                                  children: [
                                    SizedBox(
                                      width: widget.maxWidth,
                                      height: 576,
                                      child: FadeInImage(
                                        placeholder: const AssetImage('assets/homepage/img_default.png'),
                                        // Replace with your placeholder image path
                                        image: NetworkImage(
                                          i == products![index].productionAssets.length
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
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                          width: 62,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: cloudyWhite.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Text(
                              "${counter[index]}/ ${products?[index].productionAssets.length}",
                              style: AlvaStyles().headingSize10w500(BTN_SELECTED_TEXT_COLOR_NEW),
                            ),
                          ),
                        ),
                      )),
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
                        visible: products?[index].percentDiscountPrice != 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          decoration: const BoxDecoration(
                              color: Color(0xff40a9fc),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(8))),
                          child: AlvaText(
                            title: "ถูกลง ${products?[index].percentDiscountPrice} %",
                            textStyle: AlvaStyles().headingSize12w600(Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    color: whitePure,
                    width: widget.maxWidth,
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: true,
                          child: SmoothPageIndicator(
                              controller: pageViewController,
                              count: products![index].productionAssets.length <= carouselShowLimit
                                  ? products[index].productionAssets.length
                                  : carouselShowLimit,
                              effect: const ExpandingDotsEffect(
                                expansionFactor: 2,
                                dotHeight: 6,
                                dotWidth: 6,
                                activeDotColor: BlueFantasy,
                                dotColor: cloudSoftDeepWhite,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: widget.maxWidth - 64,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AlvaText(
                              title: products[index].productName,
                              textStyle: AlvaStyles().headingSize22Height32(),
                            ),
                            Row(
                              children: products[index]
                                  .promotionTag
                                  .map((tag) => Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(vertical: 4),
                                            child: AlvaText(
                                              title: tag,
                                              textStyle: AlvaStyles().headingSize10(),
                                            ),
                                          ),

                                          // add srperator exclude tail
                                          if (products[index].promotionTag.indexOf(tag) !=
                                              products[index].promotionTag.length - 1)
                                            const Text("| ")
                                          // const VerticalDivider(
                                          //   width: 8,
                                          //   thickness: 100,
                                          //   color: Colors.grey,
                                          // )
                                        ],
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: widget.maxWidth - 64,
                              height: 1,
                              color: cloudSoftDeepWhite,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            HtmlWidget(
                              products[index].tagline,
                              customStylesBuilder: (element) {
                                if (element.localName == "h1") {
                                  return {
                                    'font-family': 'Krungsri Condensed',
                                    'font-size': '16px',
                                    'font-weight': '600'
                                  };
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            HtmlWidget(
                              products[index].description,
                              customStylesBuilder: (element) {
                                if (element.localName == "p") {
                                  return {
                                    'font-family': 'Krungsri Condensed',
                                    'font-size': '10px',
                                    'font-weight': '400',
                                    'line-height': '16px'
                                  };
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Visibility(
                              visible: products[index].discountPrice != 0,
                              child: Row(
                                children: [
                                  AlvaText(
                                    title: NumberFormat.decimalPattern().format(products[index].discountPrice),
                                    textStyle: AlvaStyles().bodySize14W400MutedLine(),
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  AlvaText(
                                    title: "บาท",
                                    textStyle: AlvaStyles().bodySize14W400Muted(),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    AlvaText(
                                      title: NumberFormat.decimalPattern().format(products[index].price),
                                      textStyle: products[index].discountPrice == 0
                                          ? AlvaStyles().headingSize22(BTN_SELECTED_TEXT_COLOR_NEW)
                                          : AlvaStyles().headingSize22(RedWordShow),
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        AlvaText(
                                          title: "บาท",
                                          textStyle: products[index].discountPrice == 0
                                              ? AlvaStyles().headingSize18(BTN_SELECTED_TEXT_COLOR_NEW)
                                              : AlvaStyles().headingSize18(RedWordShow),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: YellowKrungsri, borderRadius: BorderRadius.all(Radius.circular(8))),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 32,
                                      ),
                                      AlvaText(
                                        title: 'สนใจ',
                                        textStyle: AlvaStyles().bodySize14W600(),
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
          );
        });
  }
}
