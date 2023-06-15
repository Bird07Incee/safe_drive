import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/constants/mkp_styles.dart';

typedef BottomSheetButtonClicked = Function();

class BottomSheetCustom extends StatelessWidget {
  const BottomSheetCustom(
      {Key? key,
      this.btnText = "",
      required this.callback,
      this.textColor = Colors.white,
      this.buttonColor = BTN_SELECTED_TEXT_COLOR})
      : super(key: key);
  final BottomSheetButtonClicked callback;
  final String btnText;
  final Color? textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height - 40;
    return Container(
      width: maxWidth,
      height: (maxHeight * 0.1) + 16,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: maxWidth - 32.0,
              height: (maxWidth - 32.0) / 328 * 48,
              child: GestureDetector(
                key: Key("${key ?? 'see_all_button'}"),
                onTap: () async => callback(),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: buttonColor),
                  child: Center(
                    child: Text(btnText.isEmpty ? 'ดูรถทั้งหมด' : btnText,
                        style: TextStyle(color: textColor, fontSize: 16)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
