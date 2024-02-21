import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';
import 'package:marketplace_line_oa/src/model/refund/refund_request_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund/refund_request_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/tracking_order/tracking_order_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_summary/dropdown_input_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_summary/text_input_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
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

      context.read<RefundRequestBloc>().add(SetRefundData(
          orderNo: orderNo,
          reasonList: [],));
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
                bool haveReason = state.getTextReason.text.isNotEmpty;
                if (state.refundRequestStatus ==
                    GetRefundRequestStatus.success) {
                  return AlvaRootWidget(
                    titlePage: titleWebPage,
                    appBar: appBar,
                    child: ListView(
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
                                style: AlvaStyles()
                                    .headingSize12w600(blackGoMunTo),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              right: 16, left: 16, bottom: 12, top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "รายละเอียดสินค้า",
                                style: AlvaStyles()
                                    .headingSize14w800(blackGoMunTo),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, bottom: 16),
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
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, bottom: 16),
                              //   width: (maxWidth / 2) - 32,
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
                        Container(
                          width: maxWidth,
                          height: 16,
                          color: backgroundNo2,
                        ),
                        Container(
                          height: 48,
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 12, bottom: 12),
                          child: AlvaText(
                              title: "เหตุผลการคืนสินค้า/คืนเงิน",
                              textStyle: AlvaStyles()
                                  .headingSize14w700(
                                      BTN_SELECTED_TEXT_COLOR_NEW)
                                  .copyWith(height: 24 / 14)),
                        ),
                        haveReason
                            ? Container()
                            : DropDownInputWidget(
                                bottomSheetHeight: 419,
                                customButton: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 8),
                                        Text("เลือกเหตุผล",
                                            style: AlvaStyles().heading2(
                                                BTN_SELECTED_TEXT_COLOR_NEW)),
                                      ],
                                    ),
                                  ),
                                ),
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                label: "เหตุผลการคืนสินค้า",
                                textEditingController: state.getTextReason,
                                marginBottom: 15,
                                required: true,
                                value:
                                    state.refundRequestData.refundInfo!.reason,
                                options: state.reasonList,
                                onChanged: (DropdownAddressModel value) async {
                                  RefundRequestModel refundModel =
                                      RefundRequestModel(
                                          status: '',
                                          refundInfo: RefundInfoModel(
                                              refundNo: '',
                                              refundTime: '',
                                              refundDate: '',
                                              remark: '',
                                              reason: value.nameTh),
                                          product: null);
                                  context.read<RefundRequestBloc>().add(
                                      OnSelectReason(
                                          refundRequestModel: refundModel,
                                          getTextReason: state.getTextReason,
                                          getTextRemark: state.getTextRemark));
                                },
                              ),

                        /// Widget Text Reason
                        haveReason
                            ? Container(
                                padding: EdgeInsets.all(16),
                                child: Stack(
                                  children: [
                                    TextInputWidget(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(RegExp(
                                            r"[0-9-!$%^&*#@()_+|~=`{}\[\]:;'<>?,.\/"
                                            '"'
                                            "]")),
                                        FilteringTextInputFormatter.deny(RegExp(
                                            r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'))
                                      ],
                                      autoValidateMode:
                                          AutovalidateMode.disabled,
                                      controller: state.getTextReason,
                                      outsideLabel: true,
                                      marginBottom: 15,
                                      required: false,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.text,
                                      readOnly: true,
                                      maxLength: null,
                                      maxLines: 1,
                                      showCounter: false,
                                      focusNode: FocusNode(),
                                    ),
                                    Positioned(
                                        right: 5,
                                        top: 4,
                                        child: DropDownInputWidget(
                                          bottomSheetHeight: 419,
                                          customButton: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: cloudyWhite),
                                            width: 24,
                                            height: 24,
                                            padding: EdgeInsets.all(5),
                                            child: Image.asset(
                                              'assets/icons/edit.png',
                                              fit: BoxFit.fill,
                                              filterQuality:
                                                  FilterQuality.medium,
                                            ),
                                          ),
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          label: "เหตุผลการคืนสินค้า",
                                          textEditingController:
                                              state.getTextReason,
                                          marginBottom: 15,
                                          required: true,
                                          value: state.refundRequestData
                                              .refundInfo!.reason,
                                          options: state.reasonList,
                                          onChanged: (DropdownAddressModel
                                              value) async {
                                            RefundRequestModel refundModel =
                                                RefundRequestModel(
                                                    status: '',
                                                    refundInfo: RefundInfoModel(
                                                        refundNo: '',
                                                        refundTime: '',
                                                        refundDate: '',
                                                        remark: '',
                                                        reason: value.nameTh),
                                                    product: null);
                                            context
                                                .read<RefundRequestBloc>()
                                                .add(OnSelectReason(
                                                    refundRequestModel:
                                                        refundModel,
                                                    getTextReason:
                                                        state.getTextReason,
                                                    getTextRemark:
                                                        state.getTextRemark));
                                          },
                                        )),
                                  ],
                                ))
                            : SizedBox.shrink(),
                        Container(
                            padding: EdgeInsets.all(16),
                            child: Stack(
                              children: [
                                TextInputWidget(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(RegExp(
                                        r"[0-9-!$%^&*#@()_+|~=`{}\[\]:;'<>?,.\/"
                                        '"'
                                        "]")),
                                    FilteringTextInputFormatter.deny(RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'))
                                  ],
                                  autoValidateMode: AutovalidateMode.disabled,
                                  controller: state.getTextRemark,
                                  label: "คำอธิบายเพิ่มเติม",
                                  outsideLabel: true,
                                  marginBottom: 15,
                                  required: false,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  maxLength: 250,
                                  maxLines: null,
                                  showCounter: true,
                                  focusNode: FocusNode(),
                                ),
                                state.isShowEditIconRemark
                                    ? Positioned(
                                        right: 5,
                                        top: 26,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: cloudyWhite),
                                          width: 24,
                                          height: 24,
                                          padding: EdgeInsets.all(5),
                                          child: Image.asset(
                                            'assets/icons/edit.png',
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.medium,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            )),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: Text(
                                            AppStrings().remarkTitle,
                                            style: AlvaStyles()
                                                .headingSize12w700(Colors.black)
                                                .copyWith(height: 2),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                "•",
                                                style: AlvaStyles()
                                                    .headingSize12w400(
                                                        Colors.black)
                                                    .copyWith(height: 2),
                                              ),
                                            ),
                                            Text(
                                              AppStrings().remarkRefundFirst,
                                              style: AlvaStyles()
                                                  .headingSize12w400(
                                                      Colors.black)
                                                  .copyWith(height: 2),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                "•",
                                                style: AlvaStyles()
                                                    .headingSize12w400(
                                                        Colors.black)
                                                    .copyWith(height: 2),
                                              ),
                                            ),
                                            Text(
                                              AppStrings().remarkRefundSecond,
                                              style: AlvaStyles()
                                                  .headingSize12w400(
                                                      Colors.black)
                                                  .copyWith(height: 2),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                "•",
                                                style: AlvaStyles()
                                                    .headingSize12w400(
                                                        Colors.black)
                                                    .copyWith(height: 2),
                                              ),
                                            ),
                                            Text(
                                              AppStrings().remarkRefundThird,
                                              style: AlvaStyles()
                                                  .headingSize12w400(
                                                      Colors.black)
                                                  .copyWith(height: 2),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        /// Button send Request
                        Container(
                        width: maxWidth,
                        height: 96,
                padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
                decoration: BoxDecoration(
                color: Colors.white,
                ),
                        child:Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            height: 48,
                        //    width: (maxWidth - 40) / 2,
                            child: OutlinedButton(
                              onPressed: haveReason
                                  ? () {
                                print("Button send Order " + orderNo);
                                print("Button send Product " + state.inquiryData.productName.toString());
                                print("Button send Reason " + state.getTextReason.text);
                                print("Button send Remark " + state.getTextRemark.text);
                                      GeneralDialog(
                                              onAccept: () async {
                                                final refundBloc = context.read<RefundRequestBloc>();

                                                // final orderBloc = context.read<OrderSummaryBloc>();
                                                // ProductionOptionals step1SelectedOption = productState
                                                //     .product.productionOptionals.isEmpty
                                                //     ? ProductionOptionals.fromJson(const {})
                                                //     : productState.product.productionOptionals[pdOptState.stepOneIndexSelect ?? 0];
                                                // requestModel = CreateOrderRequestModel(
                                                //     uid: await LineDataHelper().getLineUid(),
                                                //     products: [
                                                //       OrderProduct(
                                                //           productId: productState.product.productId,
                                                //           qty: 1,
                                                //           unitPrice: productState.product.productionOptionals.isNotEmpty
                                                //               ? step1price
                                                //               : showPrice,
                                                //           optional: productState.product.productionOptionals.isEmpty
                                                //               ? null
                                                //               : Optional(
                                                //               productId: step1SelectedOption.subProductId,
                                                //               qty: 1,
                                                //               unitPrice: step1SelectedOption.price))
                                                //     ]);
                                              },
                                              onCancel: () {})
                                          .showRefundDialog(
                                              context: context,
                                              isConfirmPayment: true);
                                    }
                                  : null,
                              style: AlvaStyles().outlineNoneBorderButtonStyle(
                                  haveReason ? YellowKrungsri : cloudDeepWhite,
                                  Colors.transparent,
                                  isRadius8: true),
                              child: Text("ส่งคำขอ",
                                  style: AlvaStyles().headingSize16w700(haveReason
                                      ? BTN_SELECTED_TEXT_COLOR_NEW
                                      : smockGrey)),
                            ),
                          )),
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
