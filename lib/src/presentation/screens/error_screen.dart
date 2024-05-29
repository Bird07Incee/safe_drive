import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.title, this.subTitle, this.titleBtn, this.onTap, this.subTitleSec = ""});
  final String? title;
  final String? subTitle;
  final String? subTitleSec;
  final String? titleBtn;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: AlvaRootWidget(
          titlePage: titleWebPage,
          child: Column(
            children: [
              Container(
                color: whitePure,
                width: maxWidth,
                height: maxHeight - 96,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: cloudSoftDeepWhite,
                      size: 125,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(title!, style: AlvaStyles().headingSize18w500(BTN_SELECTED_TEXT_COLOR_NEW)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(subTitle!, style: AlvaStyles().headingSize14w400(BTN_SELECTED_TEXT_COLOR_NEW)),
                    subTitleSec!.isNotEmpty
                        ? Text(subTitleSec!, style: AlvaStyles().headingSize14w400(BTN_SELECTED_TEXT_COLOR_NEW))
                        : Container(),
                    const SizedBox(
                      height: 4,
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
                  child: OutlinedButton(
                    onPressed: () {
                      onTap!();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(0),
                    ),
                    child: Container(
                      height: 48,
                      //  width: (maxWidth - 40) / 2,
                      decoration: BoxDecoration(color: const Color(0xffffd400), borderRadius: const BorderRadius.all(Radius.circular(8))),
                      child: Center(child: Text(titleBtn!, style: AlvaStyles().heading4())),
                    ),
                  ))
            ],
          )),
    );
  }
}
