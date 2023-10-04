import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/term_and_con/term_and_con_section.dart';

class ReadTermAndConScreen extends StatelessWidget {
  const ReadTermAndConScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height - 56;

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
                titleSpacing: 0,
                leadingWidth: 60,
                centerTitle: false,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded)),
              ),
              Container(
                  width: maxWidth,
                  height: maxHeight,
                  color: const Color(0xfff3f3f3),
                  child: ListView(children: const [TermAndConSection()]))
            ],
          )),
    );
  }
}
