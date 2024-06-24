import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';

class HomepageTopSection extends StatelessWidget {
  const HomepageTopSection({super.key, required this.maxWidth, required this.scrollController});

  final double maxWidth;
  final ScrollController scrollController;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AlvaText(title: HomeConst().titleTopSec, textStyle: AlvaStyles().headingSize16Bold()),
                      AlvaText(title: HomeConst().titleTopSecTH, textStyle: AlvaStyles().headingSize8w500Height12(mintGreen)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      AmplitudeWebHelper.getInstance().logTapOnOrderTrackingButton();
                      hideOneTrustCookieScript();
                      context.read<ProductListBloc>().add(SetScrollPosition(scrollController.offset));
                      Navigator.pushNamed(context, '/trackingList');
                    },
                    child: Container(
                      height: 40,
                      width: (maxWidth - 40) / 2,
                      decoration: BoxDecoration(color: const Color(0xffffd400), borderRadius: const BorderRadius.all(Radius.circular(8))),
                      child: Center(child: Text("ตรวจสอบสถานะสินค้า", style: AlvaStyles().heading3())),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
