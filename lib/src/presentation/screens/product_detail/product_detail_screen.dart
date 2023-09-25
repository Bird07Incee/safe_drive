import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_keys.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/custom_tap_down_details.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/model/product_detail/product_detail_screen_arguments.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/scroll_product_detail/scroll_product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, this.arguments}) : super(key: key);
  final ProductDetailScreenArguments? arguments;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
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
    context
        .read<ProductDetailCarouselScrollControllerBloc>()
        .add(const CarouselScrollAction(index: 0));
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    scrollController.addListener(() {
      var pixelScreen = scrollController.position.pixels;
      context
          .read<ScrollProductDetailBloc>()
          .add(ProductDetailScrollAction(pixelScreen, context, "0"));
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
                      return BlocBuilder<
                          ProductDetailCarouselScrollControllerBloc,
                          PageController>(
                        builder: (context, carouselState) {
                          return switchState
                              ? viewImagePage(carouselState, context, zoomState,
                                  previousState, imageDataLength)
                              : productDetailPage(stateAppBar, context,
                                  carouselState, imageDataLength);
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

  AlvaRootWidget productDetailPage(ScrollProductDetailState stateAppBar,
      BuildContext context, PageController carouselState, int imageDataLength) {
    return AlvaRootWidget(
        titlePage: titleWebPage,
        appBar: stateAppBar.appBarCarDetailStatus
            ? AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  key: const Key("pop_navigator_to_home_page"),
                  onPressed: () {
                    Navigator.pop(context);
                    context
                        .read<ScrollProductDetailBloc>()
                        .add(ProductDetailScrollAction(0, context, "1"));
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                leadingWidth: 60,
                titleSpacing: 0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AlvaText(
                        title: 'Pulsar MAX',
                        textStyle:
                            AlvaStyles().headingSize12w700(ModernDarkGray)),
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
                    title: "ข้อมูลสินค้า",
                    textStyle: AlvaStyles()
                        .headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: AlvaStyles().outlineNoneBorderButtonStyle(
                        YellowKrungsri, Colors.transparent),
                    child: AlvaText(
                        title: "สั่งซื้อสินค้า",
                        textStyle: AlvaStyles()
                            .headingSize16w700(BTN_SELECTED_TEXT_COLOR_NEW)),
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
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            children: [
              Container(
                width: maxWidth - 32,
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
                              itemCount: imageDataLength + 1,
                              controller: carouselState,
                              onPageChanged: (val) {
                                context
                                    .read<
                                        ProductDetailCarouselScrollControllerBloc>()
                                    .add(CarouselScrollAction(index: val));
                                if (val == imageDataLength) {
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
                                            .add(SwitchPageAction(
                                                statePage: true));
                                        context
                                            .read<
                                                ProductDetailCarouselScrollControllerBloc>()
                                            .add(CarouselScrollAction(
                                                index:
                                                    carouselState.initialPage));
                                      },
                                      onLongPress: () {
                                        //////////////////////For Test/////////////////////////
                                        setState(() {
                                          if (dataCarouselMock ==
                                              carouselOver20Item) {
                                            dataCarouselMock =
                                                carouselSingleItem;
                                          } else {
                                            dataCarouselMock =
                                                carouselOver20Item;
                                          }
                                        });
                                        //////////////////////For Test/////////////////////////
                                      },
                                      onDoubleTap: () {
                                        //////////////////////For Test/////////////////////////
                                        setState(() {
                                          if (dataCarouselMock !=
                                              carouselTripleItem) {
                                            dataCarouselMock =
                                                carouselTripleItem;
                                          } else {
                                            dataCarouselMock =
                                                carouselSingleItem;
                                          }
                                        });
                                        //////////////////////For Test/////////////////////////
                                      },
                                      child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: SizedBox(
                                          width: maxWidth,
                                          height: 576,
                                          child: FadeInImage(
                                            placeholder: const AssetImage(
                                                'assets/homepage/img_default.png'),
                                            // Replace with your placeholder image path
                                            image: NetworkImage(
                                              i == imageDataLength
                                                  ? dataCarouselMock[0]
                                                  : dataCarouselMock[i],
                                            ),
                                            fit: BoxFit.fitWidth,
                                            imageErrorBuilder: (context, error,
                                                    stackTrace) =>
                                                Image.asset(
                                                    'assets/homepage/img_default.png',
                                                    fit: BoxFit.fitWidth),
                                          ),
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
                                  title:
                                      "${carouselState.initialPage + 1}/$imageDataLength",
                                  textStyle: AlvaStyles()
                                      .headingSize10w500(ModernDarkGray)),
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
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox(),
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
                            visible: imageDataLength == 1 ? false : true,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: SmoothPageIndicator(
                                  controller: carouselState,
                                  count: imageDataLength <= carouselShowLimit
                                      ? imageDataLength
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
                                textStyle: AlvaStyles()
                                    .headingSize22w700(ModernDarkGray),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    child: AlvaText(
                                      title: 'ติดตั้งฟรี',
                                      textStyle: AlvaStyles()
                                          .headingSize10w500(spaceGrey),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 16,
                                    color: cloudSoftDeepWhite,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: AlvaText(
                                        title: 'รับประกัน 3 ปี',
                                        textStyle: AlvaStyles()
                                            .headingSize10w500(spaceGrey),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 16,
                                    color: cloudSoftDeepWhite,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: AlvaText(
                                        title:
                                            'สิทธิพิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้ ',
                                        textStyle: AlvaStyles()
                                            .headingSize10w500(spaceGrey),
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
                                textStyle: AlvaStyles()
                                    .headingSize16w500(ModernDarkGray),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              AlvaText(
                                title:
                                    'เครื่องชาร์จรถยนต์ไฟฟ้าสไตล์มินิมอล ที่ทรงพลังในขนาดกะทัดรัด สามารถติดตั้งได้กับโรงจอดรถหลายสไตล์เหมาะกับการชาร์จรถยนต์ไฟฟ้าที่บ้านทุกวันอีกทั้งยังสามารถเพิ่มประสิทธิภาพการทำงานของเครื่องชาร์จได้อย่างเต็มที่ผ่านการใช้งานร่วมกับ myWallbox Application',
                                textStyle:
                                    AlvaStyles().headingSize10w400(spaceGrey),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  AlvaText(
                                    title: '${56640.toDecimalFormat()} บาท',
                                    textStyle: AlvaStyles()
                                        .headingSize22w700(RedWordShow),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    // margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    decoration: BoxDecoration(
                                        color: RedSoft,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: AlvaText(
                                        title: 'ถูกลง 4 %',
                                        textStyle: AlvaStyles()
                                            .headingSize10w700(RedWordShow),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AlvaText(
                                title: '${56640.toDecimalFormat()} บาท',
                                textStyle: AlvaStyles()
                                    .discountPriceTxt14w400(smockGrey),
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
              const SizedBox(
                height: 16,
              ),
              buildProductDescriptionWidget(),
              const SizedBox(
                height: 16,
              ),
              buildDetailCardWidget(
                  titleKey: AppKeys().productDetailAboutSellerTitleKey,
                  title: AppStrings().aboutSellerTitle,
                  bodyPage: Column(
                    children: [
                      Row(
                        children: [
                          AlvaText(
                              title: "Company",
                              textStyle:
                                  AlvaStyles().headingSize14w700(blackInBlack))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          AlvaText(
                              title: "Company Address",
                              textStyle:
                                  AlvaStyles().headingSize10w400(smockGrey))
                        ],
                      ),
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              buildDetailCardWidget(
                  titleKey: AppKeys().productDetailPromotionDetailTitleKey,
                  title: AppStrings().promotionDetailTitle,
                  bodyPage: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.bookmark,
                            size: 12,
                            color: smockGrey,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          AlvaText(
                              title: "Promotion Desc",
                              textStyle:
                                  AlvaStyles().headingSize12w700(blackInBlack))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              buildDetailCardWidget(
                  titleKey: AppKeys().productDetailRemarkTitleKey,
                  title: AppStrings().remarkTitle,
                  bodyPage: HtmlWidget("remark", buildAsync: true,
                      customStylesBuilder: (element) {
                    return {
                      'font-family': 'Krungsri Condensed',
                      'font-size': '14px'
                    };
                  })),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }

  Widget buildProductDescriptionWidget() {
    bool isPressedReadMore = false;
    return Container(
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
        child: StatefulBuilder(builder: (context, setState) {
          String data = "";
          if (_tabController.index == 0) {
            data =
                "มาสด้า 3 SP 2.0 Carbon Edition ปี 2023 สีเทาฟ้า (Poly Metal Grey) \r<br />รุ่นพิเศษ เบาะแดง ตะเข็บคอนโซลแดง กระจกมองข้าง ล้อแม็กสีดำ \r<br />\r<br />มีติดชุดสเกิร์ตหน้าแท้สีดำเงา Mazda Signature Stlye\r<br />เคลือบแก้วเซรามิก 10 H \r<br />มาแล้ว มีรับประกัน 2 ปี \r<br />\r<br />ออกรถ 4 เมษา 2023\r<br />ป้ายแดง ยังไม่จดทะเบียน\r<br />รถมีซื้อโปรแกรม MUS \r<br />ดูแลรักษาฟรี 5 ปี\r<br />วารันตี 5 ปี\r<br />ไมล์ 4,xxx กิโล\r<br />มีประกันภัยชั้น 1 ซ่อมห้างของ วิริยะประกันภัย\r<br />\r<br />รถเหมือนใหม่ป้ายแดง ไม่เคยมีอุบัติเหตุใดๆ เช็คประวัติได้\r<br />\r<br />รถใหม่ราคา 1,210,000 บาท\r<br />ขาย 1,090,000 บาท\r<br />\r<br />สนใจติดต่อ คุณเอ \r<br />065-2299569";
          } else {
            data =
                "<article>Mazda 3 2.0 C รถปี 2020<br />- เลขไมล์ 28,XXX รถบ้านขับน้อย ไม่เคยชน<br />- ล้อแม็กขอบ 18 รุ่นพิเศษ 100th Anniversary Edition & น็อต Rays แท้<br />- กรอบกระจก Glossy Black งานแท้เบิกศูนย์<br />- ติดระบบเรดาร์ถอยจอดของแท้ Mazda แบบไม่เจาะกันชน<br />- อัพเกรดระบบนำทาง Mazda แท้ พร้อมยิงขึ้นจอ HID ที่กระจก (Option นี้ในไทยไม่มี)<br />- กล้องบันทึกหน้าหลัง 70mai<br />- ท่อ HKS แท้ ปลายคาร์บอนคู่ ประกันเหลือ (ท่อเดิมยังอยู่)<br />- กรอบป้ายทะเบียน HEMI แบบพับได้<br />- ทะเบียนเลขจองพิเศษ 698 กทม<br />- รถ Service ศูนย์ตรงตามระยะ ฟรีค่าแรง 5 ปี (เหลืออีก 2 ปี)<br />- Service เคลือบแก้วเซรามิกทุก 6 เดือน<br /><br />ราคา 750,000.- <br />โทร 086-4868878 เกรท<br />นัดดูรถ หมู่บ้าน The City - รัตนาธิเบศร์ นนทบุรี </article>";
          }

          // data = widget.arguments!.test;

          // var args = ModalRoute.of(context)!.settings.arguments
          //     as ProductDetailScreenArguments;

          // data = args.test;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: AlvaText(
                        key: AppKeys().productDetailProductDescriptionKey,
                        title: AppStrings().productDetailProductDescription,
                        textStyle:
                            AlvaStyles().headingSize16w500(ModernDarkGray),
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
                    setState(() {});
                    log("TapBar index $index");
                  },
                  tabs: [
                    Tab(
                      key: AppKeys().productDetailGeneralDetailTabKey,
                      text: AppStrings().generalDetail,
                    ),
                    Tab(
                        key: AppKeys().productDetailEtcDetailTabKey,
                        text: AppStrings().etcDetail),
                  ]),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onHorizontalDragEnd: (details) async {
                  if (_tabController.index == 0) {
                    if (details.primaryVelocity! < 0) {
                      _tabController.animateTo(1,
                          duration: const Duration(milliseconds: 300));
                      setState(() {});
                    }
                  } else {
                    if (details.primaryVelocity! > 0) {
                      _tabController.animateTo(0,
                          duration: const Duration(milliseconds: 300));
                      setState(() {});
                    }
                  }
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: data.isEmpty ? 32 : 0),
                    child: Column(
                      children: [
                        isPressedReadMore
                            ? HtmlWidget(
                                data.isNotEmpty
                                    ? data
                                    : AppStrings().noDataFromSeller,
                                buildAsync: true,
                                customStylesBuilder: (element) {
                                return {
                                  'font-family': 'Krungsri Condensed',
                                  'font-size': '14px'
                                };
                              })
                            : Container(),
                        !isPressedReadMore
                            ? HtmlWidget(
                                data.isNotEmpty
                                    ? data
                                    : AppStrings().noDataFromSeller,
                                buildAsync: true,
                                customStylesBuilder: (element) {
                                return {
                                  'font-family': 'Krungsri Condensed',
                                  'font-size': '14px',
                                  'max-lines': '5',
                                  'text-overflow': 'ellipsis'
                                };
                              })
                            : Container(),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              data.isNotEmpty
                  ? _tabController.index == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                height: 48,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    setState((() {
                                      isPressedReadMore = !isPressedReadMore;
                                    }));
                                    log(isPressedReadMore.toString());
                                  },
                                  style: AlvaStyles()
                                      .outlineNoneBorderButtonStyle(
                                          Colors.transparent,
                                          Colors.transparent),
                                  child: AlvaText(
                                    title: isPressedReadMore
                                        ? AppStrings().btnHideDescription
                                        : AppStrings().btnReadMore,
                                    textStyle: AlvaStyles()
                                        .headingSize14w700(BlueFantasy),
                                    disableSelectableText: true,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Container()
                  : Container()
            ],
          );
        }));
  }

  switchStyleForHtml({String? title, bool isPressedReadMore = false}) {
    if (title == AppStrings().aboutSellerTitle) {
      return {
        'font-family': 'Krungsri Condensed',
        'font-size': '14px',
      };
    } else if (title == AppStrings().promotionDetailTitle) {
      return {
        'font-family': 'Krungsri Condensed',
        'font-size': '14px',
      };
    } else if (title == AppStrings().remarkTitle) {
      return {
        'font-family': 'Krungsri Condensed',
        'font-size': '14px',
      };
    }
  }

  Widget buildDetailCardWidget(
      {Key? titleKey, String? title, Widget? bodyPage}) {
    String phoneNumber = "091-862-5011";

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    padding: const EdgeInsets.all(8),
                    child: AlvaText(
                      key: titleKey!,
                      title: title!,
                      textStyle: AlvaStyles().headingSize16w500(ModernDarkGray),
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: bodyPage)),
            title == AppStrings().aboutSellerTitle
                ? Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () async {
                            if (Platform.isIOS) {
                              var alert = CupertinoAlertDialog(
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.phone_in_talk_sharp,
                                          color: BTN_SELECTED_TEXT_COLOR_NEW,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        AlvaText(
                                            title: "ติดต่อ $phoneNumber",
                                            textStyle: AlvaStyles()
                                                .heading2(BlueFantasy)),
                                      ],
                                    ),
                                  ),
                                  CupertinoDialogAction(
                                      isDefaultAction: true,
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: Text('Cancel',
                                          style: AlvaStyles()
                                              .heading2(BlueFantasy))),
                                ],
                              );
                              bool isConfirmCall = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                              if (isConfirmCall) {
                                await launchUrlString('tel:$phoneNumber');
                              }
                            } else if (Platform.isAndroid) {
                              await launchUrlString('tel:$phoneNumber');
                            }
                          },
                          style: AlvaStyles().outlineButtonStyle(
                              side: const BorderSide(
                                color: YellowKrungsri,
                                width: 2,
                              ),
                              Colors.transparent,
                              Colors.transparent,
                              8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.phone_in_talk_sharp,
                                color: BTN_SELECTED_TEXT_COLOR_NEW,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              AlvaText(
                                  title: "ติดต่อ $phoneNumber",
                                  textStyle: AlvaStyles()
                                      .heading2(BTN_SELECTED_TEXT_COLOR_NEW)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )
                : Container()
          ],
        ));
  }

  Widget viewImagePage(
      PageController carouselState,
      BuildContext context,
      TransformationController zoomState,
      double previousState,
      int imageDataLength) {
    return WillPopScope(
      onWillPop: () async => false,
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
                      context
                          .read<ImgGalleryZoomBloc>()
                          .add(ZoomImageAction(details: detail));
                      if (previousState > 0.6) {
                        context
                            .read<PreviousScaleBloc>()
                            .add(const PreviousScaleEvent(previousScale: 0.5));
                      } else {
                        context
                            .read<PreviousScaleBloc>()
                            .add(const PreviousScaleEvent(previousScale: 0.8));
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
                        context.read<PreviousScaleBloc>().add(
                            PreviousScaleEvent(
                                previousScale: _scale.clamp(0.5, 5.0)));
                      },
                      child: AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: PageView.builder(
                            itemCount: imageDataLength + 1,
                            physics: previousState > 0.5
                                ? const NeverScrollableScrollPhysics()
                                : const ScrollPhysics(),
                            controller: carouselState,
                            onPageChanged: (val) {
                              context
                                  .read<
                                      ProductDetailCarouselScrollControllerBloc>()
                                  .add(CarouselScrollAction(index: val));

                              if (val == imageDataLength) {
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
                                    placeholder: AssetImage(
                                        ProductDetailConst().imgDefaultPath),
                                    image: NetworkImage(
                                      i == imageDataLength
                                          ? dataCarouselMock[0]
                                          : dataCarouselMock[i],
                                    ),
                                    fit: BoxFit.fitWidth,
                                    imageErrorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            ProductDetailConst().imgDefaultPath,
                                            fit: BoxFit.fitWidth),
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
                context
                    .read<ViewImgDetailPageSwitchBloc>()
                    .add(SwitchPageAction(statePage: false));
                context.read<ProductDetailCarouselScrollControllerBloc>().add(
                    CarouselScrollAction(index: carouselState.initialPage));
                if (zoomState.value != Matrix4.identity()) {
                  context.read<ImgGalleryZoomBloc>().add(ZoomImageAction(
                      details: customTapDownDetails(const Offset(100, 100))));
                }
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
                              count: imageDataLength <= carouselShowLimit
                                  ? imageDataLength
                                  : carouselShowLimit,
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
