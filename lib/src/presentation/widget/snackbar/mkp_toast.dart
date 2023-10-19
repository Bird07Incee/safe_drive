import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';

SnackBar getMkpToast(String text) {
  return SnackBar(
      content: Center(
          child: Text(
        text,
        style: AlvaStyles().headingSize12w400(Colors.white),
      )),
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 100, horizontal: 80),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      duration: Duration(seconds: 3));
}
