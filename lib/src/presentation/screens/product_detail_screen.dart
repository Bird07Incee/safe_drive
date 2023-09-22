import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/custom_tap_down_details.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/scroll_product_detail/scroll_product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_detail/product_detail_top_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with TickerProviderStateMixin {
  final oCcy = NumberFormat("#,##0", "en_US");
  final scrollController = ScrollController();
  late PageController pageViewController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  late final TabController _tabController;
  late double maxWidth, maxHeight;
  int? installmentPerMonth, month;
  String? downPaymentPercent, interestRate;

  @override
  void dispose() {
    _tabController.dispose();
    pageViewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailCarouselScrollControllerBloc>().add(const CarouselScrollAction(index: 0));
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    scrollController.addListener(() {
      var pixelScreen = scrollController.position.pixels;
      context.read<ScrollProductDetailBloc>().add(ProductDetailScrollAction(pixelScreen, context, "0"));
    });
  }

  int indicator = 1;
  double _scale = 1.0;

  List dataCarouselMock = carouselSingleItem;

  @override
  Widget build(BuildContext context) {
    int imageDataLength = dataCarouselMock.length == 1
        ? dataCarouselMock.length
        : dataCarouselMock.length > 20
            ? 20
            : dataCarouselMock.length;
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;
    return RootPageCondition(
      child: BlocBuilder<ScrollProductDetailBloc, ScrollProductDetailState>(
        builder: (ctx, stateAppBar) {
          return BlocBuilder<ImgGalleryZoomBloc, TransformationController>(
            builder: (context, zoomState) {
              return BlocBuilder<PreviousScaleBloc, double>(
                builder: (context, previousState) {
                  return BlocBuilder<ViewImgDetailPageSwitchBloc, bool>(
                    builder: (context, switchState) {
                      return BlocBuilder<ProductDetailCarouselScrollControllerBloc, PageController>(
                        builder: (context, carouselState) {
                          return switchState
                              ? viewImagePage(carouselState, context, zoomState, previousState, imageDataLength)
                              : productDetailPage(stateAppBar, context, carouselState, imageDataLength, zoomState);
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  AlvaRootWidget productDetailPage(ScrollProductDetailState stateAppBar, BuildContext context,
      PageController carouselState, int imageDataLength, TransformationController zoomState) {
    return AlvaRootWidget(
        titlePage: titleWebPage,
        appBar: stateAppBar.appBarCarDetailStatus
            ? AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  key: const Key("pop_navigator_to_home_page"),
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<ScrollProductDetailBloc>().add(ProductDetailScrollAction(0, context, "1"));
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                leadingWidth: 60,
                titleSpacing: 0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AlvaText(title: 'Pulsar MAX', textStyle: AlvaStyles().headingSize12w700(ModernDarkGray)),
                    AlvaTextMaxLinesOverflow(
                        title: '${45900.toDecimalFormat()} บาท',
                        maxLines: 1,
                        textStyle: AlvaStyles().heading2(RedWordShow))
                  ],
                ),
                centerTitle: false,
              )
            : AppBar(
                title: AlvaText(
                    title: "ข้อมูลสินค้า", textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                titleSpacing: 0,
                leadingWidth: 60,
                centerTitle: false,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    key: const Key("pop_navigator_to_home_page"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
        bottomSheet: SizedBox(
          width: maxWidth,
          height: 96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: maxWidth - 32,
                height: 40,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: AlvaStyles().outlineNoneBorderButtonStyle(YellowKrungsri, Colors.transparent),
                  child:
                      AlvaText(title: "ยอมรับ", textStyle: AlvaStyles().headingSize16w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                ),
              ),
            ],
          ),
        ),
        child: Container(
          color: backgroundNo2,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            children: [
              const PDTopSection(),
              // AlvaText(title: 'รายละเอียดสินค้า',textStyle: AlvaStyles().headingSize16w500(ModernDarkGray),)
              const SizedBox(
                height: 16,
              ),
              Container(
                width: maxWidth - 32,
                // height: 520,
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
                            padding: const EdgeInsets.all(16),
                            child: AlvaText(
                              title: 'รายละเอียดสินค้า',
                              textStyle: AlvaStyles().headingSize16w500(ModernDarkGray),
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
                          // context.read<CarListBloc>().add(SetSelectedTabIndex(index));
                          // if (index == 1) {
                          //   analyticHelper.logClickDetailInfoUsedCarDetailScreen(
                          //       carListState.selectedCarDetail.partnerName.toString());
                          // } else if (index == 0) {
                          //   analyticHelper.logClickGeneralInfoUsedCarDetailScreen(
                          //       carListState.selectedCarDetail.partnerName.toString());
                          // }
                          log("TapBar index $index");
                        },
                        tabs: const [
                          Tab(
                            text: "ข้อมูลทั่วไป",
                          ),
                          Tab(text: "รายละเอียดอื่นๆ"),
                        ]),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 344,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget viewImagePage(PageController carouselState, BuildContext context, TransformationController zoomState,
      double previousState, int imageDataLength) {
    backButtontoDetail() {
      log("backButtontoDetail");
      context.read<ViewImgDetailPageSwitchBloc>().add(SwitchPageAction(statePage: false));
      context
          .read<ProductDetailCarouselScrollControllerBloc>()
          .add(CarouselScrollAction(index: carouselState.initialPage));
      context.read<PreviousScaleBloc>().add(const PreviousScaleEvent(previousScale: 0.5));
      if (zoomState.value != Matrix4.identity()) {
        context.read<ImgGalleryZoomBloc>().add(ZoomImageAction(details: customTapDownDetails(const Offset(100, 100))));
      }
    }

    return WillPopScope(
      onWillPop: () async {
        backButtontoDetail();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: GestureDetector(
                    onDoubleTapDown: (TapDownDetails detail) {
                      context.read<ImgGalleryZoomBloc>().add(ZoomImageAction(details: detail));
                      if (previousState > 0.5) {
                        context.read<PreviousScaleBloc>().add(const PreviousScaleEvent(previousScale: 0.5));
                      } else {
                        context.read<PreviousScaleBloc>().add(const PreviousScaleEvent(previousScale: 0.8));
                      }
                    },
                    child: InteractiveViewer(
                      transformationController: zoomState,
                      panEnabled: true,
                      minScale: 0.5,
                      maxScale: 5.0,
                      scaleEnabled: true,
                      onInteractionUpdate: (ScaleUpdateDetails details) {
                        _scale = previousState * details.scale;
                      },
                      onInteractionEnd: (ScaleEndDetails details) {
                        context
                            .read<PreviousScaleBloc>()
                            .add(PreviousScaleEvent(previousScale: _scale.clamp(0.5, 5.0)));
                      },
                      child: AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: PageView.builder(
                            itemCount: imageDataLength == 1 ? imageDataLength : imageDataLength + 1,
                            physics:
                                previousState == 0.5 ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
                            controller: carouselState,
                            onPageChanged: (val) {
                              context
                                  .read<ProductDetailCarouselScrollControllerBloc>()
                                  .add(CarouselScrollAction(index: val));

                              if (val == imageDataLength && val != 1) {
                                carouselState.jumpToPage(0);
                              }
                            },
                            itemBuilder: (ctx, i) {
                              return AspectRatio(
                                aspectRatio: 16 / 9,
                                child: SizedBox(
                                  width: maxWidth,
                                  height: 576,
                                  child: FadeInImage(
                                    placeholder: AssetImage(ProductDetailConst().imgDefaultPath),
                                    image: NetworkImage(
                                      i == imageDataLength
                                          ? dataCarouselMock[0]
                                          : dataCarouselMock[i],
                                    ),
                                    // image: NetworkImage(
                                    //   i == imageDataLength
                                    //       ? dataCarouselMock[0].substring(46)
                                    //       : dataCarouselMock[i].substring(46),
                                    // ),
                                    fit: BoxFit.fitWidth,
                                    imageErrorBuilder: (context, error, stackTrace) =>
                                        Image.asset(ProductDetailConst().imgDefaultPath, fit: BoxFit.fitWidth),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                backButtontoDetail();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: spaceGrey123,
                        ),
                        width: 40,
                        height: 32,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 14,
                            ),
                            Icon(
                              Icons.arrow_back_ios,
                              color: whitePure,
                              size: 16,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: maxWidth,
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: imageDataLength == 1 ? false : true,
                          child: SmoothPageIndicator(
                              controller: carouselState,
                              count: imageDataLength <= carouselShowLimit ? imageDataLength : carouselShowLimit,
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
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
