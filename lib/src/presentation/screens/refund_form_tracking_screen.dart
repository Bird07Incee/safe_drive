import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_keys.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/model/refund/refund_request_model.dart';
import 'package:marketplace_line_oa/src/model/tracking_list_data.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund/refund_request_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/tracking_order/tracking_order_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_detail/product_detail_bottom_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_detail/product_detail_top_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_summary/dropdown_input_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/tracking/tracking_order_card.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';

class RefundFormTrackingScreen extends StatefulWidget {
  const RefundFormTrackingScreen({super.key});

  @override
  State<RefundFormTrackingScreen> createState() => _RefundRequestState();
}

class _RefundRequestState extends State<RefundFormTrackingScreen> {
  final scrollController = ScrollController();
  late RouteSettings? settings;
  String orderNo = "";
  String productId = "";
  bool isLoaded = false;
  final TextEditingController reasonText = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      isLoaded = true;
      loadRefundRequest();
    }
  }

  void loadRefundRequest() {
    settings = ModalRoute.of(context) != null
        ? ModalRoute.of(context)!.settings
        : null;
    if (settings != null) {
      var uriData = Uri.parse(settings!.name!);
      var routingData = RoutingData(
          route: uriData.path, queryParameters: uriData.queryParameters);
      orderNo = (routingData["orderNo"] == null) ? "" : routingData["orderNo"];
      productId = (routingData["pid"] == null) ? "" : routingData["pid"];

      context
          .read<RefundRequestBloc>()
          .add(SetRefundData(orderNo: orderNo, reasonList: [],
          isShowEditIconReason: false, isShowEditIconRemark: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    AppBar appBar = AppBar(
      title: AlvaText(
          title: "คืนสินค้า คืนเงิน",
          textStyle:
              AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
      titleSpacing: 0,
      leadingWidth: 60,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: IconButton(
          key: const Key("pop_navigator_to_home_page"),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
    return RootPageCondition(
        child: WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.initial.toStringPath(), (route) => false);
        return false;
      },
      child: BlocConsumer<TrackingOrderBloc, TrackingOrderState>(
          listener: (context, state) {},
          builder: (context, productState) {
            return BlocBuilder<RefundRequestBloc, RefundRequestState>(
              builder: (context, state) {
                if (state.refundRequestStatus ==
                    GetRefundRequestStatus.success) {
                  return AlvaRootWidget(
                    titlePage: titleWebPage,
                    appBar: appBar,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Color(0xfffeedcd),
                          height: 48,
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 12, bottom: 12),
                          child: Row(
                            //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "หมายเลขอ้างอิง: ${orderNo}",
                                // "หมายเลขอ้างอิง: ",
                                style: AlvaStyles()
                                    .headingSize12w600(blackGoMunTo),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Divider(
                          height: 1,
                          color: cloudWhite,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, bottom: 16, top: 8),
                              width: (maxWidth / 2) - 32,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: FadeInImage(
                                      width: 78,
                                      height: 78,
                                      placeholder: const AssetImage(
                                          'assets/homepage/img_default.png'),
                                      // Replace with your placeholder image path
                                      //    image: NetworkImage(order.products![0].productImageUrl!),
                                      image: NetworkImage(
                                          state.inquiryData.productImagePath!),
                                      fit: BoxFit.fitWidth,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'assets/homepage/img_default.png',
                                        fit: BoxFit.fitWidth,
                                        width: 132,
                                        height: 74,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(),
                              width: (maxWidth / 2) - 32,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.inquiryData.productName!,
                                    style: AlvaStyles()
                                        .headingSize14w600(blackGoMunTo),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    state.inquiryData.productOption!,
                                    style: AlvaStyles()
                                        .headingSize12w400WithLineHeight(
                                            blackGoMunTo),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 12, bottom: 12),
                              child: AlvaText(
                                  title: "เหตุผลการคืนสินค้า/คืนเงิน",
                                  textStyle: AlvaStyles()
                                      .headingSize14w700(
                                          BTN_SELECTED_TEXT_COLOR_NEW)
                                      .copyWith(height: 24 / 14)),
                            ),
                          ],
                        ),
                        DropDownInputWidget(
                          bottomSheetHeight: 419,
                          customButton: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 48,
                            child: OutlinedButton(
                              onPressed: null,
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
                                  const SizedBox(width: 8),
                                  Text("เลือกเหตุผล",
                                      style: AlvaStyles().heading2(
                                          BTN_SELECTED_TEXT_COLOR_NEW)),
                                ],
                              ),
                            ),
                          ),
                          //   textEditingController: item.controller,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          label: "เหตุผลการคืนสินค้า",
                          marginBottom: 15,
                          required: true,
                          value: state.refundRequestData.refundInfo!.reason,
                          options: state.reasonList,
                          onChanged: (value) async {
                            RefundRequestModel refundModel = RefundRequestModel(
                                status: '',
                                refundInfo: RefundInfoModel(
                                    refundNo: '',
                                    refundTime: '',
                                    refundDate: '',
                                    remark: '',
                                    reason: ''),
                                product: null);
                            context.read<RefundRequestBloc>().add(
                                OnSelectReason(
                                    refundRequestModel: refundModel));
                          },
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 12, bottom: 12),
                          child: Row(
                            children: [
                              AlvaText(
                                  title: "คำอธิบายเพิ่มเติม",
                                  textStyle: AlvaStyles()
                                      .headingSize14w700(
                                          BTN_SELECTED_TEXT_COLOR_NEW)
                                      .copyWith(height: 24 / 14)),
                            ],
                          ),
                        ),
                        Container(
                          height: 32 + 24,
                          padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                          child: TextFormField(
                        //        controller: staffCode,
                            onTap: () {
                              setState(() {});
                            },
                            onChanged: (text) {
                              if (text != "") {
                              //  context.read<ShowSaleCodeCubit>().show(true);
                              } else {
                              //  context.read<ShowSaleCodeCubit>().show(false);
                              }
                            },
                            maxLines: 1,
                            maxLength: 50,
                            style: AlvaStyles().headingSize16w500(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 26 / 16),
                            cursorColor: BTN_SELECTED_TEXT_COLOR_NEW,
                            cursorWidth: 1,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              suffix: state.isShowEditIconRemark
                                  ? Container(
                                margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: GestureDetector(
                                    onTap: () {

                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration:
                                      BoxDecoration(color: cloudyWhite, borderRadius: BorderRadius.circular(36)),
                                      child: Center(
                                        child: SizedBox(
                                          width: 10,
                                          height: 10,
                                          child: Image.asset(
                                            'assets/icons/edit.png',
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    )),
                              )
                                  : null,
                              contentPadding: const EdgeInsets.only(bottom: 12),
                              counterText: "",
                              hintMaxLines: 1,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                  color: grey300,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                  color: BlueFantasy,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 12),
                          child: Row(
                            children: [
                              AlvaText(
                                  title: "สูงสุด 250 ตัวอักษร",
                                  textStyle: AlvaStyles()
                                      .bodySize12W400(spaceGrey123)
                                      .copyWith(height: 24 / 14)),
                            ],
                          ),
                        ),
                         SizedBox(
                           height: 16,
                         ),
                        ///bottomSheet
                         Column(
                          children: [
                              SizedBox(
                              width: maxWidth,
                              height: 56 + 68 + 72 + 88 + 16,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: maxWidth,
                                    height: 16,
                                    color: backgroundNo2,
                                  ),
                                  Container(
                                    width: maxWidth,
                                    height: 56 + 68 + 72,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 16.0),
                                          child: Text(
                                            AppStrings().remarkTitle,
                                            style: AlvaStyles().headingSize12w700(Colors.black).copyWith(height: 2),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Text(
                                                "•",
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                              ),
                                            ),
                                            Text(
                                              AppStrings().remarkRefundFirst,
                                              style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Text(
                                                "•",
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                              ),
                                            ),
                                            Text(
                                              AppStrings().remarkRefundSecond,
                                              style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Text(
                                                "•",
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                              ),
                                            ),
                                            Text(
                                              AppStrings().remarkRefundThird,
                                              style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16.0,
                                        ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                        // const SizedBox(
                                        //   height: 32,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              ),
                            ],
                        ),
                        Container(
                            width: maxWidth,
                            height: 96,
                            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              key: const Key("back_to_home_page"),
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context, Routes.initial.toStringPath(), (route) => false);
                              },
                              child: Container(
                                height: 48,
                                width: (maxWidth - 40) / 2,
                                decoration: BoxDecoration(color: const Color(0xffffd400), borderRadius: const BorderRadius.all(Radius.circular(8))),
                                child: Center(child: Text("ส่งคำขอ", style: AlvaStyles().heading3())),
                              ),
                            ))
                      ],
                    ),
                  );
                } else if (state.refundRequestStatus ==
                        GetRefundRequestStatus.initial ||
                    state.refundRequestStatus ==
                        GetRefundRequestStatus.loading) {
                  return AlvaRootWidget(
                      titlePage: titleWebPage, child: const LoadingScreen());
                } else {
                  return ErrorScreen(
                    title: ErrorConst().titleNS,
                    subTitle: ErrorConst().subTitleNS,
                    titleBtn: ErrorConst().titleBtnNS,
                    onTap: () {
                      loadRefundRequest();
                    },
                  );
                }
              },
            );
          }),
    ));
  }
}
