import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/helpers/term_and_con_helper.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

class TermAndConScreen extends StatefulWidget {
  const TermAndConScreen({super.key});

  @override
  State<TermAndConScreen> createState() => _TermAndConScreenState();
}

class _TermAndConScreenState extends State<TermAndConScreen> {
  final _controller = ScrollController();
  bool scrollFinished = false;
  TermAndConHelper termAndConHelper = TermAndConHelper();
  DioUtilityRepository dioUtilityRepository = DioUtilityRepository(service: DioUtilityService());
  LineDataHelper lineDataHelper = LineDataHelper();

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isBottom = _controller.position.pixels != 0;
        if (isBottom) {
          setState(() {
            scrollFinished = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;

    const mockText =
        "ข้อมูลที่เกี่ยวข้องกับตัวลูกค้าหรือบุคคลใดนั้น จะถูกนำไปใช้เพื่อ วัตถุประสงค์ในการดำเนินงานของกรุงศรี ออโต้และบริษัทในเครืออย่าง ถูกต้องตามกฎหมายเท่านั้น และนำไปใช้เพื่อการออกแบบผลิตภัณฑ์และบริการของกรุงศรี ออโต้ และข้อเสนอพิเศษต่างๆ ที่ดีขึ้นกว่า เดิม เพื่อให้เป็นไปตามความต้องการของลูกค้าและการให้บริการที่ดีที่สุด ข้อมูลของลูกค้าจะไม่ถูกนำไปใช้ เก็บรวบรวม หรือสงวนไว้ หากกรุงศรี ออโต้ไม่มีวัตถุประสงค์ในการดำเนินการดังกล่าว ทั้งนี้กรุงศรี ออโต้จะเก็บรวบรวมข้อมูลส่วนบุคคลของท่านต่อเมื่อกรุงศรี ออโต้ได้รับข้อมูลจากท่านโดยตรง โดยการสมัครหรือลงทะเบียนผ่าน เว็บไซต์สำหรับให้กรุงศรี ออโต้ใช้ในการติดต่อกับท่าน หากท่าน เลือกที่จะให้ข้อมูลส่วนบุคคล เช่น ชื่อ นามสกุล วันเดือนปีเกิด เลขบัตรประจำตัวประชาชน ที่อยู่ ไปรษณีย์อิเล็กทรอนิกส์ เบอร์โทรศัพท์ หรือเบอร์โทรสาร ภาพถ่ายใบหน้า ลายนิ้วมือ ม่านตา เป็นต้น แก่กรุงศรี ออโต้ ตลอดจนกิจกรรมทางธุรกิจหรือการดำเนิน ธุรกรรมใดๆ ของท่านแก่กรุงศรี ออโต้แล้ว กรุงศรีออโต้จะรักษาข้อมูล เหล่านั้นไว้เป็นความลับตามเกณฑ์มาตรฐานความปลอดภัยชั้นสูงของกรุงศรี ออโต้";

    return AlvaRootWidget(
        titlePage: "term",
        child: Column(
          children: [
            Container(
              height: 56,
              width: maxWidth,
              color: Colors.white,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "ข้อกำหนดและเงื่อนไข",
                      style: AlvaStyles().heading1(),
                    )
                  ]),
                ),
              ),
            ),
            Container(
              width: maxWidth,
              height: maxHeight - (56 + 96),
              color: const Color(0xfff3f3f3),
              child: ListView(controller: _controller, children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        "การรับรองความถูกต้องของข้อมูล",
                        style: AlvaStyles().heading2(Color(0xff5a5a5a)),
                      )),
                ),
                Container(
                  width: maxWidth,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      mockText,
                      style: AlvaStyles().body1(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        "การยินยอมให้เปิดเผยข้อมูลส่วนตัว",
                        style: AlvaStyles().heading2(Color(0xff5a5a5a)),
                      )),
                ),
                Container(
                  width: maxWidth,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      mockText,
                      style: AlvaStyles().body1(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        "การยินยอมให้เปิดเผยข้อมูลส่วนตัว",
                        style: AlvaStyles().heading2(Color(0xff5a5a5a)),
                      )),
                ),
                Container(
                  width: maxWidth,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      mockText,
                      style: AlvaStyles().body1(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        "การยินยอมให้เปิดเผยข้อมูลส่วนตัว",
                        style: AlvaStyles().heading2(Color(0xff5a5a5a)),
                      )),
                ),
                Container(
                  width: maxWidth,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      mockText,
                      style: AlvaStyles().body1(),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: maxWidth,
                  height: 16,
                )
              ]),
            ),
            Container(
              alignment: Alignment.topCenter,
              width: maxWidth,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff000000).withOpacity(0.04),
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: const Offset(0, -4)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (scrollFinished) {
                          print("deny click");
                        }
                      },
                      child: Container(
                        height: 48,
                        width: (maxWidth - 40) / 2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: scrollFinished ? const Color(0xffffd400) : const Color(0xffdedede), width: 2)),
                        child: Center(
                            child: Text(
                          "ไม่ยอมรับ",
                          style: scrollFinished ? AlvaStyles().heading3() : AlvaStyles().heading3Muted(),
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (scrollFinished) {
                          print("accept click");
                          termAndConHelper.setTermAndConToAccept();

                          String code = lineDataHelper.getLineCode();
                          Response response = await dioUtilityRepository.postByURL(
                              "https://api.marketplace.ksauto.net/mercury-social-dev/line/token", {"code": code});
                          if (response.statusCode == 200) {
                            lineDataHelper.saveSocialDataToLocalStorage(response.data);
                          }

                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        height: 48,
                        width: (maxWidth - 40) / 2,
                        decoration: BoxDecoration(
                            color: scrollFinished ? const Color(0xffffd400) : const Color(0xffdedede),
                            borderRadius: const BorderRadius.all(Radius.circular(8))),
                        child: Center(
                            child: Text("ยอมรับ",
                                style: scrollFinished ? AlvaStyles().heading3() : AlvaStyles().heading3Muted())),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
