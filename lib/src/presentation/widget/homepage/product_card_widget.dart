import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart' as intl;
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/safe_get_extension.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
// import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({super.key, required this.maxWidth});

  final double maxWidth;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  List<int> counter = [];

  String cleanHtml(String text) {
    String temp = text;

    temp = temp.replaceAll("<p>", "");
    temp = temp.replaceAll("</p>", "<br>");

    temp = temp.replaceAll("<h1>", "<b>");
    temp = temp.replaceAll("<h2>", "<b>");
    temp = temp.replaceAll("<h3>", "<b>");
    temp = temp.replaceAll("<h4>", "<b>");

    temp = temp.replaceAll("</h1>", "</b><br>");
    temp = temp.replaceAll("</h2>", "</b><br>");
    temp = temp.replaceAll("</h3>", "</b><br>");
    temp = temp.replaceAll("</h4>", "</b><br>");

    return temp;
  }

  @override
  void initState() {
    super.initState();

    // setState(() {
    //   counter = [for (int i = 0; i < widget.productList.products!.length; i++) 1];
    // });
  }

  @override
  Widget build(BuildContext context) {
    // var productList = widget.productList;
    // var products = productList.products;

    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        var productList = state.productList;
        var products = state.productList.products;

        return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productList.products?.length,
            itemBuilder: (BuildContext context, int index) {
              late final PageController pageViewController = PageController(initialPage: 0);
              return GestureDetector(
                onTap: () {
                  context.read<ProductDetailBloc>().add(SetProduct(product: products[index]));
                  Navigator.pushNamed(
                      context, '${Routes.productDetail.toStringPath()}?pid=${products[index].productId}');
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
                      GestureDetector(
                        onTap: () {
                          context.read<ViewImgDetailPageSwitchBloc>().add(SwitchPageAction(statePage: true));
                          context.read<ProductDetailCarouselScrollControllerBloc>().add(CarouselScrollAction(index: 0));
                          context.read<PreviousScaleBloc>().add(const PreviousScaleEvent(previousScale: 0.5));
                        },
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 16.0 / 9.0,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
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
                                width: 41,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: cloudyWhite.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    "${counter.get(index) == null ? "1" : counter[index]}/ ${products?[index].productionAssets.length}",
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
                                Text(
                                  products[index].productName,
                                  style: AlvaStyles().headingSize22Height32(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Visibility(
                                  visible: products[index].promotionTag.isEmpty ? false : true,
                                  child: Row(
                                    children: products[index]
                                        .promotionTag
                                        .map((tag) => Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                                  child: AlvaText(
                                                    title: tag,
                                                    textStyle: AlvaStyles().headingSize10w500(spaceGrey),
                                                  ),
                                                ),

                                                // add srperator exclude tail
                                                if (products[index].promotionTag.indexOf(tag) !=
                                                    products[index].promotionTag.length - 1)
                                                  const Text(
                                                    "| ",
                                                    style: TextStyle(color: cloudSoftDeepWhite),
                                                  )
                                                // const VerticalDivider(
                                                //   width: 8,
                                                //   thickness: 100,
                                                //   color: Colors.grey,
                                                // )
                                              ],
                                            ))
                                        .toList(),
                                  ),
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
                                Visibility(
                                  visible: products[index].tagline == "" ? false : true,
                                  child: HtmlWidget(
                                    "<p>${cleanHtml(products[index].tagline)}</p>",
                                    customStylesBuilder: (element) {
                                      if (element.localName == "p") {
                                        return {
                                          'font-family': 'Krungsri Condensed',
                                          'font-size': '10px',
                                          'font-weight': '400',
                                          'color': '#5A5A5A',
                                          'max-lines': '4',
                                          'text-overflow': 'ellipsis'
                                        };
                                      } else if (element.localName == "b") {
                                        return {
                                          'font-family': 'Krungsri Condensed',
                                          'font-size': '16px',
                                          'font-weight': '600',
                                          'color': '#2C2626'
                                        };
                                      } else {
                                        return {
                                          'font-family': 'Krungsri Condensed',
                                          'font-size': '10px',
                                          'font-weight': '400',
                                          'color': '#5A5A5A',
                                          'max-lines': '4',
                                          'text-overflow': 'ellipsis'
                                        };
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Visibility(
                                  visible: products[index].discountPrice != 0,
                                  child: Row(
                                    children: [
                                      AlvaText(
                                        title: intl.NumberFormat.decimalPattern().format(products[index].discountPrice),
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
                                          title: intl.NumberFormat.decimalPattern().format(products[index].price),
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
                                            textStyle: AlvaStyles().bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW),
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
