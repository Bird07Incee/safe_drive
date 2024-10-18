import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:marketplace_line_oa/main.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/custom_tap_down_details.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/product_detail/product_detail_args.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/home/home_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/produc_detail_tagline_toggle/product_detail_description_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/scroll_product_detail/scroll_product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/home_scroll_controller_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_options/product_options_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/disclaimer_bottom_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_detail/product_detail_bottom_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_detail/product_detail_top_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with TickerProviderStateMixin {
  final oCcy = NumberFormat("#,##0", "en_US");
  late RouteSettings? settings;
  final scrollController = ScrollController();
  // late PageController pageViewController = PageController(
  //   viewportFraction: 1,
  //   keepPage: true,
  // );

  late final TabController _tabController;
  late double maxWidth, maxHeight;
  int? installmentPerMonth, month;
  String? downPaymentPercent, interestRate;
  int indicator = 1;
  double _scale = 1.0;
  String pid = '';
  GlobalKey stickyKey = GlobalKey();
  bool isLoaded = false;
  bool logAmplitudeSuccess = false;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // var product = context.read<ProductListBloc>().state;
    // product.productList.products!.clear();
    context.read<ProductDetailCarouselScrollControllerBloc>().add(const CarouselScrollAction(index: 0));
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    // scrollController.addListener(() {
    //   var pixelScreen = scrollController.position.pixels;
    //   context.read<ScrollProductDetailBloc>().add(ProductDetailScrollAction(pixelScreen, MediaQuery.of(context).size.width, "0"));
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      isLoaded = true;
      loadProduct();
      // hideOneTrustCookieScript();
    }
  }

  loadProduct() {
    settings = ModalRoute.of(context)?.settings;
    if (settings != null) {
      var uriData = Uri.parse(settings!.name!);
      var routingData = RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
      pid = (routingData["pid"] == null) ? "" : routingData["pid"];
      ProductDetailState pdState = context.read<ProductDetailBloc>().state;
      if (pdState.status.isInitial && pid != "") {
        context.read<ProductDetailBloc>().add(GetProductByID(pid: pid));
      }
    }
  }

  showOutOfStockDialog(ProductDetailState pdState) async {
    await GeneralDialog(onAccept: () async {
      onBack(isFromOutOfStockDialog: true);
    }).showOutOfStockDialog(context: context, canBack: true, productNameTitle: pdState.product.productName).then((_) {
      if (mounted) {
        var stack = CurrentRouteObserver.instance.stack;
        if (stack.contains(Routes.initial.toStringPath())) {
          context.read<HomeCubit>().updateTab(selectedTab: 0);
          context.read<HomeScrollControllerCubit>().updateScrollController(scrollControllerPosition: 0);
          context.read<ProductListBloc>().add(const GetProductList());
          Navigator.pop(context);
        } else {
          Navigator.popAndPushNamed(context, Routes.initial.toStringPath());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;

    return RootPageCondition(
      child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listener: (context, pdState) {
          if (pdState.status.isSuccess) {
            if (!logAmplitudeSuccess && ModalRoute.of(context)!.settings.name!.contains(Routes.productDetail.toStringPath())) {
              AmplitudeWebHelper.getInstance().logEnterProductDetails(
                  productName: pdState.product.productName, contentId: pdState.product.productId, merchantName: pdState.product.merchantFullName);
            }
            if (pdState.product.quantity == 0 && ModalRoute.of(context)!.settings.name!.contains(Routes.productDetail.toStringPath())) {
              showOutOfStockDialog(pdState);
            }
          }
        },
        builder: (context, pdState) {
          if (pdState.status.isSuccess) {
            return BlocBuilder<ImgGalleryZoomBloc, TransformationController>(
              builder: (context, zoomState) {
                return BlocBuilder<PreviousScaleBloc, double>(
                  builder: (context, previousState) {
                    return BlocBuilder<ViewImgDetailPageSwitchBloc, bool>(
                      builder: (context, switchState) {
                        return BlocBuilder<ProductDetailCarouselScrollControllerBloc, PageController>(
                          builder: (context, carouselState) {
                            return switchState
                                ? viewImagePage(carouselState, context, zoomState, previousState, pdState)
                                : productDetailPage(carouselState, context, pdState);
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
                if ((pdState.status.isInitial || pdState.status.isError) && pid != "") {
                  context.read<ProductDetailBloc>().add(GetProductByID(pid: pid));
                }
              },
            );
          }
        },
      ),
    );
  }

  void onBack({isFromOutOfStockDialog = false}) {
    showOneTrustCookieScript();
    AmplitudeWebHelper.getInstance().logeMarketplaceHomePageHomeScreen();

    if (!isFromOutOfStockDialog) {
      var stack = CurrentRouteObserver.instance.stack;
      if (stack.contains(Routes.initial.toStringPath())) {
        Navigator.pop(context);
      } else {
        Navigator.popAndPushNamed(context, Routes.initial.toStringPath());
      }
    }

    context.read<ProductOptionBloc>().updateStepOneVariables(
          groupValueRadio: "",
          price: 0,
          indexSelect: 0,
        );
    context.read<ProductOptionBloc>().updateStepTwoVariables(
          groupValueRadio: "",
          price: 0,
          indexSelect: 0,
        );
    context.read<ProductOptionBloc>().updateSelectCurrentOption(0);
    context.read<ProductOptionBloc>().updateLastOption(0);
    context.read<ProductDetailCarouselScrollControllerBloc>().add(const CarouselScrollAction(index: 0));
    context.read<ScrollProductDetailBloc>().add(ProductDetailScrollAction(0, MediaQuery.of(context).size.width, "1"));
  }

  PopScope productDetailPage(PageController pageController, BuildContext context, ProductDetailState pdState) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) {
            return;
          }
          if (context.mounted) {
            onBack();
          }
        },
        child: AlvaRootWidget(
          titlePage: titleWebPage,
          appBar: BlocBuilder<ScrollProductDetailBloc, ScrollProductDetailState>(builder: (ctx, stateAppBar) {
            return stateAppBar.appBarCarDetailStatus
                ? AppBar(
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      key: const Key("pop_navigator_to_home_page"),
                      onPressed: () {
                        onBack();
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                    leadingWidth: 48,
                    titleSpacing: 0,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AlvaTextMaxLinesOverflow(
                            title: pdState.product.productName,
                            maxLines: 1,
                            textStyle:
                                AlvaStyles().headingSize12w600(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(fontWeight: FontWeight.w500, height: 1.17)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AlvaText(
                                title: pdState.product.discountPrice == 0
                                    ? pdState.product.price.toDecimalFormat()
                                    : pdState.product.discountPrice.toDecimalFormat(),
                                textStyle: AlvaStyles().heading1().copyWith(color: BTN_SELECTED_TEXT_COLOR_NEW, height: 1.33)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 1, top: 2),
                              child: AlvaText(title: ' บาท', textStyle: AlvaStyles().heading2(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 1.33)),
                            ),
                          ],
                        )
                      ],
                    ),
                    centerTitle: false,
                  )
                : AppBar(
                    title: AlvaText(title: "ข้อมูลสินค้า", textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                    titleSpacing: 0,
                    leadingWidth: 48,
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                        key: const Key("pop_navigator_to_home_page"),
                        onPressed: () {
                          onBack();
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded)),
                  );
          }),
          bottomSheet: Container(
            decoration: BoxDecoration(
              color: whitePure,
              boxShadow: [
                BoxShadow(color: const Color(0xff000000).withOpacity(0.04), spreadRadius: 0, blurRadius: 16, offset: const Offset(0, -4)),
              ],
            ),
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
                        AmplitudeWebHelper.getInstance().logTapOnPurchaseButton(
                            productName: pdState.product.productName,
                            contentId: pdState.product.productId,
                            merchantName: pdState.product.merchantFullName,
                            price: pdState.product.price.toDecimalFormat().toString(),
                            discountPrice: pdState.product.discountPrice.toDecimalFormat().toString());
                        context.read<ProductOptionBloc>().updateStepOneVariables(
                              groupValueRadio: "",
                              price: 0,
                              indexSelect: 0,
                            );
                        context.read<ProductOptionBloc>().updateStepTwoVariables(
                              groupValueRadio: "",
                              price: 0,
                              indexSelect: 0,
                            );
                        context.read<ProductOptionBloc>().updateSelectCurrentOption(0);
                        context.read<ProductOptionBloc>().updateLastOption(0);
                        // context.read<ProductDetailBloc>().add(SetProduct(product: pdState.product));
                        if (pdState.product.productionOptionals.isNotEmpty) {
                          Navigator.pushNamed(context, '${Routes.selectOptions.toStringPath()}?pid=${pdState.product.productId}',
                              arguments: ProductDetailArgs(product: pdState.product));
                        } else {
                          Navigator.pushNamed(context, '${Routes.orderSummary.toStringPath()}?pid=${pdState.product.productId}');
                        }
                      },
                      style: AlvaStyles().outlineNoneBorderButtonStyle(YellowKrungsri, Colors.transparent, isRadius8: true),
                      child: Text("สั่งซื้อสินค้า", style: AlvaStyles().headingSize16w700(BTN_SELECTED_TEXT_COLOR_NEW)),
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
            child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
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
                    PDBottomSection(),
                    DisclaimerSection()
                  ],
                )),
          ),
        ));
  }

  Widget viewImagePage(
      PageController pageController, BuildContext context, TransformationController zoomState, double previousState, ProductDetailState pdState) {
    backButtontoDetail() {
      final myBloc = BlocProvider.of<ProductDetailDescriptionCubit>(context);

      myBloc.updateToggleTapDescription(toggleDescription: false);
      if (pdState.clickFromImage == true) {
        Navigator.pop(context);
      }
      context.read<ViewImgDetailPageSwitchBloc>().add(SwitchPageAction(statePage: false));
      context.read<ProductDetailCarouselScrollControllerBloc>().add(CarouselScrollAction(index: pageController.initialPage));
      context.read<PreviousScaleBloc>().add(const PreviousScaleEvent(previousScale: 0.5));
      if (zoomState.value != Matrix4.identity()) {
        context.read<ImgGalleryZoomBloc>().add(ZoomImageAction(details: customTapDownDetails(const Offset(100, 100))));
      }
    }

    int imageLen = pdState.product.productionAssets.length;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        if (context.mounted) {
          backButtontoDetail();
        }
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
                    key: const Key("zoom_image"),
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
                        context.read<PreviousScaleBloc>().add(PreviousScaleEvent(previousScale: _scale.clamp(0.5, 5.0)));
                      },
                      child: AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: PageView.builder(
                            itemCount: imageLen == 1 ? 1 : imageLen + 1,
                            physics: previousState == 0.5 ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
                            controller: pageController,
                            onPageChanged: (val) {
                              context.read<ProductDetailCarouselScrollControllerBloc>().add(CarouselScrollAction(index: val));

                              if (val == imageLen && val != 1) {
                                pageController.jumpToPage(0);
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
                                      i == imageLen ? pdState.product.productionAssets[0] : pdState.product.productionAssets[i],
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
              key: const Key("back_to_detail_button"),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: imageLen > 1 ? true : false,
                  child: Container(
                    width: maxWidth,
                    padding: EdgeInsets.only(bottom: 16),
                    child: Center(
                      child: SmoothPageIndicator(
                          controller: pageController,
                          count: imageLen <= carouselShowLimit ? imageLen : carouselShowLimit,
                          effect: const ExpandingDotsEffect(
                            expansionFactor: 2,
                            dotHeight: 6,
                            dotWidth: 6,
                            activeDotColor: spaceGrey123,
                            dotColor: cloudSoftDeepWhite,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
