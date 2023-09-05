import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, this.title, this.subTitle, this.titleBtn, this.onTap}) : super(key: key);
  final String? title;
  final String? subTitle;
  final String? titleBtn;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;

    return AlvaRootWidget(
        titlePage: "Marketplace LINE OA mini",
        child: Container(
          color: Colors.white,
          height: maxHeight,
          width: maxWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
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
                    AlvaText(title: title!, textStyle: AlvaStyles().headingSize16w600(const Color(0xff2C2626))),
                    const SizedBox(
                      height: 8,
                    ),
                    AlvaText(title: subTitle!, textStyle: AlvaStyles().headingSize12w400(const Color(0xff2C2626))),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: 160,
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () {
                          onTap!();
                        },
                        style: AlvaStyles().outlineButtonStyle(Colors.transparent, const Color(0xff6F5F5E), 8),
                        child: AlvaText(title: titleBtn!, textStyle: AlvaStyles().heading2(const Color(0xff2C2626))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
