import 'package:flutter/material.dart';

class AlvaStyles {
  TextStyle heading1() => const TextStyle(
        fontFamily: "Krungsri Condensed",
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  TextStyle heading2(Color color) =>
      TextStyle(fontFamily: "Krungsri Condensed", fontSize: 14, fontWeight: FontWeight.bold, color: color);

  TextStyle heading3() => const TextStyle(
      fontFamily: "Krungsri Condensed", fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff2c2626));

  TextStyle heading3Muted() => const TextStyle(
      fontFamily: "Krungsri Condensed", fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xffbdbdbd));

  TextStyle headingSize12w400(Color color) =>
      TextStyle(fontFamily: "Krungsri Condensed", fontSize: 12, fontWeight: FontWeight.w400, color: color);

  TextStyle headingSize32() => const TextStyle(
        fontFamily: "Krungsri Condensed",
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );

  TextStyle headingSize10w400(Color color) =>
      TextStyle(fontFamily: "Krungsri Condensed", fontSize: 10, fontWeight: FontWeight.w400, color: color);

  TextStyle headingSize10() => const TextStyle(
        fontFamily: "Krungsri Condensed",
        fontSize: 10,
        fontWeight: FontWeight.bold,
      );

  TextStyle headingSize16w600() => const TextStyle(
        fontFamily: "Krungsri Condensed",
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  TextStyle headingSize12w700(Color color) =>
      TextStyle(fontFamily: "Krungsri Condensed", fontSize: 12, fontWeight: FontWeight.bold, color: color);

  TextStyle body1() => const TextStyle(fontFamily: "Krungsri Condensed", fontSize: 12, color: Color(0xff2c2626));

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
