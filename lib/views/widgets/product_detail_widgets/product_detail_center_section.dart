import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:marketplace_line_oa/controllers/product_controller.dart';
import 'package:marketplace_line_oa/helpers/extensions.dart';
import 'package:marketplace_line_oa/models/product_list.dart';

class ProductDetailCenterSection extends StatelessWidget {
  const ProductDetailCenterSection({Key? key}) : super(key: key);

  Visibility buildDealerDetailBox(String head, String text, double maxWidth) {
    return Visibility(
      visible: text.isNotEmpty ? true : false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        child: Row(
          children: [
            SizedBox(
              width: maxWidth * 0.5,
              child: Text(head,
                  style: const TextTheme().bodyLarge
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xffA4A8AD))),
            ),
            SizedBox(
              width: maxWidth * 0.3,
              child: Text(text,
                  style: const TextTheme().bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    Widget buildDealerDetail(ProductData carPostData) => Container(
      color: Colors.white,
      child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: carPostData.pdfCertificated!.isNotEmpty ? 0 : 20),
            child: Column(
              children: [
                buildDealerDetailBox("ประเภทผู้ขาย", carPostData.sellerType!, maxWidth),
                buildDealerDetailBox("รหัสประกาศ", carPostData.carRefId!, maxWidth),
                buildDealerDetailBox("ปีที่ผลิต(ค.ศ.)", carPostData.manufactureYear.toString(), maxWidth),
                buildDealerDetailBox("ระบบเชื้อเพลิง", carPostData.fuelType!, maxWidth),
                buildDealerDetailBox("ระบบเกียร์", carPostData.transmission!, maxWidth),
                buildDealerDetailBox(
                    "ขนาดเครื่องยนต์", "${carPostData.engineCapacity!.toDecimalFormat()} ซีซี", maxWidth),
                buildDealerDetailBox("ทะเบียนรถ", carPostData.registration!, maxWidth),
                buildDealerDetailBox("เลขไมล์(กม.)",
                    carPostData.mileage! != 0 ? "${carPostData.mileage!.toDecimalFormat()} กิโลเมตร" : "", maxWidth),
                buildDealerDetailBox("จังหวัด", carPostData.registrationProvince!, maxWidth),
              ],
            ),
          ),
    );
    Widget buildFreeTextDetail(ProductData carPostData, bool isShowMoreText) => GetBuilder<ProductController>(
      builder: (pc) {
        return Column(children: [
              Visibility(
                visible: carPostData.description!.isNotEmpty && carPostData.description!.trim() != "",
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          15,
                          20,
                          15,
                          carPostData.pdfCertificated!.isEmpty && '\n'.allMatches(carPostData.description!).length + 1 <= 10
                              ? 15
                              : 0),
                      child: !isShowMoreText
                          ? Text(
                              carPostData.description!,
                              style: const TextTheme().bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                              maxLines: 10,
                            )
                          : Text(
                              carPostData.description!,
                              style: const TextTheme().bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                            )),
                ),
              ),
              Visibility(
                  visible: carPostData.description!.isEmpty || carPostData.description!.trim() == "",
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 40, 15, carPostData.pdfCertificated!.isEmpty ? 40 : 20),
                      child: Text(
                        "ไม่มีข้อมูลจากผู้ขาย",
                        style: const TextTheme().bodyLarge
                            ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xffA4A8AD)),
                      ))),
              Visibility(
                visible: '\n'.allMatches(carPostData.description!).length + 1 > 10 && !isShowMoreText ? true : false,
                child: GestureDetector(
                  key: const Key("see_more_button"),
                  onTap: () => pc.showMoreDetail(true),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: carPostData.pdfCertificated!.isNotEmpty ? 0 : 20),
                    child: Text(
                      "อ่านเพิ่มเติม",
                      style: const TextTheme().bodyLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff1094f8),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isShowMoreText ? true : false,
                child: GestureDetector(
                  key: const Key("hide_detail_button"),
                  onTap: () => pc.showMoreDetail(true),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: carPostData.pdfCertificated!.isNotEmpty ? 0 : 20),
                    child: Text(
                      "ซ่อนรายละเอียด",
                      style: const TextTheme().bodyLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff1094f8),
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              )
            ]);
      }
    );

    return GetBuilder<ProductController>(
      builder: (pc) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "รายละเอียดสินค้า",
                          style: const TextTheme().bodyLarge?.copyWith(fontSize: 16),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("tab capture");
                      pc.captureImage(buildDealerDetail(pc.selectedProduct.value!),
                          callback: (_) {
                            if(_){
                              print("call back!!");
                            }

                          }
                      );
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(right: 32),
                        child: Icon(Icons.save_alt_rounded, color: Colors.grey.shade900,)
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xffDEDEDE), width: 2.0),
                    ),
                  ),
                ),
                TabBar(
                    controller: pc.tabController,
                    labelColor: Colors.black,
                    indicatorColor: const Color(0xffE91A1A),
                    unselectedLabelColor: const Color(0xffA4A8AD),
                    labelStyle: const TextTheme().bodyLarge?.copyWith(fontSize: 14),
                    onTap: (int index) {
                    },
                    tabs: const [
                      Tab(
                        key: Key("car_detail_tab_view"),
                        text: "ข้อมูลทั่วไป",
                      ),
                      Tab(key: Key("free_text_tab_view"), text: "รายละเอียดอื่นๆ"),
                    ]),
              ],
            ),
            IndexedStack(
              index: pc.selectedTab.value,
              children: <Widget>[
                Visibility(
                  maintainState: true,
                  visible: pc.selectedTab.value == 0,
                  child: buildDealerDetail(pc.selectedProduct.value!),
                ),
                Visibility(
                  maintainState: true,
                  visible: pc.selectedTab.value == 1,
                  child: buildFreeTextDetail(pc.selectedProduct.value!, pc.expandDetail.value),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
