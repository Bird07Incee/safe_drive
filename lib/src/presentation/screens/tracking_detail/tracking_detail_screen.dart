import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/tracking_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/tracking_detail/tracking_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/disclaimer_bottom_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';

class TrackingDetailScreen extends StatefulWidget {
  const TrackingDetailScreen({super.key});

  @override
  State<TrackingDetailScreen> createState() => _TrackingDetailState();
}

class _TrackingDetailState extends State<TrackingDetailScreen> {
  late RouteSettings? settings;
  String orderNo = "";
  String productId = "";
  bool isLoaded = false;
  late double maxWidth, maxHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      isLoaded = true;
      loadTracking();
    }
  }

  void loadTracking() {
    settings = ModalRoute.of(context) != null ? ModalRoute.of(context)!.settings : null;
    if (settings != null) {
      var uriData = Uri.parse(settings!.name!);
      var routingData = RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
      orderNo = (routingData["orderNo"] == null) ? "" : routingData["orderNo"];
      productId = (routingData["pid"] == null) ? "" : routingData["pid"];
      context.read<TrackingDetailBloc>().add(GetTracking(orderNo: orderNo, productId: productId));
    }
  }

  void onBack(BuildContext context) {
    Navigator.pop(context);
  }

  Widget rowOfKeyValue(String k, String v, {bool isActive = false, bool withCopy = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            child: Text(
              k,
              style: AlvaStyles().headingSize10w500(isActive ? blackGoMunTo : grey300).copyWith(height: 2.4),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            padding: EdgeInsets.only(left: 16.0),
            child: withCopy
                ? Row(
                    children: [
                      Expanded(
                          child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: SelectableText(
                                v,
                                style: AlvaStyles().headingSize10w500(isActive ? blackGoMunTo : grey300).copyWith(height: 2.4),
                              ),
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                  key: const Key("copy_tracking"),
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(text: v));
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("คัดลอกลงคลิปบอร์ด")));
                                  },
                                  child: Text(
                                    " [คัดลอก]",
                                    style: AlvaStyles().headingSize10w500(isActive ? btnBlue : grey300).copyWith(height: 2.4),
                                  )),
                            )
                          ],
                        ),
                      ))
                    ],
                  )
                : Text(
                    v,
                    style: AlvaStyles().headingSize10w500(isActive ? blackGoMunTo : grey300).copyWith(height: 2.4),
                  ),
          ),
        )
      ],
    );
  }

  List<Widget> trackingStatuses(TrackingModel t) {
    List<Widget> l = [];
    for (var s in t.status) {
      if (s.statusName.isPending) {
        l.add(Container(padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16), child: statusPending(s)));
      } else if (s.statusName.isPreparing || s.statusName.isPreparingSelfServiceFail) {
        l.add(Container(padding: EdgeInsets.only(left: 24, right: 24, top: 16), child: statusPreparing(s)));
      } else if (s.statusName.isShipped || s.statusName.isShippingFail) {
        l.add(Container(padding: EdgeInsets.only(left: 24, right: 24, top: 16), child: statusShipped(s)));
      } else if (s.statusName.isReceived) {
        l.add(Container(padding: EdgeInsets.only(left: 24, right: 24, top: 16), child: statusReceived(s)));
      } else if (s.statusName.isRefundRequest) {
        l.add(Container(child: statusReturn(s)));
      } else if (s.statusName.isRefundSuccess) {
        l.add(Container(child: statusRefund(s)));
      } else if (s.statusName.isRefundRejected) {
        //do nothing
      }
    }
    return l;
  }

  Widget statusTitle(Widget icon, String title, bool isActive, {String dt = ""}) {
    return Column(
      children: [
        dt != ""
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: icon,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          title,
                          style: AlvaStyles().headingSize12w700(isActive ? btnBlue : grey300).copyWith(height: 2),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Text(
                    dt,
                    textAlign: TextAlign.end,
                    style: AlvaStyles().headingSize10w500(isActive ? blackGoMunTo : grey300).copyWith(height: 2.4),
                  ))
                ],
              )
            : Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: icon,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      title,
                      style: AlvaStyles().headingSize12w700(isActive ? btnBlue : grey300).copyWith(height: 2),
                    ),
                  ),
                ],
              ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget statusContent(List<StatusDetail> details, {bool isPayment = false, bool isActive = false}) {
    List<Widget> l = [];
    for (var d in details) {
      if (d.column1 != "" && d.column2 != "") {
        l.add(rowOfKeyValue(d.column1, d.column2, isActive: isActive, withCopy: d.isCopyButton));
      } else if (d.column1 != "" && d.column2 == "" && !d.isHighlight && !d.isCopyButton) {
        Widget text = SizedBox(
          width: maxWidth - 88,
          child: Text(
            d.column1,
            style: AlvaStyles().headingSize10w500(isActive ? blackGoMunTo : grey300).copyWith(height: 2.4),
          ),
        );
        l.add(text);
      } else if (d.column1 != "" && d.column2 == "" && d.isHighlight && !d.isCopyButton) {
        Widget highlightText = Padding(
          padding: EdgeInsets.only(top: 8),
          child: Container(
            width: maxWidth - 88,
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Color(0xffe7f4ff)),
            child: Text(
              d.column1,
              style: AlvaStyles().headingSize8w600(isActive ? blackGoMunTo : grey300).copyWith(height: 2),
            ),
          ),
        );
        l.add(highlightText);
      }
    }

    if (!isPayment) {
      return Container(
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(border: Border(left: BorderSide(width: 4, color: Color(0xffe8e7e7)))),
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: l),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: l,
        ),
      );
    }
  }

  Widget statusReceived(Status s) {
    return Column(
      children: [
        statusTitle(
            Image.asset('assets/icons/received_${s.state.isActive ? "" : "in"}active.png', fit: BoxFit.fitWidth), "จัดส่งสำเร็จ", s.state.isActive,
            dt: s.statusDateTime),
        statusContent(s.details, isActive: s.state.isActive),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget statusShipped(Status s) {
    return Column(
      children: [
        statusTitle(
            Image.asset('assets/icons/shipped_${s.state.isActive ? "" : "in"}active.png', fit: BoxFit.fitWidth), "กำลังจัดส่ง", s.state.isActive,
            dt: s.statusDateTime),
        statusContent(s.details, isActive: s.state.isActive),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget statusPreparing(Status s) {
    return Column(
      children: [
        statusTitle(
            Image.asset('assets/icons/packed_${s.state.isActive ? "" : "in"}active.png', fit: BoxFit.fitWidth), "เตรียมจัดส่ง", s.state.isActive,
            dt: s.statusDateTime),
        statusContent(s.details, isActive: s.state.isActive),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget statusPending(Status s) {
    return Column(
      children: [
        statusTitle(Image.asset('assets/icons/paid_inactive.png', fit: BoxFit.fitWidth), "ชำระเงินแล้ว", false, dt: s.statusDateTime),
        statusContent(s.details, isPayment: true, isActive: s.state.isActive),
      ],
    );
  }

  ///TODO: return and refund status_detail json???
  Widget statusReturn(Status s) {
    List<Widget> l = [];
    for (var col in s.details) {
      List<String> listCol = col.column1.split("\n");
      for (int i = 0; i < listCol.length; i++) {
        l.add(SizedBox(
          child: Text(
            listCol[i],
            style: i == 0
                ? AlvaStyles().headingSize12w600(blackGoMunTo).copyWith(height: 2.4)
                : AlvaStyles().headingSize10w500(blackGoMunTo).copyWith(height: 2.4),
          ),
        ));
      }
    }
    return Container(
      color: Color(0xfffeedcd),
      padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('assets/icons/return.png', fit: BoxFit.fitWidth),
          ),
          SizedBox(
            width: 16,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: l)
        ],
      ),
    );
  }

  Widget statusRefund(Status s) {
    List<Widget> l = [];

    for (var col in s.details) {
      List<String> listCol = col.column1.split("\n");
      for (int i = 0; i < listCol.length; i++) {
        if (i == 0) {
          l.add(
            Text(
              s.statusDateTime,
              style: AlvaStyles().headingSize10w500(blackGoMunTo).copyWith(height: 2.4),
            ),
          );
        }
        l.add(
          Text(
            listCol[i],
            style: i == 0
                ? AlvaStyles().headingSize12w700(blackGoMunTo).copyWith(height: 2.4)
                : s.statusName.isRefundSuccess
                    ? AlvaStyles().headingSize14w400Cordia(blackGoMunTo)
                    : AlvaStyles().headingSize10w500(blackGoMunTo).copyWith(height: 2.4),
          ),
        );
      }
    }

    return Container(
      color: Color(0xfffeedcd),
      padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('assets/icons/refund.png', fit: BoxFit.fitWidth),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: l))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;
    return RootPageCondition(
        child: WillPopScope(
      onWillPop: () async {
        onBack(context);
        return false;
      },
      child: AlvaRootWidget(
        titlePage: titleWebPage,
        appBar: AppBar(
          title: AlvaText(
              title: "รายละเอียดการจัดส่ง", textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 24 / 18)),
          titleSpacing: 0,
          elevation: 0.4,
          leadingWidth: 60,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
              key: const Key("back_btn_tracking"),
              onPressed: () {
                onBack(context);
              },
              icon: const Icon(Icons.arrow_back_ios_rounded)),
        ),
        child: BlocBuilder<TrackingDetailBloc, TrackingDetailState>(
          builder: (context, state) {
            if (state.status.isSuccess) {
              hideOneTrustCookieScript();
              return ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    width: maxWidth,
                    height: maxHeight - 51,
                    child: Stack(
                      children: [
                        ///tracking timeline
                        ListView(
                          children: [
                            SizedBox(
                              width: maxWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: trackingStatuses(state.tracking),
                              ),
                            ),
                            SizedBox(
                              width: maxWidth,
                              child: Column(
                                children: [
                                  Container(
                                    width: maxWidth,
                                    height: 16,
                                    color: backgroundNo2,
                                  ),
                                  Container(
                                    width: maxWidth,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 16.0),
                                          child: Text(
                                            "ติดต่อผู้ขาย",
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
                                            Expanded(
                                              child: Text(
                                                "เกี่ยวกับสินค้า การจัดส่ง การคืนสินค้า และการคืนเงิน",
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2.4),
                                              ),
                                            )
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
                                            Expanded(
                                              child: Text(
                                                "การคืนสินค้า/คืนเงินหลังจาก ${state.tracking.refundDay} วัน กรุณาติดต่อผู้ขายโดยตรง",
                                                style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2.4),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16.0,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                key: const Key("call_seller"),
                                                onTap: () {
                                                  String mobile = state.tracking.merchantNumber.replaceAll('-', '');
                                                  callPhone(mobile);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      border: Border.all(width: 2, color: cloudSoftDeepWhite)),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                          width: 16, height: 16, child: Image.asset('assets/icons/phone.png', fit: BoxFit.fitWidth)),
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 8),
                                                        child: Text(
                                                          "ติดต่อผู้ขาย",
                                                          style: AlvaStyles().headingSize12w700(blackGoMunTo).copyWith(height: 2),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            state.tracking.refundable
                                                ? Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (state.tracking.refundDay > 0 && !state.tracking.disableRefundButton) {
                                                          Navigator.pushNamed(context,
                                                              '${Routes.refundFormTracking.toStringPath()}?orderNo=$orderNo&pid=$productId&refundDay=${state.tracking.refundDay}');
                                                        }
                                                      },
                                                      child: Container(
                                                          margin: EdgeInsets.only(left: 8),
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                            border: Border.all(
                                                              width: 2,
                                                              color: cloudSoftDeepWhite,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "คืนสินค้า/คืนเงิน",
                                                              style: AlvaStyles()
                                                                  .headingSize12w700(
                                                                      state.tracking.refundDay > 0 && !state.tracking.disableRefundButton
                                                                          ? blackGoMunTo
                                                                          : grey300)
                                                                  .copyWith(height: 2),
                                                            ),
                                                          )),
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DisclaimerSection(),
                            SizedBox(height: 88),
                          ],
                        ),
                        ///bottomSheet
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            color: spaceGrey,
                            width: maxWidth,
                            height: 88,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                AlvaText(
                                  title: HomeConst().askInformation,
                                  textStyle: AlvaStyles().headingSize10w600(whiteFalse).copyWith(height: 1.6),
                                ),
                                GestureDetector(
                                  key: const Key("call_button"),
                                  onTap: () {
                                    String phoneNumber = HomeConst().pleaseContactNumber;
                                    callPhone(phoneNumber);
                                  },
                                  child: Text(
                                    HomeConst().pleaseContact,
                                    style: AlvaStyles().headingSize12w700(whiteFalse).copyWith(height: 2),
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else if (state.status.isLoading || state.status.isInitial) {
              return LoadingScreen();
            } else {
              return ErrorScreen(
                title: ErrorConst().titleNS,
                subTitle: ErrorConst().subTitleNS,
                titleBtn: ErrorConst().titleBtnNS,
                onTap: () {
                  loadTracking();
                },
              );
            }
          },
        ),
      ),
    ));
  }
}
