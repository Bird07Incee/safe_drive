import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/helpers/extensions.dart';

class MkpStaticImage {
  MkpStaticImage._internal();
  static final MkpStaticImage _instance = MkpStaticImage._internal();
  factory MkpStaticImage() => _instance;

  static Widget get placeholder => Image.asset(
        "assets/homepage/placeholder_image.png",
        fit: BoxFit.cover,
      );

  static AssetImage get placeholderProvider => AssetImage(
        "assets/homepage/placeholder_image.png",
      );
}
