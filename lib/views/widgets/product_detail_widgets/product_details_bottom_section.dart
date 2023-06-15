import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:marketplace_line_oa/controllers/product_controller.dart';
import 'package:marketplace_line_oa/helpers/extensions.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height - 40;
    return GetBuilder<ProductController>(
      builder: (pc) {
        return Container(
          margin: EdgeInsets.only(bottom: (maxHeight * 0.1) + 32.0),
          width: maxWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                key: const Key("banner_select_loan_button"),
                onTap: () {
                },
                child: SizedBox(
                  width: maxWidth,
                  child: Image.asset(
                    "assets/images/banner_ps_dld.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "เกี่ยวกับผู้ขาย",
                    key: const Key("dealer_detail_title"),
                    style: const TextTheme().bodyLarge?.copyWith(fontSize: 16),
                  )),
              pc.selectedProduct.value!.dealerName != null &&  pc.selectedProduct.value!.dealerName != ""
                  ? Container(
                      height: 24.0,
                      margin: const EdgeInsets.only(top: 16.0),
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                        pc.selectedProduct.value!.dealerName!,
                        style: const TextTheme().bodyLarge?.copyWith(fontSize: 14),
                      ),
                    )
                  : SizedBox(
                      height: pc.selectedProduct.value!.dealerAddressLatLong != "" &&
                              pc.selectedProduct.value!.dealerAddressLatLong != null
                          ? 16.0
                          : 0,
                    ),
              pc.selectedProduct.value!.dealerAddress != null && pc.selectedProduct.value!.dealerAddress != ""
                  ? Container(
                      height: 32.0,
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                        pc.selectedProduct.value!.dealerAddress!,
                        style: const TextTheme().bodyMedium?.copyWith(fontSize: 10),
                      ),
                    )
                  : const SizedBox(),
              Container(
                margin: const EdgeInsets.only(top: 6.0),
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 96,
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: GestureDetector(
                                    key: const Key("open_dealer_contact_button"),
                                    onTap: () async {
                                      // GeneralDialog().showDealerContactDialog(context);
                                    },
                                    child: Container(
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: const Color(0xffDEDEDE)),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            width: 24.0,
                                            height: 24.0,
                                            child: Image.asset(
                                              "assets/icons/icon_call.png",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        )),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                            key: const Key("open_dealer_location_button"),
                            onTap: () async {
                            },
                            child: Container(
                              height: 40,
                              width: maxWidth * 0.65,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffDEDEDE)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                  child: Text(pc.selectedProduct.value!.dealerMobileNumberMap!.first.phoneNumber!,
                                      style: const TextStyle(fontSize: 16))),
                            ),
                          ))
                    ]),
              ),
              Container(
                  key: const Key("annotation_section"),
                  width: maxWidth,
                  margin: const EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        height: 24.0,
                        child: Text(
                          "หมายเหตุ",
                          style: const TextTheme().bodyLarge?.copyWith(fontSize: 14),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("  •  ", style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2)),
                          Expanded(
                            child: Text(
                              "ลูกค้าที่สนใจกรุณาติดต่อผู้ขายรถ เพื่อตรวจสอบสถานะของรถ ก่อนที่จะทำการสมัครสินเชื่อ",
                              style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("  •  ", style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2)),
                          Expanded(
                            child: Text(
                              "กรุงศรี ออโต้เป็นเพียงผู้ให้บริการสินเชื่อรถเท่านั้น",
                              style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("  •  ", style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2)),
                          Expanded(
                            child: Text(
                              "ข้อมูลรถที่ประกาศขายเป็นความตกลงระหว่างผู้ขายรถ กับผู้ให้บริการซื้อขายรถออนไลน์ (แพลตฟอร์มซื้อขายรถออนไลน์)",
                              style: const TextTheme().bodyMedium?.copyWith(fontSize: 12, height: 2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }
}
