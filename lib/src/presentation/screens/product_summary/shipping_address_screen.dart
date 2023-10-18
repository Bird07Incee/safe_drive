import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/model/form_widget_model.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_summary/shipping_address_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_summary/dropdown_input_widget.dart';
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
              elevation: 0.7,
              leadingWidth: 60,
              centerTitle: false,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
            ),
            titlePage: titleWebPage,
            child: buildBodyWidget()));
  }

  Widget buildBodyWidget() {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
        builder: (ctx, state) {
      if (state.status.isInitial) {
        // ctx.read<ShippingAddressBloc>().setFormData();
      }
      if (state.status.isSuccess) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: whitePure,
            child: ListView(
              children: [
                AlvaText(
                    title: AppStrings().shippingAddressDescription,
                    textStyle: AlvaStyles().headingSize12w400(spaceGrey123)),
                SizedBox(
                  height: 24,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return Column(
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
                          inputFormatters: item.listInputFormatter,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          controller: item.controller,
                          label: item.label,
                          outsideLabel: true,
                          marginBottom: 15,
                          required: required,
                          textInputAction: TextInputAction.done,
                          keyboardType: item.textInputType,
                          maxLength: item.maxLength,
                          maxLines: item.maxLines,
                          showCounter: item.isShowCounter,
                          isAllowAutoAddPhoneFormat:
                              item.fieldName == 'phone' ? true : false,
                          isAllowAutoAddEmailFormat:
                              item.fieldName == 'email' ? true : false,
                        );
                      } else if (item.formType == formTypeDropdown) {
                        bool isDisable = true;
                        if (item.matchField != null) {
                          if (state.formResult!
                              .where((element) =>
                                  element.fieldName == item.matchField)
                              .first
                              .value!
                              .isNotEmpty) {
                            isDisable = false;
                          }
                        } else {
                          isDisable = false;
                        }

                        input = DropDownInputWidget(
                          disable: isDisable,
                          textEditingController: item.controller,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          label: item.label,
                          marginBottom: 15,
                          required: required,
                          value: item.value,
                          options: item.options!,
                          onChanged: (value) async {
                            DropdownAddressModel model = value;
                            var field = state.formResult!
                                .where((element) =>
                                    item.fieldName == element.fieldName)
                                .first;
                            field.id = model.id;
                            field.value = model.nameTh;

                            final myBloc =
                                BlocProvider.of<ShippingAddressBloc>(ctx);
                            myBloc.updateDropdownSelected(
                                id: field.id,
                                fieldName: item.fieldName,
                                listFormWidget: state.listFormWidget,
                                listResult: state.formResult);

                            setState(() {});
                            //test
                          },
                        );
                      }

                      return input;
                    },
                  ).toList());
                })
              ],
            ));
      } else if (state.status.isError) {
        return ErrorScreen(
          title: ErrorConst().titleNS,
          subTitle: ErrorConst().subTitleNS,
          titleBtn: ErrorConst().titleBtnNS,
          onTap: () {},
        );
      } else {
        return const LoadingScreen();
      }
    });
  }
}
