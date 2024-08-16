import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';

class OrderCancelScreen extends StatelessWidget {
  const OrderCancelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return RootPageCondition(
      child: AlvaRootWidget(
          titlePage: titleWebPage,
          child: Column(
            children: [
              Container(
                color: whitePure,
                height: maxHeight - 96,
                width: maxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 356,
                      width: maxWidth - 30,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: cloudSoftDeepWhite,
                            size: 125,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text("ขออภัย", style: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                          Text("คุณทำรายการไม่สำเร็จ", style: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text("กรุณาทำรายการใหม่อีกครั้ง", style: AlvaStyles().bodySize14w400(BTN_SELECTED_TEXT_COLOR_NEW)),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                      showOneTrustCookieScript();
                      AmplitudeWebHelper.getInstance().logTapOneMarketplaceHomepageButton();
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
          )),
    );
  }
}
