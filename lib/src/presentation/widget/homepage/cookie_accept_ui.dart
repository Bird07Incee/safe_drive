import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';

class CookieAcceptUI extends StatelessWidget {
  const CookieAcceptUI({
    super.key,
    required this.maxWidth,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 280,
        color: whitePure,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: maxWidth - 32,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 32, 0, 16),
                    child: AlvaText(
                      title: "กรุงศรี ออโต้ มีการบันทึกและใช้ข้อมูลประวัติของท่านเกี่ยวกับ"
                          "การเข้าชมเว็บไซต์(คุกกี้) เพื่อนำเสนอข่าวสาร บริการ"
                          "ผลิตภัณฑ์และโปรโมชั่น จาก กรุงศรี ออโต้ เมื่อท่านกลับมาใช้"
                          "งานในครั้งต่อไป หากท่านยอมรับนโยบาย ย่อมหมายถึงว่าท่าน"
                          " ยินยอมให้ กรุงศรี ออโต้ บันทึก และใช้คุกกี้จากอุปกรณ์ที่ท่านใช้"
                          "ในการเข้าใช้งานเว็บไซต์ กรุงศรี ออโต้",
                      textStyle: AlvaStyles().headingSize12w400(
                        BTN_SELECTED_TEXT_COLOR_NEW,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: maxWidth - 32,
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigator.pushNamed(context, "cookieSetting");
                      },
                      style: AlvaStyles().outlineButtonStyle(Colors.transparent, sugarRed, 0),
                      child: AlvaText(
                          title: "การตั้งค่าคุกกี้", textStyle: AlvaStyles().heading2(BTN_SELECTED_TEXT_COLOR_NEW)),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: maxWidth - 32,
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: AlvaStyles().outlineNoneBorderButtonStyle(Color(0xffFFD400), Colors.transparent),
                      child: AlvaText(title: "ยอมรับ", textStyle: AlvaStyles().heading2(BTN_SELECTED_TEXT_COLOR_NEW)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
