import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/connectivity_status/connectivity_status_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/scroll_product_detail/scroll_product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

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

  // late TabController _tabController;
  late final TabController _tabController;
  late double maxWidth, maxHeight;
  int? installmentPerMonth, month;
  String? downPaymentPercent, interestRate;

  @override
  void dispose() {
    _tabController.dispose();
    pageViewController.dispose();
    // BlocProvider.of<ProductDetailCarouselScrollControllerBloc>(context).close();
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
    // -------------------------bypass-------------------------------------------------------
    context.read<CheckBrowserBloc>().add(GetBrowserClient(context: context));
// -------------------------bypass-------------------------------------------------------
  }

  int indicator = 1;
  double _scale = 1.0;
  // double _previousScale = 0.5;
  double? x;
  double? y;

  // TapUpDetails? _doubleTapDetails;
  bool viewPhoto = false;
  bool isZoom = false;
  Future<void> openLine() async {
    final Uri deepLink = Uri.parse(HomeConst().lineOAURL);
    if (!await launchUrl(deepLink)) {
      throw Exception('Could not launch $deepLink');
    }
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<ConnectivityStatusBloc, ConnectivityStatusState>(
      builder: (context, errorNWState) {
        if (errorNWState is NoInternet) {
          return ErrorScreen(
            title: ErrorConst().titleNS,
            subTitle: ErrorConst().subTitleNS,
            titleBtn: ErrorConst().titleBtnNS,
            onTap: () {},
          );
        } else {
          return BlocBuilder<CheckBrowserBloc, CheckBrowserState>(
            builder: (context, checkBrowserState) {
              if (checkBrowserState is CheckBrowserLoading) {
                return const LoadingScreen();
              } else if (checkBrowserState is BrowserIsNotLineLiff) {
                return ErrorScreen(
                  title: ErrorConst().titleBrowser,
                  subTitle: ErrorConst().subTitleBrowser,
                  titleBtn: ErrorConst().titleBtnBrowser,
                  onTap: () {
                    openLine();
                  },
                );
              } else {
                return BlocBuilder<ScrollProductDetailBloc, ScrollProductDetailState>(
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
                                        ? viewImagePage(carouselState, context, zoomState, previousState)
                                        : productDetailPage(
                                            stateAppBar,
                                            context,
                                            carouselState,
                                          );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  AlvaRootWidget productDetailPage(
      ScrollProductDetailState stateAppBar, BuildContext context, PageController carouselState) {
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
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16.0 / 9.0,
                          child: PageView.builder(
                              itemCount: 5,
                              // pageSnapping: true,
                              controller: carouselState,
                              // allowImplicitScrolling: true,
                              onPageChanged: (val) {
                                context
                                    .read<ProductDetailCarouselScrollControllerBloc>()
                                    .add(CarouselScrollAction(index: val));
                                // context
                                //     .read<ProductDetailCarouselScrollControllerBloc>()
                                //     .add(CarouselScrollAction());
                                if (val + 1 == 5) {
                                  carouselState.jumpToPage(0);
                                  // if (val == state.selectedCarDetail.carImage!.length) {
                                  //   context.read<CarListBloc>().add(const SetFixibleCurrentNumberActiveImage(1));
                                  //   pageViewController.jumpToPage(0);
                                  // } else {
                                  //   context.read<CarListBloc>().add(SetCurrentNumberActiveImage(val));
                                  // }
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
                                        log("page ${carouselState.page}");
                                        // carouselState.jumpToPage(0);
                                      },
                                      child: Hero(
                                        tag: 'herousel',
                                        createRectTween: (Rect? begin, Rect? end) {
                                          return MaterialRectCenterArcTween(begin: begin, end: end);
                                        },
                                        child: AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: SizedBox(
                                              width: maxWidth,
                                              height: 576,
                                              child: Image.asset('assets/mockimg/product.png', fit: BoxFit.fitWidth)),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
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
                              color: cloudyWhite.withOpacity(0.8),
                            ),
                            child: Center(
                              child: AlvaText(
                                  title: "${carouselState.initialPage + 1}/5",
                                  textStyle: AlvaStyles().headingSize10w500(ModernDarkGray)),
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
                        ))
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
                            visible: true,
                            child: Hero(
                              tag: 'herousel-indicator',
                              createRectTween: (Rect? begin, Rect? end) {
                                return MaterialRectCenterArcTween(begin: begin, end: end);
                              },
                              child: SmoothPageIndicator(
                                  controller: carouselState,
                                  count: 5,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: maxWidth - 32,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AlvaText(
                                title: 'Pulsar Plus',
                                textStyle: AlvaStyles().headingSize22w700(ModernDarkGray),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    child: AlvaText(
                                      title: 'ติดตั้งฟรี',
                                      textStyle: AlvaStyles().headingSize10w500(spaceGrey),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 16,
                                    color: cloudSoftDeepWhite,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      child: AlvaText(
                                        title: 'รับประกัน 3 ปี',
                                        textStyle: AlvaStyles().headingSize10w500(spaceGrey),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 16,
                                    color: cloudSoftDeepWhite,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      child: AlvaText(
                                        title: 'สิทธิพิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้ ',
                                        textStyle: AlvaStyles().headingSize10w500(spaceGrey),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
                              AlvaText(
                                title: 'แกร่งขึ้น ง่ายขึ้น สมาร์ทขึ้น',
                                textStyle: AlvaStyles().headingSize16w500(ModernDarkGray),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              AlvaText(
                                title:
                                    'เครื่องชาร์จรถยนต์ไฟฟ้าสไตล์มินิมอล ที่ทรงพลังในขนาดกะทัดรัด สามารถติดตั้งได้กับโรงจอดรถหลายสไตล์เหมาะกับการชาร์จรถยนต์ไฟฟ้าที่บ้านทุกวันอีกทั้งยังสามารถเพิ่มประสิทธิภาพการทำงานของเครื่องชาร์จได้อย่างเต็มที่ผ่านการใช้งานร่วมกับ myWallbox Application',
                                textStyle: AlvaStyles().headingSize10w400(spaceGrey),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  AlvaText(
                                    title: '${56640.toDecimalFormat()} บาท',
                                    textStyle: AlvaStyles().headingSize22w700(RedWordShow),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    // margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    decoration: BoxDecoration(color: RedSoft, borderRadius: BorderRadius.circular(4)),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      child: AlvaText(
                                        title: 'ถูกลง 4 %',
                                        textStyle: AlvaStyles().headingSize10w700(RedWordShow),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AlvaText(
                                title: '${56640.toDecimalFormat()} บาท',
                                textStyle: AlvaStyles().discountPriceTxt14w400(smockGrey),
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
                            key: Key("car_detail_tab_view"),
                            text: "ข้อมูลทั่วไป",
                          ),
                          Tab(key: Key("free_text_tab_view"), text: "รายละเอียดอื่นๆ"),
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

  Scaffold viewImagePage(
      PageController carouselState, BuildContext context, TransformationController zoomState, double previousState) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Hero(
                  tag: 'herousel',
                  createRectTween: (Rect? begin, Rect? end) {
                    return MaterialRectCenterArcTween(begin: begin, end: end);
                  },
                  child: GestureDetector(
                    onDoubleTapDown: (TapDownDetails detail) {
                      // _handleDoubleTap(detail);
                      context.read<ImgGalleryZoomBloc>().add(ZoomImageAction(details: detail));
                      if (previousState > 0.6) {
                        // _previousScale = 0.5;
                        context.read<PreviousScaleBloc>().add(const PreviousScaleEvent(previousScale: 0.5));
                      } else {
                        // _previousScale = 0.8;
                        context.read<PreviousScaleBloc>().add(const PreviousScaleEvent(previousScale: 0.8));
                      }
                      // if(isZoom){
                      //   isZoom = false;
                      // }else{
                      //   isZoom = true;
                      // }
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
                        // log("_previousScale ${_previousScale}");
                        // log("_previousScale ${_previousScale > 0.6}");
                      },
                      child: AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: PageView.builder(
                            itemCount: 5,
                            physics: previousState > 0.5 ? const NeverScrollableScrollPhysics() : const ScrollPhysics(),
                            controller: carouselState,
                            onPageChanged: (val) {
                              context
                                  .read<ProductDetailCarouselScrollControllerBloc>()
                                  .add(CarouselScrollAction(index: val));

                              if (val + 1 == 5) {
                                carouselState.jumpToPage(0);
                              }
                            },
                            itemBuilder: (ctx, i) {
                              return AspectRatio(
                                aspectRatio: 16 / 9,
                                child: SizedBox(
                                    width: maxWidth,
                                    height: 576,
                                    child: Image.asset('assets/mockimg/product.png', fit: BoxFit.fitWidth)),
                              );
                            }),
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<ViewImgDetailPageSwitchBloc>().add(SwitchPageAction(statePage: false));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
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
                      child: const Row(
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
                        visible: true,
                        child: Hero(
                          tag: 'herousel-indicator',
                          createRectTween: (Rect? begin, Rect? end) {
                            return MaterialRectCenterArcTween(begin: begin, end: end);
                          },
                          child: SmoothPageIndicator(
                              controller: carouselState,
                              count: 5,
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
              ],
            ),
          )
          // Center(
          //   child: state.selectedCarDetail.carImage!.length > 1
          //       ? Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Container(
          //         color: whitePure,
          //         width: maxWidth,
          //         padding:
          //         const EdgeInsets.only(top: 12.0, bottom: 12.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Visibility(
          //               visible: true,
          //               child: SmoothPageIndicator(
          //                   controller: pageViewController,
          //                   count: 5,
          //                   effect:  const ExpandingDotsEffect(
          //                     expansionFactor: 2,
          //                     dotHeight: 6,
          //                     dotWidth: 6,
          //                     activeDotColor: BlueFantasy,
          //                     dotColor: cloudSoftDeepWhite,
          //                   )),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   )
          //       : Container(),
          // ),
        ],
      )),
    );
  }
}

extension NumberConverter on int {
  String toDecimalFormat() {
    return NumberFormat.decimalPattern().format(this);
  }
}
