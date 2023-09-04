import 'package:flutter/material.dart';

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
            width: maxWidth, height: 576, child: Image.asset("assets/homepage/banner.png", fit: BoxFit.fitWidth)));
  }
}
