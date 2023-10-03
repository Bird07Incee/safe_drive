import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
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
              Container(
                height: 56,
                width: maxWidth,
                color: Colors.white,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      Row(children: [
                        Column(children: [
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 18.0,
                            width: 18.0,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "ข้อกำหนดและเงื่อนไข",
                              style: AlvaStyles().heading1(),
                            )
                          ],
                        ),
                      ]),
                    ]),
                  ),
                ),
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
