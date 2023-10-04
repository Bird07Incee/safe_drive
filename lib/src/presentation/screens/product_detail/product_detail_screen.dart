import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:marketplace_line_oa/main.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/custom_tap_down_details.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/model/product_detail/product_detail_args.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/scroll_product_detail/scroll_product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_detail/product_detail_bottom_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_detail/product_detail_top_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with TickerProviderStateMixin {
  final oCcy = NumberFormat("#,##0", "en_US");
  late RouteSettings? settings;
  final scrollController = ScrollController();
  late PageController pageViewController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  late final TabController _tabController;
  late double maxWidth, maxHeight;
  int? installmentPerMonth, month;
  String? downPaymentPercent, interestRate;

  GlobalKey stickyKey = GlobalKey();

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
  String pid = '';
  late Product product;
  late Widget topSection = SizedBox();
  late Widget bottomSection = SizedBox();

  //List dataCarouselMock = carouselSingleItem;
  @override
  Widget build(BuildContext context) {
    int imageDataLength = 1;
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;
    settings = ModalRoute.of(context) != null ? ModalRoute.of(context)!.settings : null;
    if (settings != null) {
      var uriData = Uri.parse(settings!.name!);
      var routingData = RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
      if (routingData.route == "/productDetail") {
        pid = (routingData["pid"] == null) ? "" : routingData["pid"];
      }
      print("routingData route: ${routingData.route}");
      print("routingData queryParams: ${routingData.queryParameters}");
      print("settings!.name : ${settings!.name}");
      print("pid : $pid");
    }
    return RootPageCondition(
      child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listener: (context, state) {
          if (state.status.isSuccess && pid != "") {
            product = state.product;
            print('get product success');
            print('product id : ${product.productId}, productName: ${product.productName}');
            imageDataLength = product.productionAssets.length == 1
                ? product.productionAssets.length
                : product.productionAssets.length > 20
                    ? 20
                    : product.productionAssets.length;
          }
        },
        builder: (context, pdState) {
          if (pdState.status.isInitial && pid != "") {
            context.read<ProductDetailBloc>().add(GetProductByID(pid: pid));
          }
          if (pdState.status.isSuccess) {
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
                                    ? viewImagePage(carouselState, context, zoomState, previousState, imageDataLength)
                                    : productDetailPage(stateAppBar, context, carouselState, imageDataLength);
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
          } else if (pdState.status.isLoading) {
            return const LoadingScreen();
          } else {
            return ErrorScreen(
              title: ErrorConst().titleNS,
              subTitle: ErrorConst().subTitleNS,
              titleBtn: ErrorConst().titleBtnNS,
              onTap: () {
                if (pdState.status.isInitial && pid != "") {
                  context.read<ProductDetailBloc>().add(GetProductByID(pid: pid));
                }
              },
            );
          }
        },
      ),
    );
  }

  void onBack() {
    var stack = CurrentRouteObserver.instance.stack;
    print('route stack : $stack');
    if (stack.contains(Routes.initial.toStringPath())) {
      Navigator.pop(context);
    } else {
      Navigator.popAndPushNamed(context, Routes.initial.toStringPath());
    }
    context.read<ProductDetailCarouselScrollControllerBloc>().add(const CarouselScrollAction(index: 0));
    context.read<ScrollProductDetailBloc>().add(ProductDetailScrollAction(0, context, "1"));
  }

  WillPopScope productDetailPage(
      ScrollProductDetailState stateAppBar, BuildContext context, PageController carouselState, int imageDataLength) {
    return WillPopScope(
      onWillPop: () async {
        onBack();
        return true;
      },
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          return AlvaRootWidget(
              titlePage: titleWebPage,
              appBar: stateAppBar.appBarCarDetailStatus
                  ? AppBar(
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        key: const Key("pop_navigator_to_home_page"),
                        onPressed: () {
                          onBack();
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                      ),
                      leadingWidth: 60,
                      titleSpacing: 0,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AlvaTextMaxLinesOverflow(
                              title: state.product.productName,
                              maxLines: 1,
                              textStyle: AlvaStyles()
                                  .headingSize12w600(BTN_SELECTED_TEXT_COLOR_NEW)
                                  .copyWith(fontWeight: FontWeight.w500, height: 1.17)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AlvaText(
                                  title: state.product.price.toDecimalFormat(),
                                  textStyle: AlvaStyles().heading1().copyWith(
                                      color:
                                          state.product.discountPrice > 0 ? RedWordShow : BTN_SELECTED_TEXT_COLOR_NEW,
                                      height: 1.33)),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1),
                                child: AlvaText(
                                    title: ' บาท',
                                    textStyle: AlvaStyles()
                                        .heading2(
                                            state.product.discountPrice > 0 ? RedWordShow : BTN_SELECTED_TEXT_COLOR_NEW)
                                        .copyWith(height: 1.33)),
                              ),
                            ],
                          )
                        ],
                      ),
                      centerTitle: false,
                    )
                  : AppBar(
                      title: AlvaText(
                          title: "ข้อมูลสินค้า",
                          textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                      titleSpacing: 0,
                      leadingWidth: 60,
                      centerTitle: false,
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                          key: const Key("pop_navigator_to_home_page"),
                          onPressed: () {
                            onBack();
                          },
                          icon: const Icon(Icons.arrow_back_ios_rounded)),
                    ),
              bottomSheet: Container(
                color: whitePure,
                width: maxWidth,
                height: 96,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '${Routes.selectOptions.toStringPath()}?pid=${state.product.productId}',
                                arguments: ProductDetailArgs(product: state.product));
                          },
                          style: AlvaStyles()
                              .outlineNoneBorderButtonStyle(YellowKrungsri, Colors.transparent, isRadius8: true),
                          child: Text("สั่งซื้อสินค้า",
                              style: AlvaStyles().headingSize16w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // child: ProductDetailBody(),
              child: Container(
                padding: const EdgeInsets.only(bottom: 96),
                color: backgroundNo2,
                child: ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  children: [
                    PDTopSection(),
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
                    PDBottomSection()
                  ],
                ),
              ));
        },
      ),
    );
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
        return false;
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
                                  child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                                    builder: (context, state) {
                                      return FadeInImage(
                                        placeholder: AssetImage(ProductDetailConst().imgDefaultPath),
                                        image: NetworkImage(
                                          i == imageDataLength
                                              ? state.product.productionAssets[0]
                                              : state.product.productionAssets[i],
                                        ),
                                        // image: NetworkImage(
                                        //   i == imageDataLength
                                        //       ? dataCarouselMock[0].substring(46)
                                        //       : dataCarouselMock[i].substring(46),
                                        // ),
                                        fit: BoxFit.fitWidth,
                                        imageErrorBuilder: (context, error, stackTrace) =>
                                            Image.asset(ProductDetailConst().imgDefaultPath, fit: BoxFit.fitWidth),
                                      );
                                    },
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
                          children: const [
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
