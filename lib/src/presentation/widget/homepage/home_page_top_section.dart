import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';

class HomepageTopSection extends StatelessWidget {
  const HomepageTopSection({
    super.key,
    required this.maxWidth,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: maxWidth - 32,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/homepage/krungsri-auto-logo-2.20f3516 1.png",
                width: 86,
                height: 40,
              ),
              const SizedBox(
                height: 16,
              ),
              AlvaText(
                title: 'วอลชาร์จรถไฟฟ้า',
                textStyle: AlvaStyles().heading1(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
