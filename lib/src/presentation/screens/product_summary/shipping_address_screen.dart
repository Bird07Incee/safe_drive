import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_summary/shipping_address_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlvaRootWidget(
        appBar: AppBar(
          title: AlvaText(
              title: AppStrings().shippingAddressTitle,
              textStyle:
                  AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
          titleSpacing: 0,
          leadingWidth: 60,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_rounded)),
        ),
        titlePage: titleWebPage,
        child: buildBodyWidget());
  }

  Widget buildBodyWidget() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
        builder: (ctx, state) {
      return Container(
        color: whitePure,
        child: ListView(
          children: const [],
        ),
      );
    });
  }
}
