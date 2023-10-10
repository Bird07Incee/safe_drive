import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_summary/shipping_address_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlvaRootWidget(titlePage: titleWebPage, child: buildBodyWidget());
  }

  Widget buildBodyWidget() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(builder: (ctx, state) {
      return Container();
    });
  }
}
