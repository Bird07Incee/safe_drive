import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/main.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_options/product_options_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  void onBack(BuildContext context) {
    var stack = CurrentRouteObserver.instance.stack;
    print('route stack : $stack');
    if (stack.contains(Routes.initial.toStringPath())) {
      Navigator.pop(context);
    } else {
      Navigator.popAndPushNamed(context, Routes.initial.toStringPath());
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectOptionBloc = BlocProvider.of<ProductOptionBloc>(context);
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return RootPageCondition(
        child: WillPopScope(
      onWillPop: () async {
        onBack(context);
        return true;
      },
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          return AlvaRootWidget(
              titlePage: titleWebPage,
              appBar: AppBar(
                title: AlvaText(
                    title: "สรุปรายการสั่งซื้อ",
                    textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                titleSpacing: 0,
                leadingWidth: 60,
                centerTitle: false,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    key: const Key("pop_navigator_to_home_page"),
                    onPressed: () {
                      onBack(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded)),
              ),
              bottomSheet: Container(
                decoration: BoxDecoration(
                  color: whitePure,
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff000000).withOpacity(0.04),
                        spreadRadius: 0,
                        blurRadius: 16,
                        offset: const Offset(0, -4)),
                  ],
                ),
                width: maxWidth,
                height: 96,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: AlvaStyles()
                              .outlineNoneBorderButtonStyle(YellowKrungsri, Colors.transparent, isRadius8: true),
                          child: Text("สั่งซื้อสินค้า",
                              style: AlvaStyles().headingSize16w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // child: ProductDetailBody(),
              child: Container(
                padding: const EdgeInsets.only(bottom: 96),
                color: backgroundNo2,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: cloudWhite, // Replace with your color
                            width: 2.0, // Adjust the border width as needed
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    ));
  }
}
