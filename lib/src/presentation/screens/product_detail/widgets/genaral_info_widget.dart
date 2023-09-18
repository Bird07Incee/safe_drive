import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/model/product_detail/product_detail_general_model.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';

class GeneralInfoWidget extends StatelessWidget {
  const GeneralInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var json = {
      'productCode': 'X00001',
      'productType': 'Charger',
      'productSize': '10x8x10',
      'productWeight': '1kg',
      'productLength': '1m+',
      'productConnectivity': 'wifi,bluetooth',
      'productUseCase': '...',
      'productColor': 'black,grey'
    };

    var object = ProductDetailGeneralModel.fromJson(json);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlvaText(title: "title", textStyle: AlvaStyles().heading3Muted()),
            AlvaText(
                title: "description",
                textStyle: AlvaStyles().heading2(BTN_SELECTED_TEXT_COLOR_NEW))
          ],
        ));
  }
}
