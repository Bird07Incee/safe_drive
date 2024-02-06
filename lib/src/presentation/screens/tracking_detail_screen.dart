import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/tracking_model.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';

class TrackingDetailScreen extends StatefulWidget {
  const TrackingDetailScreen({super.key});

  @override
  State<TrackingDetailScreen> createState() => _TrackingDetailState();
}

///TODO:
///-

class _TrackingDetailState extends State<TrackingDetailScreen> {
  late RouteSettings? settings;
  String trackingNo = "";
  late double maxWidth, maxHeight;

  void loadInvoice() {
    settings = ModalRoute.of(context) != null ? ModalRoute.of(context)!.settings : null;
    if (settings != null) {
      var uriData = Uri.parse(settings!.name!);
      var routingData = RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
      trackingNo = (routingData["trackingNo"] == null) ? "" : routingData["trackingNo"];
      print(trackingNo);
    }
  }

  void onBack(BuildContext context) {
    Navigator.pop(context);
  }

  Widget rowOfKeyValue(String k, String v, {bool withCopy = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 92,
          child: Text(
            k,
            style: AlvaStyles().headingSize10w600(grey300).copyWith(height: 2.4),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16.0),
          width: maxWidth - 196,
          child: withCopy
              ? Row(
                  children: [
                    SelectableText(
                      v,
                      style: AlvaStyles().headingSize10w700(grey300).copyWith(height: 2.4),
                    ),
                    GestureDetector(
                        key: const Key("copy_tracking"),
                        onTap: () {
                          ///TODO: check this method working on web
                          Clipboard.setData(ClipboardData(text: v));
                        },
                        child: Text(
                          " [คัดลอก]",
                          style: AlvaStyles().headingSize10w600(btnBlue).copyWith(height: 2.4),
                        )),
                  ],
                )
              : Text(
                  v,
                  style: AlvaStyles().headingSize10w600(grey300).copyWith(height: 2.4),
                ),
        ),
      ],
    );
  }

  // Widget buildShippingStatus(Status s) {
  //   return
  // }

  Widget statusReceived(Status s) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset('assets/icons/received.png', fit: BoxFit.fitWidth),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "จัดส่งสำเร็จ",
                    style: AlvaStyles().headingSize12w700(btnBlue).copyWith(height: 2),
                  ),
                ),
              ],
            ),
            Text(
              "15 ธันวาคม 2566 16:10",
              style: AlvaStyles().headingSize10w500(blackGoMunTo).copyWith(height: 2.4),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(border: Border(left: BorderSide(width: 4, color: Color(0xffe8e7e7)))),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: SizedBox(
              width: maxWidth - 88,
              child: Text(
                "สินค้าถูกจัดส่งสำเร็จแล้ว",
                style: AlvaStyles().headingSize10w600(blackGoMunTo).copyWith(height: 2.4),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget statusShipped(Status s) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset('assets/icons/shipped_active.png', fit: BoxFit.fitWidth),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "กำลังจัดส่ง",
                    style: AlvaStyles().headingSize12w700(btnBlue).copyWith(height: 2),
                  ),
                ),
              ],
            ),
            Text(
              "15 ธันวาคม 2566 16:10",
              style: AlvaStyles().headingSize10w500(blackGoMunTo).copyWith(height: 2.4),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(border: Border(left: BorderSide(width: 4, color: Color(0xffe8e7e7)))),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              children: [
                SizedBox(
                  width: maxWidth - 88,
                  child: Text(
                    "สินค้าอยู่ระหว่างการจัดส่ง",
                    style: AlvaStyles().headingSize10w600(blackGoMunTo).copyWith(height: 2.4),
                  ),
                ),
                rowOfKeyValue("จัดส่งโดย", "J&T Express"),
                rowOfKeyValue("เบอร์โทรติดต่อ", "621625991206", withCopy: true),
                rowOfKeyValue("หมายเลขติดตามพัสดุ", "621625991206", withCopy: true),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget statusPreparing(Status s) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset('assets/icons/packed_active.png', fit: BoxFit.fitWidth),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "เตรียมจัดส่ง",
                    style: AlvaStyles().headingSize12w700(btnBlue).copyWith(height: 2),
                  ),
                ),
              ],
            ),
            Text(
              "15 ธันวาคม 2566 16:10",
              style: AlvaStyles().headingSize10w500(blackGoMunTo).copyWith(height: 2.4),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(border: Border(left: BorderSide(width: 4, color: Color(0xffe8e7e7)))),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: SizedBox(
              width: maxWidth - 88,
              child: Text(
                "ผู้ขายเตรียมพัสดุ เสร็จเรียบร้อยแล้วasdfasdfasdfasdfasdfasdfasdfasdfasdfsa",
                style: AlvaStyles().headingSize10w600(blackGoMunTo).copyWith(height: 2.4),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget statusPending(Status s) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/icons/packed_active.png', fit: BoxFit.fitWidth),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "เตรียมจัดส่ง",
                style: AlvaStyles().headingSize12w700(btnBlue).copyWith(height: 2),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: 4,
                height: 104,
                color: Color(0xffe8e7e7),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "ผู้ขายกำลังเตรียมพัสดุ",
                    style: AlvaStyles().headingSize10w600(blackGoMunTo).copyWith(height: 2.4),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 8),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Color(0xffe7f4ff)),
                    child: Text(
                      "กรณีถ้าสินค้ามีบริการติดตั้ง\nกรุณารอเจ้าหน้าที่ติดต่อกลับ เพื่อนัดหมายวันจัดส่ง และติดตั้งสินค้า\nภายใน 24 ชม. ในวันและเวลาทำการ",
                      style: AlvaStyles().headingSize8w600(btnBlue).copyWith(height: 2),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset('assets/icons/paid_inactive.png', fit: BoxFit.fitWidth),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "ชำระเงินแล้ว",
                    style: AlvaStyles().headingSize12w700(grey300).copyWith(height: 2),
                  ),
                ),
              ],
            ),
            Text(
              "15 ธันวาคม 2566 16:10",
              style: AlvaStyles().headingSize10w500(grey300).copyWith(height: 2.4),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              rowOfKeyValue("หมายเลขอ้างอิง", "REF00005678"),
              rowOfKeyValue("ชำระเงินโดย", "XXXXXXXXXXX1234"),
              rowOfKeyValue("ช่องทางการชำระเงิน", "บัตรเครดิต/เดบิต(ผ่าน 2C2P)"),
              rowOfKeyValue("ผู้รับเงิน", "บริษัท อินโนพาวเวอร์ จำกัด"),
            ],
          ),
        )
      ],
    );
  }

  Widget statusReturn() => Container(
        color: Color(0xfffeedcd),
        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset('assets/icons/return.png', fit: BoxFit.fitWidth),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ได้รับคำขอคืนสินค้า/คืนเงินแล้ว",
                  style: AlvaStyles().headingSize12w700(grey300).copyWith(height: 2),
                ),
                Text(
                  "กรุณารอผู้ขายติดต่อกลับภายใน 3 - 5 วันทำการ",
                  style: AlvaStyles().headingSize10w500(grey300).copyWith(height: 2.4),
                ),
              ],
            )
          ],
        ),
      );

  Widget statusRefund() => Container(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "15 ธันวาคม 2566 16:10",
                  style: AlvaStyles().headingSize10w500(blackGoMunTo).copyWith(height: 2.4),
                ),
                Text(
                  "คืนเงินสำเร็จ",
                  style: AlvaStyles().headingSize12w700(blackGoMunTo).copyWith(height: 2),
                ),
                SizedBox(
                  width: maxWidth - (98 + 16),
                  child: Text(
                    "*การคืนเงินเป็นไปตามเงื่อนไขข้อตกลงของธนาคาร กรุณาตรวจสอบกับธนาคารผู้ออกบัตร",
                    style: AlvaStyles().headingSize10w500(grey300).copyWith(height: 2),
                  ),
                ),
              ],
            )
          ],
        ),
      );

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
        child: ListView(
          children: [
            ///appbar
            Container(
              width: maxWidth,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    spreadRadius: 0,
                    blurRadius: 16,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: IconButton(
                        key: const Key("back_btn_tracking"),
                        onPressed: () {
                          onBack(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded)),
                  ),
                  AlvaText(
                      title: "รายละเอียดการจัดส่ง", textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 24 / 18)),
                ],
              ),
            ),
            statusReturn(),

            ///Refund success
            statusRefund(),

            ///tracking timeline
            Container(
              width: maxWidth,
              padding: EdgeInsets.only(left: 24, top: 16, bottom: 16, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  statusReceived(Status.empty),
                  statusShipped(Status.empty),

                  ///Preparing
                  statusPreparing(Status.empty),

                  ///Preparing self
                  statusPending(Status.empty)
                ],
              ),
            ),

            ///bottomSheet
            SizedBox(
              width: maxWidth,
              height: 56 + 68 + 72 + 88 + 16,
              child: Column(
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
                            Text(
                              "เกี่ยวกับสินค้า การจัดส่ง การคืนสินค้า และการคืนเงิน",
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
                              "การคืนสินค้า/คืนเงินหลังจาก X วัน กรุณาติดต่อผู้ขายโดยตรง",
                              style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                ///TODO: call to seller
                                // String mobile = product.merchantMobile.replaceAll('-', '');
                                // callPhone(mobile);
                              },
                              child: Container(
                                width: maxWidth * .45,
                                height: 40,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 2, color: cloudSoftDeepWhite)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 16, height: 16, child: Image.asset('assets/icons/phone.png', fit: BoxFit.fitWidth)),
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
                            GestureDetector(
                              onTap: () {
                                ///TODO: Call refund
                              },
                              child: Container(
                                  width: maxWidth * .45,
                                  height: 40,
                                  decoration:
                                      BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(width: 2, color: cloudSoftDeepWhite)),
                                  child: Center(
                                    child: Text(
                                      "คืนสินค้า/คืนเงิน",
                                      style: AlvaStyles().headingSize12w700(blackGoMunTo).copyWith(height: 2),
                                    ),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
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
                            RegExp regExp = RegExp(r'\b\d{3}-\d{3}-\d{4}\b');

                            // Extracting the phone number using RegExp
                            String phoneNumber = regExp.stringMatch(HomeConst().pleaseContact) ?? '';
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
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
