import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';

class TrackingListNoProduct extends StatelessWidget {
  const TrackingListNoProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return AlvaRootWidget(
      titlePage: titleWebPage,
      child: Column(
        children: [
          Expanded(
              child: Container(
            color: whitePure,
            width: maxWidth,
            child: SizedBox(
              width: maxWidth - 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 64, height: 68, child: Image.asset('assets/images/category/icon_box_no_status.png')),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("คุณไม่มีสถานะจัดส่ง", style: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          )),
          Container(
              width: maxWidth,
              height: 96,
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: GestureDetector(
                key: const Key("back_to_home_page"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, Routes.initial.toStringPath(), (route) => false);
                },
                child: Container(
                  height: 48,
                  width: (maxWidth - 40) / 2,
                  decoration: BoxDecoration(color: const Color(0xffffd400), borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Center(child: Text("กลับสู่หน้าหลัก", style: AlvaStyles().heading3())),
                ),
              ))
        ],
      ),
    );
  }
}
