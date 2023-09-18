import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({
    super.key,
    required this.maxWidth,
  });

  final double maxWidth;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  var indicator = [
    1,
    1,
    1,
    1,
    1,
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProductListBloc>().add(GetProductListMock(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        final products = state.productList.products;
        return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.productList.products?.length,
            itemBuilder: (BuildContext context, int index) {
              late final PageController pageViewController = PageController(initialPage: 0);
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "productDetail");
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
                                  itemCount: 10,
                                  controller: pageViewController,
                                  onPageChanged: (val) {
                                    setState(() {
                                      indicator[index] = val + 1;
                                    });
                                  },
                                  itemBuilder: (ctx, i) {
                                    return Stack(
                                      children: [
                                        SizedBox(
                                            width: widget.maxWidth,
                                            height: 576,
                                            child: Image.asset('assets/mocking/product.png', fit: BoxFit.fitWidth)),
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
                                  "${indicator[index]}/ 5",
                                  style: const TextStyle(color: whitePure),
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
                                  count: 5,
                                  effect: const ExpandingDotsEffect(
                                    expansionFactor: 2,
                                    dotHeight: 6,
                                    dotWidth: 6,
                                    activeDotColor: spaceGrey123,
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
                                  title: products![index].productName,
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
                                                const Text("|")
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
                                // Html(data: products[index].tagline, style: {
                                //   "body": Style(
                                //       margin: EdgeInsets.zero,
                                //       padding: EdgeInsets.zero),
                                //   "h1": Style(
                                //     padding: EdgeInsets.zero,
                                //     margin: EdgeInsets.zero,
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: const FontSize(16.0),
                                //     fontFamily: 'Krungsri Condensed',
                                //   )
                                // }),
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
                                // Html(
                                //   data: products[index].description,
                                //   style: {
                                //     "body": Style(
                                //         margin: EdgeInsets.zero,
                                //         padding: EdgeInsets.zero),
                                //     "p": Style(
                                //       padding: EdgeInsets.zero,
                                //       margin: EdgeInsets.zero,
                                //       fontWeight: FontWeight.w400,
                                //       fontSize: const FontSize(10.0),
                                //       fontFamily: 'Krungsri Condensed',
                                //       lineHeight: const LineHeight(1.5),
                                //     )
                                //   },
                                // ),
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
      },
    );
  }
}
