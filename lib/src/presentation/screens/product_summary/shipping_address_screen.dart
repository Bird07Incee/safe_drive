import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/model/form_widget_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_summary/shipping_address_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_summary/text_input_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPageCondition(
        child: AlvaRootWidget(
            appBar: AppBar(
              title: AlvaText(
                  title: AppStrings().shippingAddressTitle,
                  textStyle: AlvaStyles()
                      .headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
              titleSpacing: 0,
              leadingWidth: 60,
              centerTitle: false,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
            ),
            titlePage: titleWebPage,
            child: buildBodyWidget()));
  }

  Widget buildBodyWidget() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
        builder: (ctx, state) {
      if (state.status.isInitial) {
        ctx
            .read<ShippingAddressBloc>()
            .add(SetFormWidget(listForm: state.listFormWidget ?? []));
      }
      if (state.status.isSuccess) {
        return Container(
          color: whitePure,
          child: Column(
              children: state.listFormWidget!.map(
            (FormWidgetModel item) {
              bool required = true;

              // if (item.checkRequiredField != null &&
              //     item.checkRequiredFieldMatchValue != null) {
              //   required = item.checkRequiredFieldMatchValue!.contains(
              //       state.listFormWidget!.entireFormMap[item.checkRequiredField]);
              // }

              Widget input = Container();

              if (item.formType == formTypeTextField) {
                input = TextInputWidget(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  controller: item.controller,
                  label: item.label,
                  marginBottom: 15,
                  required: required,
                  textInputAction: TextInputAction.done,
                  keyboardType: item.textInputType,
                  maxLength: item.maxLength,
                  maxLines: item.maxLines,
                  showCounter: true,
                );
              } else if (item.formType == formTypeDropdown) {
                // input = OutlineDropDownInput(
                //   autoValidateMode: AutovalidateMode.onUserInteraction,
                //   label: item.label,
                //   marginBottom: 15,
                //   required: required,
                //   value: item.value,
                //   options: item.options!
                //       .map((e) =>
                //           dropdownItem(value: e['value'], label: e['label']))
                //       .toList(),
                //   onChanged: (value) async {
                //     item.value = value;
                //     data.selectDropDownEvent(value, item);
                //   },
                // );
              }

              // if (item.visibleIfMatchValue != null && item.matchField != null) {
              //   if (item.visibleIfMatchValue!
              //       .contains(data.entireFormMap[item.matchField])) {
              //     return input;
              //   }
              //   return Container();
              // }

              return input;
            },
          ).toList()),
        );
      } else if (state.status.isLoading) {
        return const LoadingScreen();
      } else {
        return ErrorScreen(
          title: ErrorConst().titleNS,
          subTitle: ErrorConst().subTitleNS,
          titleBtn: ErrorConst().titleBtnNS,
          onTap: () {},
        );
      }
    });
  }
}
