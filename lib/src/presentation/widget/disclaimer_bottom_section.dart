import 'package:flutter/material.dart';
import 'package:autoStation_promptBuy/src/constants/alva_styles.dart';
import 'package:autoStation_promptBuy/src/constants/app_strings.dart';
import 'package:autoStation_promptBuy/src/constants/mkp_styles.dart';
import 'package:autoStation_promptBuy/src/presentation/widget/alva_text.dart';

class DisclaimerSection extends StatefulWidget {
  const DisclaimerSection({super.key});

  @override
  State<DisclaimerSection> createState() => _DisclaimerSection();
}

class _DisclaimerSection extends State<DisclaimerSection> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      color: globalYellow,
      width: maxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlvaText(
                title: AppStrings().disclaimerTextFirst,
                textStyle: AlvaStyles().headingSize10w400(blackGoMunTo),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlvaText(
                title: AppStrings().disclaimerTextSecond,
                textStyle: AlvaStyles().headingSize10w400(blackGoMunTo),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AlvaText(
                title: AppStrings().disclaimerTextThird,
                textStyle: AlvaStyles().headingSize10w400(blackGoMunTo),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
