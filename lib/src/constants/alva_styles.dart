import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';

class AlvaStyles {
  TextStyle heading1() => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  TextStyle heading2(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.bold, color: color);

  TextStyle heading3() => const TextStyle(
      fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.bold, color: BTN_SELECTED_TEXT_COLOR_NEW);

  TextStyle heading3Muted() =>
      const TextStyle(fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.bold, color: smockGrey);

  TextStyle headingSize12w400(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w400, color: color);
  TextStyle headingSize22w700(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 22, fontWeight: FontWeight.w700, color: color);

  TextStyle headingSize32() => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );

  TextStyle headingSize10w400(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 10, fontWeight: FontWeight.w400, color: color);
  TextStyle headingSize10w500(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 10, fontWeight: FontWeight.w500, color: color);
  TextStyle headingSize10w700(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 10, fontWeight: FontWeight.w700, color: color);

  TextStyle headingSize10() => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      );
  TextStyle headingSize16w500(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w500, color: color);
  TextStyle headingSize16w600(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w600, color: color);
  TextStyle headingSize16w700(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w700, color: color);

  TextStyle headingSize12w700(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.bold, color: color);
  TextStyle headingSize18w700(Color color) =>
      TextStyle(fontFamily: fontFamily, fontSize: 18, fontWeight: FontWeight.w700, color: color);
  TextStyle discountPriceTxt14w400(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
      decoration: TextDecoration.lineThrough);

  TextStyle body1() => const TextStyle(fontFamily: fontFamily, fontSize: 12, color: BTN_SELECTED_TEXT_COLOR_NEW);

// ---------------------------------ButtonStyle-----------------------------------------------------------------------------------------
  ButtonStyle outlineButtonStyle(Color backgroundColor, Color foregroundColor, double borderRadius) => ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        )),
      );

  ButtonStyle outlineNoneBorderButtonStyle(Color backgroundColor, Color foregroundColor) => OutlinedButton.styleFrom(
        side: BorderSide.none,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      );
}
