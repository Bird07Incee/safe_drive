import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';

class HomePageBanner extends StatelessWidget {
  const HomePageBanner({
    super.key,
    required this.maxWidth,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: SizedBox(
            width: maxWidth, height: 576, child: Image.asset(HomeConst().bannerImagePath, fit: BoxFit.fitWidth)));
  }
}
