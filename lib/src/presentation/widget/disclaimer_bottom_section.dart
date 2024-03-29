import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';

class DisclaimerSection extends StatefulWidget{
  const DisclaimerSection({super.key});

  @override
  State<DisclaimerSection> createState() => _DisclaimerSection();

}

class _DisclaimerSection extends State<DisclaimerSection> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xfffffbe6),
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

// return
//   Column(
//     mainAxisAlignment: MainAxisAlignment.end,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Container(
//         color: Color(0xfffeedcd),
//         width: maxWidth,
//         //      height: 56 + 68 + 72,
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Text(
//                     AppStrings().disclaimerTextFirst,
//                     style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Text(
//                     AppStrings().disclaimerTextSecond,
//                     style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     AppStrings().disclaimerTextThird,
//                     style: AlvaStyles().headingSize12w400(Colors.black).copyWith(height: 2),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 16,
//             ),
//           ],
//         ),
//       ),
//     ],
//   );

  }


}