import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/main.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/refund/arguments/refund_success_args.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_event.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_state.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/order_cancel.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/navigator_helper.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';
import 'package:marketplace_line_oa/src/utils/phone_number_formatter.dart';

class RefundSuccessScreen extends StatefulWidget {
  const RefundSuccessScreen({super.key});

  @override
  State<RefundSuccessScreen> createState() => _RefundSuccessScreenState();
}

class _RefundSuccessScreenState extends State<RefundSuccessScreen> {
  late RouteSettings? settings;
  String orderNo = "";
  late double maxWidth, maxHeight;

  void loadRefundData() {
    settings = ModalRoute.of(context) != null ? ModalRoute.of(context)!.settings : null;
    if (settings != null) {
      var uriData = Uri.parse(settings!.name!);
      RefundSuccessArgs args;
      var routingData = RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
      orderNo = (routingData["orderNo"] == null) ? "" : routingData["orderNo"];
      Map<String, dynamic> refundResponse = {};
      if (settings!.arguments != null) {
        args = settings!.arguments as RefundSuccessArgs;
        if (args.refundResponse!.isNotEmpty) {
          refundResponse = args.refundResponse!;
        }
      }
      RefundSuccessState state = context.read<RefundSuccessBloc>().state;
      if (orderNo != "" &&
          (state.refundSuccessStatus == GetRefundSuccessDataStatus.initial || state.refundSuccessStatus == GetRefundSuccessDataStatus.error)) {
        context.read<RefundSuccessBloc>().add(GetRefundSuccess(context, orderNo, refundResponse));
      }
    }
  }

  @override
  void didChangeDependencies() {
    loadRefundData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;

    return RootPageCondition(
        child: WillPopScope(
      onWillPop: () async {
        String pid = context.read<RefundSuccessBloc>().state.refundSuccessData.productId ?? "";
        if (pid.isNotEmpty) {
          refreshRoute(context: context, currentRoute: "refundSuccess", listOption: [], queryParams: '');
        } else {
          CurrentRouteObserver.instance.stack.clear();
          Navigator.pushNamedAndRemoveUntil(context, Routes.initial.toStringPath(), (route) => false);
        }
        return false;
      },
      child: AlvaRootWidget(
        titlePage: titleWebPage,
        child: BlocBuilder<RefundSuccessBloc, RefundSuccessState>(
          builder: (context, state) {
            var refundSuccessData = state.refundSuccessData;
            if (state.refundSuccessStatus == GetRefundSuccessDataStatus.success) {
              return Column(
                children: [
                  Container(
                      width: maxWidth,
                      height: maxHeight - 96,
                      color: cloudyWhite,
                      child: ListView(
                        children: [
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                            color: orangeSoft,
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              SizedBox(width: 32, height: 32, child: Image.asset('assets/icons/refund_request_success.png')),
                              SizedBox(
                                width: 24,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "คืนสินค้า/คืนเงิน",
                                    style: AlvaStyles().headingSize14w700(blackGoMunTo),
                                  ),
                                  Text(
                                    "หมายเลขอ้างอิง: ${refundSuccessData.invoiceNo}",
                                    style: AlvaStyles().headingSize12w400(blackGoMunTo).copyWith(height: 2.0),
                                  ),
                                  Text(
                                    "วันที่ ${refundSuccessData.refundDate}",
                                    style: AlvaStyles().headingSize12w400(blackGoMunTo).copyWith(height: 2.0),
                                  ),
                                  Text(
                                    "เวลา : ${refundSuccessData.refundTime}",
                                    style: AlvaStyles().headingSize12w400(blackGoMunTo).copyWith(height: 2.0),
                                  ),
                                ],
                              ))
                            ]),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            child: Column(children: [
                              ProductAttribute(
                                attributeKey: "เหตุผล",
                                attributevalue: refundSuccessData.reason!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "คำอธิบายเพิ่มเติม",
                                attributevalue: phoneNumberFormatter(refundSuccessData.remark!),
                                maxWidth: maxWidth,
                              ),
                            ]),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              "รายละเอียดการชำระเงิน",
                              style: AlvaStyles().headingSize12w600(blackGoMunTo),
                            ),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            child: Column(children: [
                              ProductAttribute(
                                attributeKey: "ชำระเงินโดย",
                                attributevalue: refundSuccessData.cardNo!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "วันที่ชำระเงิน",
                                attributevalue: refundSuccessData.paymentDate!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "เวลาที่ชำระเงิน",
                                attributevalue: refundSuccessData.paymentTime!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "ช่องทางการชำระเงิน",
                                attributevalue: refundSuccessData.paymentGateway!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "รูปแบบการชำระเงิน",
                                attributevalue: refundSuccessData.paymentChannelText!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "ผู้รับเงิน",
                                attributevalue: refundSuccessData.merchantFullName!,
                                maxWidth: maxWidth,
                              ),
                            ]),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              "รหัสสินค้า: ${refundSuccessData.productId}",
                              style: AlvaStyles().headingSize12w600(blackGoMunTo),
                            ),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: (maxWidth / 2) - 32,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: FadeInImage(
                                              width: 132,
                                              height: 74,
                                              placeholder: const AssetImage('assets/homepage/img_default.png'),
                                              // Replace with your placeholder image path
                                              image: NetworkImage(refundSuccessData.productImagePath!),
                                              fit: BoxFit.fitWidth,
                                              imageErrorBuilder: (context, error, stackTrace) => Image.asset(
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
                                    SizedBox(
                                      width: (maxWidth / 2) - 32,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            refundSuccessData.productName!,
                                            style: AlvaStyles().headingSize14w600(blackGoMunTo),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            refundSuccessData.productOption!,
                                            style: AlvaStyles().headingSize12w400WithLineHeight(blackGoMunTo),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  color: cloudSoftDeepWhite,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: (maxWidth / 2) - 32,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text("ยอดชำระ", style: AlvaStyles().headingSize12w400(blackGoMunTo)),
                                          ],
                                        )),
                                    SizedBox(
                                      width: (maxWidth / 2) - 32,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${refundSuccessData.amount!} บาท", style: AlvaStyles().headingSize14w600(blackGoMunTo)),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text("ยอดชำระนี้รวมภาษีมูลค่าเพิ่มแล้ว", style: AlvaStyles().headingSize12w400Cordia(spaceGrey))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              "ที่อยู่ในการจัดส่งสินค้า",
                              style: AlvaStyles().headingSize12w600(blackGoMunTo),
                            ),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            child: Column(children: [
                              ProductAttribute(
                                attributeKey: "ชื่อผู้รับสินค้า",
                                attributevalue: refundSuccessData.customerFullname!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "เบอร์โทรติดต่อ",
                                attributevalue: phoneNumberFormatter(refundSuccessData.customerMobile!),
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "อีเมล",
                                attributevalue: refundSuccessData.customerEmail!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "ที่อยู่",
                                attributevalue: refundSuccessData.customerAddress!,
                                maxWidth: maxWidth,
                              ),
                            ]),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              "ข้อมูลติดต่อผู้ขาย",
                              style: AlvaStyles().headingSize12w600(blackGoMunTo),
                            ),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            child: Column(children: [
                              Center(
                                child: Text(
                                  refundSuccessData.merchantAddress!.replaceAll("\n", ""),
                                  style: AlvaStyles().headingSize12w400(spaceGrey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              GestureDetector(
                                key: const Key("call_to_merchant_button"),
                                onTap: () {
                                  String phoneNumber = refundSuccessData.merchantMobile!.replaceAll("-", "");
                                  callPhone(phoneNumber);
                                },
                                child: Text(
                                  "โทร ${phoneNumberFormatter(refundSuccessData.merchantMobile!)}",
                                  style: AlvaStyles().headingSize16w600(blackGoMunTo),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            color: spaceGrey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AlvaText(
                                      title: HomeConst().askInformation,
                                      textStyle: AlvaStyles().headingSize10w600(whiteFalse),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  key: const Key("call_button"),
                                  onTap: () {
                                    callPhone(HomeConst().pleaseContactNumber);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        HomeConst().pleaseContact,
                                        style: AlvaStyles().headingSize12w700(whiteFalse),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                      width: maxWidth,
                      height: 96,
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: const Color(0xff000000).withOpacity(0.04), spreadRadius: 0, blurRadius: 16, offset: const Offset(0, -4)),
                        ],
                      ),
                      child: GestureDetector(
                        key: const Key("back_to_tracking_list_button"),
                        onTap: () {
                          String pid = state.refundSuccessData.productId ?? "";
                          if (pid.isNotEmpty) {
                            refreshRoute(context: context, currentRoute: "refundSuccess", queryParams: "orderNo=$orderNo&pid=$pid", listOption: []);
                          } else {
                            CurrentRouteObserver.instance.stack.clear();
                            Navigator.pushNamedAndRemoveUntil(context, Routes.initial.toStringPath(), (route) => false);
                          }
                        },
                        child: Container(
                          height: 48,
                          width: (maxWidth - 40) / 2,
                          decoration: BoxDecoration(color: const Color(0xffffd400), borderRadius: const BorderRadius.all(Radius.circular(8))),
                          child: Center(child: Text("ตรวจสอบสถานะสินค้า", style: AlvaStyles().heading3())),
                        ),
                      ))
                ],
              );
            } else if (state.refundSuccessStatus == GetRefundSuccessDataStatus.initial ||
                state.refundSuccessStatus == GetRefundSuccessDataStatus.loading) {
              return const LoadingScreen();
            } else if (state.refundSuccessStatus == GetRefundSuccessDataStatus.cancel) {
              return OrderCancelScreen();
            } else {
              return ErrorScreen(
                title: ErrorConst().titleNS,
                subTitle: ErrorConst().subTitleNS,
                titleBtn: ErrorConst().titleBtnNS,
                onTap: () {
                  loadRefundData();
                },
              );
            }
          },
        ),
      ),
    ));
  }
}

class ProductAttribute extends StatelessWidget {
  const ProductAttribute({super.key, required this.attributeKey, required this.attributevalue, required this.maxWidth});

  final String attributeKey;
  final String attributevalue;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      padding: EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: (maxWidth / 2) - 32,
            child: Text(
              attributeKey,
              style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2.0),
            ),
          ),
          SizedBox(
            width: (maxWidth / 2) - 32,
            child: Text(
              attributevalue,
              style: AlvaStyles().headingSize12w500(blackGoMunTo).copyWith(height: 2.0),
            ),
          )
        ],
      ),
    );
  }
}
