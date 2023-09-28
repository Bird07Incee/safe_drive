import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';

class AlvaStyles {
  TextStyle heading1() => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  TextStyle heading2(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: color);

  TextStyle heading3() => const TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: BTN_SELECTED_TEXT_COLOR_NEW);

  TextStyle heading3Muted() => const TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: smockGrey);

  TextStyle headingSize12w400(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color);

  TextStyle headingSize12w600(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: color);

  TextStyle headingSize22w700(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: color);

  TextStyle headingSize32() => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );
  TextStyle headingSize22(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: color,
      );
  TextStyle headingSize18(Color color) => TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
      );

  TextStyle headingSize22Height32() => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        height: 32 / 22,
      );

  TextStyle headingSize10w400(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: color);
  TextStyle headingSize10w500(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: color);
  TextStyle headingSize10w700(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: color);

  TextStyle headingSize10() => const TextStyle(
        fontFamily: fontFamily,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      );

  TextStyle headingSize10w600(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: color);
  TextStyle headingSize12w500WithHeightFixed(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: color,
      height: 1.4);
  TextStyle headingSize14w700(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: color);

  TextStyle headingSize16w500(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color);
  TextStyle headingSize16w600(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color);
  TextStyle headingSize16w700(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: color);
  TextStyle headingSize12w500(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: color);
  TextStyle headingSize12w700(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: color);
  TextStyle headingSize18w700(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: color);
  TextStyle discountPriceTxt14w400(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color,
      decoration: TextDecoration.lineThrough);

  TextStyle body1() => const TextStyle(
      fontFamily: fontFamily, fontSize: 12, color: BTN_SELECTED_TEXT_COLOR_NEW);

  TextStyle bodySize14w400(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color);

  TextStyle bodySize14W600(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      color: color,
      fontWeight: FontWeight.bold);
  TextStyle bodySize16W600(Color color) => TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      color: color,
      fontWeight: FontWeight.w600);

  TextStyle bodySize14W400Muted() => const TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      color: smockGrey,
      fontWeight: FontWeight.w400);

  TextStyle bodySize14W400MutedLine() => const TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      color: smockGrey,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough);

// ---------------------------------ButtonStyle-----------------------------------------------------------------------------------------
  ButtonStyle outlineButtonStyle(
          Color backgroundColor, Color foregroundColor, double borderRadius,
          {BorderSide? side}) =>
      ButtonStyle(
        side: MaterialStateProperty.all(side ?? BorderSide.none),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        )),
      );

  ButtonStyle outlineNoneBorderButtonStyle(
          Color backgroundColor, Color foregroundColor) =>
      OutlinedButton.styleFrom(
        side: BorderSide.none,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      );
}
