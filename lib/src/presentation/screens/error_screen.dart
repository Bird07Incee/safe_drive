import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    Future<void> openLine() async {
      final Uri deepLink = Uri.parse('https://line.me/R/ti/p/@018qbfet');
      if (!await launchUrl(deepLink)) {
        throw Exception('Could not launch $deepLink');
      }
    }

    return BlocBuilder<CheckBrowserBloc, CheckBrowserState>(
      builder: (context, state) {
        return AlvaRootWidget(
            titlePage: "Marketplace LINE OA mini",
            child: Container(
              color: Colors.white,
              height: maxHeight,
              width: maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 256,
                    width: maxWidth - 30,
                    child: Column(
                      // crossAxisAlignment: ,
                      children: [
                        Image.asset(
                          "assets/images/warning.png",
                          width: 96,
                          height: 96,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AlvaText(
                            title: 'ขออภัยไม่รองรับการให้บริการบน บราวเซอร์นี้ี้',
                            textStyle: AlvaStyles().headingSize16w600(Color(0xff2C2626))),
                        const SizedBox(
                          height: 8,
                        ),
                        AlvaText(
                            title: 'กรุณากด “เปิดไลน์” เพื่อใช้บริการ',
                            textStyle: AlvaStyles().headingSize12w400(Color(0xff2C2626))),
                        const SizedBox(
                          height: 32,
                        ),
                        SizedBox(
                          width: 160,
                          height: 32,
                          child: OutlinedButton(
                            onPressed: () {
                              openLine();
                              // Navigator.pushNamed(context, "cookieSetting");
                            },
                            style: AlvaStyles().outlineButtonStyle(Colors.transparent, Color(0xff6F5F5E), 8),
                            child: AlvaText(title: "เปิดไลน์", textStyle: AlvaStyles().heading2(Color(0xff2C2626))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
