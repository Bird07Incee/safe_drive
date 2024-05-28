import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/main.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_success/order_success_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/order_cancel.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/disclaimer_bottom_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/change_history_url_strategy.dart';
import 'package:marketplace_line_oa/src/routes/navigator_helper.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';
import 'package:marketplace_line_oa/src/utils/phone_number_formatter.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  late RouteSettings? settings;
  String invoiceNo = "";
  late double maxWidth, maxHeight;

  void loadInvoice() {
    settings = ModalRoute.of(context) != null ? ModalRoute.of(context)!.settings : null;
    if (settings != null) {
      var uriData = Uri.parse(settings!.name!);
      var routingData = RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
      invoiceNo = (routingData["invoiceNo"] == null) ? "" : routingData["invoiceNo"];
      OrderSuccessState state = context.read<OrderSuccessBloc>().state;
      if (invoiceNo != "" &&
          (state.orderSuccessStatus == GetOrderSuccessDataStatus.initial || state.orderSuccessStatus == GetOrderSuccessDataStatus.error)) {
        context.read<OrderSuccessBloc>().add(GetOrderSuccess(context, invoiceNo));
        // context.read<OrderSuccessBloc>().add(GetOrderSuccessMock(context));
      }
      // else {
      //   context.read<OrderSuccessBloc>().add(SetOrderStatus(GetOrderSuccessDataStatus.error));
      // }
    }
  }

  // String safeDecimalFormat(String price) {
  //   String result = "";

  //   try {
  //     result = double.parse(price).round().toDecimalFormat();
  //   } catch (e) {
  //     result = "0";
  //   }

  //   return result;
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    loadInvoice();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;

    return RootPageCondition(
        child: WillPopScope(
      onWillPop: () async {
        String pid = context.read<OrderSuccessBloc>().state.orderSuccessData.productId ?? "";
        if (pid.isNotEmpty) {
          refreshRoute(context: context, currentRoute: "orderSuccess", queryParams: "", listOption: []);
        } else {
          CurrentRouteObserver.instance.stack.clear();
          Navigator.pushNamedAndRemoveUntil(context, Routes.initial.toStringPath(), (route) => false);
        }
        return false;
      },
      child: AlvaRootWidget(
        titlePage: titleWebPage,
        child: BlocBuilder<OrderSuccessBloc, OrderSuccessState>(
          builder: (context, state) {
            var orderSuccessData = state.orderSuccessData;
            if (state.orderSuccessStatus == GetOrderSuccessDataStatus.success) {
              AmplitudeWebHelper.getInstance().logEnterOrderSuccessPage(
                  selectedType: orderSuccessData.installmentPeriod.toString(),
                  invoiceNumber: orderSuccessData.invoiceNo.toString(),
                  productName: orderSuccessData.productName.toString(),
                  contentId: orderSuccessData.productId.toString(),
                  merchantName: orderSuccessData.merchantFullName.toString(),
                  price: orderSuccessData.amount.toString(),
                  paymentType: orderSuccessData.paymentChannel.toString(),
                  userLocation: orderSuccessData.customerAddress.toString());
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
                            height: 76,
                            padding: EdgeInsets.all(16),
                            color: successGreen,
                            child: Row(children: [
                              SizedBox(width: 32, height: 32, child: Image.asset('assets/images/order_success.png')),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "ชำระเงินสำเร็จ",
                                    style: AlvaStyles().headingSize14w700(blackGoMunTo),
                                  ),
                                  Text(
                                    "หมายเลขอ้างอิง: ${orderSuccessData.invoiceNo}",
                                    style: AlvaStyles().headingSize12w400(blackGoMunTo),
                                  )
                                ],
                              )
                            ]),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            child: Column(children: [
                              ProductAttribute(
                                attributeKey: "ชำระเงินโดย",
                                attributevalue: orderSuccessData.cardNo!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "วันที่ชำระเงิน",
                                attributevalue: orderSuccessData.paymentDate!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "เวลาที่ชำระเงิน",
                                attributevalue: orderSuccessData.paymentTime!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "ช่องทางการชำระเงิน",
                                attributevalue: orderSuccessData.paymentGateway!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "รูปแบบการชำระเงิน",
                                attributevalue: orderSuccessData.paymentChannelText!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "ผู้รับเงิน",
                                attributevalue: orderSuccessData.merchantFullName!,
                                maxWidth: maxWidth,
                              ),
                            ]),
                          ),
                          Container(
                            width: maxWidth,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              "รหัสสินค้า: ${orderSuccessData.productId}",
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
                                              image: NetworkImage(orderSuccessData.productImagePath!),
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
                                            orderSuccessData.productName!,
                                            maxLines: 1,
                                            style: AlvaStyles().headingSize14w800(blackGoMunTo).copyWith(height: 22 / 14),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            orderSuccessData.productOption!,
                                            style: AlvaStyles().headingSize12RegHeight20(blackGoMunTo),
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
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text("ยอดชำระ", style: AlvaStyles().headingSize12RegHeight20(blackGoMunTo)),
                                          ],
                                        )),
                                    SizedBox(
                                      width: (maxWidth / 2) - 32,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${orderSuccessData.amount!} บาท", style: AlvaStyles().headingSize14BoldHeight22(blackGoMunTo)),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text("ยอดชำระนี้รวมภาษีมูลค่าเพิ่มแล้ว",
                                              style: AlvaStyles().headingSize12w400Cordia(spaceGrey).copyWith(height: 20 / 12))
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
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                              ProductAttribute(
                                attributeKey: "ชื่อผู้รับสินค้า",
                                attributevalue: orderSuccessData.customerFullname!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "เบอร์โทรติดต่อ",
                                attributevalue: phoneNumberFormatter(orderSuccessData.customerMobile!),
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "อีเมล",
                                attributevalue: orderSuccessData.customerEmail!,
                                maxWidth: maxWidth,
                              ),
                              ProductAttribute(
                                attributeKey: "ที่อยู่",
                                attributevalue: orderSuccessData.customerAddress!,
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
                                  orderSuccessData.merchantAddress!.replaceAll("\n", ""),
                                  style: AlvaStyles().headingSize12RegHeight20(spaceGrey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              GestureDetector(
                                key: const Key("call_to_merchant_button"),
                                onTap: () {
                                  AmplitudeWebHelper.getInstance().logTapTapOnCallMerchantButton(
                                    invoiceNumber: orderSuccessData.invoiceNo.toString(),
                                    productName: orderSuccessData.productName.toString(),
                                    merchantName: orderSuccessData.merchantFullName.toString(),
                                  );
                                  String phoneNumber = orderSuccessData.merchantMobile!.replaceAll("-", "");
                                  callPhone(phoneNumber);
                                },
                                child: Text(
                                  "โทร ${phoneNumberFormatter(orderSuccessData.merchantMobile!)}",
                                  style: AlvaStyles().headingSize16BoldHeight32(blackGoMunTo),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]),
                          ),
                          DisclaimerSection(),
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
                                    AmplitudeWebHelper.getInstance().logTapOnCallCenterButtonSuccessScreen(
                                      invoiceNumber: orderSuccessData.invoiceNo.toString(),
                                      productName: orderSuccessData.productName.toString(),
                                      merchantName: orderSuccessData.merchantFullName.toString(),
                                    );
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
                          AmplitudeWebHelper.getInstance().logTapOnOrderTrackingButtonSuccessScreen(
                            invoiceNumber: orderSuccessData.invoiceNo.toString(),
                            productName: orderSuccessData.productName.toString(),
                            merchantName: orderSuccessData.merchantFullName.toString(),
                          );
                          setUrlStrategyListener(ChangeHistoryUrlStrategy(title: Routes.initial.name, urlPromptBuy: Routes.initial.toStringPath()));
                          Navigator.pushNamed(context, '/trackingList');
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
            } else if (state.orderSuccessStatus == GetOrderSuccessDataStatus.initial ||
                state.orderSuccessStatus == GetOrderSuccessDataStatus.loading) {
              return const LoadingScreen();
            } else if (state.orderSuccessStatus == GetOrderSuccessDataStatus.cancel) {
              AmplitudeWebHelper.getInstance().logEnterPaymentFailPage(
                  invoiceNumber: orderSuccessData.invoiceNo.toString(),
                  productName: orderSuccessData.productName.toString(),
                  contentId: orderSuccessData.productId.toString(),
                  merchantName: orderSuccessData.merchantFullName.toString(),
                  price: orderSuccessData.amount.toString(),
                  paymentType: orderSuccessData.paymentChannelText.toString(),
                  userLocation: orderSuccessData.customerAddress.toString());
              return OrderCancelScreen();
            } else {
              return ErrorScreen(
                title: ErrorConst().titleNS,
                subTitle: ErrorConst().subTitleNS,
                titleBtn: ErrorConst().titleBtnNS,
                onTap: () {
                  loadInvoice();
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: (maxWidth / 2) - 32,
            child: Text(
              attributeKey,
              style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 20 / 12),
            ),
          ),
          SizedBox(
            width: (maxWidth / 2) - 32,
            child: Text(
              attributevalue,
              style: AlvaStyles().headingSize12w500(blackGoMunTo).copyWith(height: 20 / 12),
            ),
          )
        ],
      ),
    );
  }
}
