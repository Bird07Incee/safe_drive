import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart' as fll;
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/helpers/term_and_con_helper.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/term_and_con/term_and_con_section.dart';
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
  final liff = fll.FlutterLineLiff();

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

  void acceptTermAndCond() async {
    try {
      GeneralDialog().showLoadingDialog(context: context);
      final baseUrl = Environment().getValue("BFF_BASE_URL");
      final socialApiPath = Environment().getValue("BFF_SOCIAL_BASE_URL");
      bool codeVerify = lineDataHelper.getLineAccessToken().isNotEmpty;
      if (!codeVerify) {
        Response response = await dioUtilityRepository
            .postByURL("$baseUrl$socialApiPath/line/token", {"code": lineDataHelper.getLineCode()});
        if (response.statusCode == 200) {
          codeVerify = true;
          lineDataHelper.saveSocialDataToLocalStorage(json.encode(response.data));
        }
      }
      if (codeVerify) {
        String accessToken = lineDataHelper.getLineAccessToken();
        Response responseTerm = await dioUtilityRepository.postByURL(
            "$baseUrl$socialApiPath/accept/termandcond", {"uid": lineDataHelper.getLineUid()},
            headers: {"Authorization": "Bearer $accessToken"});
        if (responseTerm.statusCode == 200) {
          termAndConHelper.setTermAndConToAccept();
          //stamp version
          if (!mounted) return;
          Navigator.of(context).pop();
        }
      }

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
      _handleError();
    }
  }

  void _handleError() {
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ErrorScreen(
        title: ErrorConst().titleNS,
        subTitle: lineDataHelper.getLineCode(),
        titleBtn: ErrorConst().titleBtnNS,
        onTap: () {
          Navigator.of(context).pop();
          acceptTermAndCond();
        },
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;

    const mockText =
        "ข้อมูลที่เกี่ยวข้องกับตัวลูกค้าหรือบุคคลใดนั้น จะถูกนำไปใช้เพื่อ วัตถุประสงค์ในการดำเนินงานของกรุงศรี ออโต้และบริษัทในเครืออย่าง ถูกต้องตามกฎหมายเท่านั้น และนำไปใช้เพื่อการออกแบบผลิตภัณฑ์และบริการของกรุงศรี ออโต้ และข้อเสนอพิเศษต่างๆ ที่ดีขึ้นกว่า เดิม เพื่อให้เป็นไปตามความต้องการของลูกค้าและการให้บริการที่ดีที่สุด ข้อมูลของลูกค้าจะไม่ถูกนำไปใช้ เก็บรวบรวม หรือสงวนไว้ หากกรุงศรี ออโต้ไม่มีวัตถุประสงค์ในการดำเนินการดังกล่าว ทั้งนี้กรุงศรี ออโต้จะเก็บรวบรวมข้อมูลส่วนบุคคลของท่านต่อเมื่อกรุงศรี ออโต้ได้รับข้อมูลจากท่านโดยตรง โดยการสมัครหรือลงทะเบียนผ่าน เว็บไซต์สำหรับให้กรุงศรี ออโต้ใช้ในการติดต่อกับท่าน หากท่าน เลือกที่จะให้ข้อมูลส่วนบุคคล เช่น ชื่อ นามสกุล วันเดือนปีเกิด เลขบัตรประจำตัวประชาชน ที่อยู่ ไปรษณีย์อิเล็กทรอนิกส์ เบอร์โทรศัพท์ หรือเบอร์โทรสาร ภาพถ่ายใบหน้า ลายนิ้วมือ ม่านตา เป็นต้น แก่กรุงศรี ออโต้ ตลอดจนกิจกรรมทางธุรกิจหรือการดำเนิน ธุรกรรมใดๆ ของท่านแก่กรุงศรี ออโต้แล้ว กรุงศรีออโต้จะรักษาข้อมูล เหล่านั้นไว้เป็นความลับตามเกณฑ์มาตรฐานความปลอดภัยชั้นสูงของกรุงศรี ออโต้";

    return WillPopScope(
      onWillPop: () async => false,
      child: AlvaRootWidget(
          titlePage: titleWebPage,
          child: Column(
            children: [
              AppBar(
                title: AlvaText(
                    title: "ข้อกำหนดและเงื่อนไข",
                    textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                titleSpacing: 16,
                leadingWidth: 60,
                centerTitle: false,
                automaticallyImplyLeading: false,
              ),
              Container(
                  width: maxWidth,
                  height: maxHeight - (56 + 96),
                  color: const Color(0xfff3f3f3),
                  child: ListView(controller: _controller, children: const [TermAndConSection()])),
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
                            liff.closeWindow();
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
                            acceptTermAndCond();
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
          )),
    );
  }
}
