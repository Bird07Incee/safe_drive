import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/tracking/tracking_order_card.dart';

class TrackingListScreen extends StatelessWidget {
  const TrackingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootPageCondition(
      child: AlvaRootWidget(
          titlePage: titleWebPage,
          appBar: AppBar(
            title: AlvaText(title: "ตรวจสอบสถานะสินค้า", textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
            titleSpacing: 0,
            leadingWidth: 60,
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: IconButton(
                key: const Key("pop_navigator_to_home_page"),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_rounded)),
          ),
          child: Container(
            color: cloudDeepWhite,
            child: ListView(
              children: [
                Container(
                  height: 8,
                  color: Colors.white,
                ),
                TrackingOrderCard(),
                TrackingOrderCard()
              ],
            ),
          )),
    );
  }
}
