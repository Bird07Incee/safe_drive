import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';
import 'package:marketplace_line_oa/src/model/refund/arguments/refund_success_args.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_request/refund_request_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/disclaimer_bottom_section.dart';
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
  String orderNo = "", productId = "", refundDay = "", orderStatus = "", merchantName = "";
  List<DropdownAddressModel> listReason = [];
  bool isLoaded = false;
  bool loglaew = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      isLoaded = true;
      clearState();
      readJson();
      loadRefundRequest();
    }
  }

  @override
  void initState() {
    clearState();
    super.initState();
  }

  void clearState() {
    orderNo = "";
    orderStatus = "";
    productId = "";
    refundDay = "";
    merchantName = "";
    context.read<RefundRequestBloc>().add(OnClearState());
  }

  void loadRefundRequest() {
    settings = ModalRoute.of(context) != null ? ModalRoute.of(context)!.settings : null;
    if (settings != null) {
      var uriData = Uri.parse(settings!.name!);
      var routingData = RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
      orderNo = (routingData["orderNo"] == null) ? "" : routingData["orderNo"];
      productId = (routingData["pid"] == null) ? "" : routingData["pid"];
      refundDay = (routingData["refundDay"] == null) ? "" : routingData["refundDay"];
      orderStatus = (routingData["orderStatus"] == null) ? "" : routingData["orderStatus"];
      merchantName = (routingData["merchantName"] == null) ? "" : routingData["merchantName"];
      context.read<RefundRequestBloc>().add(SetRefundData(
            orderNo: orderNo,
            reasonList: listReason,
          ));
    }
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/mocking/json/refund_reason_list.json');
    Map<String, dynamic> data = await json.decode(response);
    if (data.isNotEmpty) {
      listReason.clear();
      List<dynamic> reasonList = data["refundReasonList"] as List<dynamic>;

      for (int i = 0; i < reasonList.length; i++) {
        listReason.add(DropdownAddressModel(id: i.toString(), nameTh: reasonList[i]));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double btmInset = MediaQuery.of(context).viewInsets.bottom;
    var maxWidth = MediaQuery.of(context).size.width;

    AppBar appBar = AppBar(
      title: AlvaText(title: "คืนสินค้า/คืนเงิน", textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
      titleSpacing: 0,
      leadingWidth: 60,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: IconButton(
          key: const Key("pop_navigator_to_home_page"),
          onPressed: () {
            Navigator.pop(context);
            context.read<RefundRequestBloc>().textEditingControllerReason!.clear();
            context.read<RefundRequestBloc>().textEditingControllerRemark!.clear();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
    return RootPageCondition(
        child: WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        context.read<RefundRequestBloc>().textEditingControllerReason!.clear();
        context.read<RefundRequestBloc>().textEditingControllerRemark!.clear();
        return false;
      },
      child: BlocConsumer<RefundRequestBloc, RefundRequestState>(listener: (context, state) {
        if (state.refundRequestStatus == GetRefundRequestStatus.submitSuccess) {
          Navigator.pushReplacementNamed(context, '${Routes.refundSuccess.toStringPath()}?orderNo=${state.inquiryData.invoiceNo}',
              arguments: RefundSuccessArgs(refundResponse: state.refundResponse));
        }
      }, builder: (context, productState) {
        return BlocBuilder<RefundRequestBloc, RefundRequestState>(
          builder: (context, state) {
            if (state.refundRequestStatus == GetRefundRequestStatus.submitFail) {
              return ErrorScreen(
                title: ErrorConst().titleNS,
                subTitle: ErrorConst().subTitleNS,
                titleBtn: ErrorConst().titleBtnNS,
                onTap: () {
                  context.read<RefundRequestBloc>().add(OnSubmitRefundData());
                },
              );
            } else if (state.refundRequestStatus == GetRefundRequestStatus.success) {
              if (!loglaew) {
                AmplitudeWebHelper.getInstance().logEnterProductRefundPage(state.inquiryData.productName!, state.inquiryData.invoiceNo!, orderStatus,
                    state.inquiryData.merchantFullName!, state.inquiryData.productOption!);
                loglaew = true;
              }

              bool haveReason = state.getTextReason.isNotEmpty;
              bool haveRemark = state.getTextRemark.isNotEmpty;
              return AlvaRootWidget(
                titlePage: titleWebPage,
                appBar: appBar,
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        Container(
                          color: orange50,
                          height: 48,
                          padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                          child: Row(
                            //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "หมายเลขอ้างอิง: $orderNo",
                                  style: AlvaStyles().headingSize12w600(blackGoMunTo),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 16, left: 16, bottom: 12, top: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "รายละเอียดสินค้า",
                                style: AlvaStyles().headingSize14w800(blackGoMunTo),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 40,
                                      width: 72,
                                      // child: productState.product.productionAssets.isNotEmpty
                                      //     ?
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: FadeInImage(
                                          width: 78,
                                          height: 78,
                                          placeholder: const AssetImage('assets/homepage/img_default.png'),
                                          image: NetworkImage(state.inquiryData.productImagePath!),
                                          fit: BoxFit.fitWidth,
                                          imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                                            'assets/homepage/img_default.png',
                                            fit: BoxFit.fitWidth,
                                            width: 132,
                                            height: 74,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: maxWidth - 32 - 16 - 72,
                                    child: AlvaTextMaxLinesOverflow(
                                        maxLines: 1, title: state.inquiryData.productName!, textStyle: AlvaStyles().headingSize14Height22()),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: SizedBox(
                                      width: maxWidth - 32 - 16 - 72,
                                      child: AlvaTextMaxLinesOverflow(
                                          maxLines: 5,
                                          title: state.inquiryData.productOption!,
                                          textStyle: AlvaStyles().headingSize12RegHeight20(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 1.6)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: maxWidth,
                          height: 16,
                          color: backgroundNo2,
                        ),
                        Container(
                          height: 48,
                          padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                          child: AlvaText(
                              title: "เหตุผลการคืนสินค้า/คืนเงิน",
                              textStyle: AlvaStyles().headingSize14w800(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 24 / 14)),
                        ),
                        haveReason
                            ? Container()
                            : DropDownInputWidget(
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
                                        Text("เลือกเหตุผล", style: AlvaStyles().heading2(BTN_SELECTED_TEXT_COLOR_NEW)),
                                      ],
                                    ),
                                  ),
                                ),
                                autoValidateMode: AutovalidateMode.onUserInteraction,
                                label: "เหตุผลการคืนสินค้า",
                                textEditingController: context.read<RefundRequestBloc>().textEditingControllerReason,
                                marginBottom: 15,
                                required: true,
                                value: state.getTextReason,
                                options: state.reasonList,
                                onChanged: (DropdownAddressModel value) async {
                                  context.read<RefundRequestBloc>().add(OnSelectReason(
                                      getTextReason: context.read<RefundRequestBloc>().textEditingControllerReason!.text,
                                      getTextRemark: context.read<RefundRequestBloc>().textEditingControllerRemark!.text));
                                },
                              ),

                        /// Widget Text Reason
                        haveReason
                            ? Container(
                                padding: EdgeInsets.all(16),
                                child: Stack(
                                  children: [
                                    TextInputWidget(
                                      autoValidateMode: AutovalidateMode.disabled,
                                      controller: context.read<RefundRequestBloc>().textEditingControllerReason,
                                      textStyle: AlvaStyles().headingSize16w500(BTN_SELECTED_TEXT_COLOR_NEW),
                                      outsideLabel: true,
                                      marginBottom: 15,
                                      paddingRightOnly: 50,
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
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: cloudyWhite),
                                            width: 24,
                                            height: 24,
                                            padding: EdgeInsets.all(5),
                                            child: Image.asset(
                                              'assets/icons/edit.png',
                                              fit: BoxFit.fill,
                                              filterQuality: FilterQuality.medium,
                                            ),
                                          ),
                                          autoValidateMode: AutovalidateMode.onUserInteraction,
                                          label: "เหตุผลการคืนสินค้า",
                                          textEditingController: context.read<RefundRequestBloc>().textEditingControllerReason,
                                          marginBottom: 15,
                                          required: true,
                                          value: state.getTextReason,
                                          options: state.reasonList,
                                          onChanged: (DropdownAddressModel value) async {
                                            context.read<RefundRequestBloc>().add(OnSelectReason(
                                                getTextReason: context.read<RefundRequestBloc>().textEditingControllerReason!.text,
                                                getTextRemark: context.read<RefundRequestBloc>().textEditingControllerRemark!.text));
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
                                  autoValidateMode: AutovalidateMode.disabled,
                                  controller: context.read<RefundRequestBloc>().textEditingControllerRemark,
                                  isAllowEmoji: true,
                                  label: "คำอธิบายเพิ่มเติม",
                                  textStyle: AlvaStyles().headingSize16w500(BTN_SELECTED_TEXT_COLOR_NEW),
                                  outsideLabel: true,
                                  marginBottom: 5,
                                  padding: 16,
                                  paddingRightOnly: 50,
                                  required: false,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  maxLength: 250,
                                  maxLines: null,
                                  showCounter: true,
                                  focusNode: context.read<RefundRequestBloc>().focusRemark,
                                  onFocusChange: (bool isFocus) async {
                                    context.read<RefundRequestBloc>().add(OnEditRemark(
                                        getTextReason: context.read<RefundRequestBloc>().textEditingControllerReason!.text,
                                        getTextRemark: context.read<RefundRequestBloc>().textEditingControllerRemark!.text));
                                  },
                                ),
                                haveRemark && !context.read<RefundRequestBloc>().focusRemark!.hasFocus
                                    ? Positioned(
                                        right: 5,
                                        top: 38,
                                        child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: cloudyWhite),
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

                        ///bottomSheet
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 96),
                              width: maxWidth,
                              //     height: 56 + 68 + 72 + 88 + 16,
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
                                    //      height: 56 + 68 + 72,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 16.0),
                                          child: Text(
                                            AppStrings().remarkTitle,
                                            style: AlvaStyles().headingSize14w800(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 2),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Text(
                                                "•",
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                AppStrings().remarkRefundFirst,
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Text(
                                                "•",
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                AppStrings().remarkRefundSecond,
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Text(
                                                "•",
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                AppStrings().remarkRefundThird(refundDay: refundDay),
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   height: 16,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  DisclaimerSection(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    /// Button send Request
                    btmInset == 0
                        ? Positioned(
                            bottom: 0,
                            child: Container(
                                width: maxWidth,
                                height: 96,
                                padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                  height: 48,
                                  //    width: (maxWidth - 40) / 2,
                                  child: OutlinedButton(
                                    onPressed: haveReason
                                        ? () {
                                            GeneralDialog(
                                                    onAccept: () async {
                                                      final refundBloc = context.read<RefundRequestBloc>();
                                                      refundBloc.add(OnSubmitRefundData());
                                                      AmplitudeWebHelper.getInstance().logTapOnConfirmRefundButton(
                                                          state.inquiryData.productName!,
                                                          state.inquiryData.invoiceNo!,
                                                          merchantName,
                                                          orderStatus,
                                                          "${state.getTextReason.toString()}${state.getTextRemark.isNotEmpty ? "_${state.getTextRemark}" : ""}",
                                                          state.inquiryData.productId.toString(),
                                                          state.inquiryData.productOption!);
                                                    },
                                                    onCancel: () {})
                                                .showRefundDialog(context: context, isConfirmPayment: true);
                                          }
                                        : null,
                                    style: AlvaStyles().outlineNoneBorderButtonStyle(haveReason ? YellowKrungsri : cloudDeepWhite, Colors.transparent,
                                        isRadius8: true),
                                    child:
                                        Text("ส่งคำขอ", style: AlvaStyles().headingSize16w700(haveReason ? BTN_SELECTED_TEXT_COLOR_NEW : smockGrey)),
                                  ),
                                )),
                          )
                        : Container(),
                  ],
                ),
              );
            } else if (state.refundRequestStatus == GetRefundRequestStatus.initial ||
                state.refundRequestStatus == GetRefundRequestStatus.loading ||
                state.refundRequestStatus == GetRefundRequestStatus.submitSuccess) {
              return AlvaRootWidget(titlePage: titleWebPage, child: const LoadingScreen());
            } else {
              return ErrorScreen(
                title: ErrorConst().titleNS,
                subTitle: ErrorConst().subTitleNS,
                titleBtn: ErrorConst().titleBtnNS,
                onTap: () {
                  readJson();
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
