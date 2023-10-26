import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/main.dart';
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
import 'package:marketplace_line_oa/src/routes/routes.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(builder: (ctx, state) {
      if (state.status.isInitial) {
        // ctx.read<ShippingAddressBloc>().setFormData();
      }
      if (state.status.isSuccess || state.status.isFetching) {
        return RootPageCondition(
            child: AlvaRootWidget(
                appBar: AppBar(
                  title: AlvaText(title: AppStrings().shippingAddressTitle, textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
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
                bottomSheet: BlocBuilder<ShippingAddressBloc, ShippingAddressState>(builder: (ctx, state) {
                  return Container(
                    decoration: BoxDecoration(
                      color: whitePure,
                      boxShadow: [
                        BoxShadow(color: const Color(0xff000000).withOpacity(0.04), spreadRadius: 0, blurRadius: 16, offset: const Offset(0, -4)),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 96,
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () async {
                                if (state.isAllowSubmit) {
                                  final navigator = Navigator.of(context);
                                  final myBloc = BlocProvider.of<ShippingAddressBloc>(ctx);
                                  myBloc.onSubmitPressed();
                                  var stack = CurrentRouteObserver.instance.stack;
                                  if (stack.contains(Routes.orderSummary.toStringPath())) {
                                    navigator.pop();
                                  } else {
                                    navigator.popAndPushNamed(Routes.orderSummary.toStringPath());
                                  }
                                }
                              },
                              style: AlvaStyles().outlineNoneBorderButtonStyle(
                                  state.isAllowSubmit ? YellowKrungsri : cloudSoftDeepWhite, Colors.transparent,
                                  isRadius8: true),
                              child: Text("ยืนยัน",
                                  style: AlvaStyles().headingSize16w700(state.isAllowSubmit ? BTN_SELECTED_TEXT_COLOR_NEW : smockGrey)),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
                titlePage: titleWebPage,
                child: buildBodyWidget(ctx, state)));
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

  Widget buildBodyWidget(BuildContext ctx, ShippingAddressState state) {
    final myBloc = BlocProvider.of<ShippingAddressBloc>(ctx);
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 96),
        color: whitePure,
        child: ListView(
          children: [
            AlvaText(title: AppStrings().shippingAddressDescription, textStyle: AlvaStyles().headingSize12w400(spaceGrey123)),
            SizedBox(
              height: 24,
            ),
            StatefulBuilder(builder: (context, setState) {
              return Form(
                  key: myBloc.mainFormKey,
                  onChanged: () {
                    bool isAllowSubmit = myBloc.validateToActiveSubmitButton();
                    if (isAllowSubmit) {
                      setState(() {});
                    }
                  },
                  child: Column(
                      children: state.listFormWidget!.map(
                    (FormWidgetModel item) {
                      bool required = true;

                      Widget input = Container();

                      if (item.formType == formTypeTextField) {
                        input = TextInputWidget(
                          inputFormatters: item.listInputFormatter,
                          autoValidateMode: AutovalidateMode.disabled,
                          controller: item.controller,
                          label: item.label,
                          outsideLabel: true,
                          marginBottom: 15,
                          required: required,
                          textInputAction: TextInputAction.next,
                          keyboardType: item.textInputType,
                          maxLength: item.maxLength,
                          maxLines: item.maxLines,
                          showCounter: item.isShowCounter,
                          focusNode: item.focusNode,
                          onEditingCompleted: () {
                            int index = state.listFormWidget!.indexWhere((element) => element.fieldName == item.fieldName) + 1;
                            if (state.listFormWidget![index].focusNode != null) {
                              if (state.listFormWidget![index].controller!.text.isEmpty) {
                                FocusScope.of(context).requestFocus(state.listFormWidget![index].focusNode);
                              }
                            }
                          },
                          onFocusChange: (bool isFocus) {
                            if (!isFocus) {
                              myBloc.validateToActiveSubmitButton();
                              setState(() {
                                state.formResult!.where((element) => element.fieldName == item.fieldName).first.value = item.controller!.text;
                              });
                            }
                          },
                          isAllowAutoAddPhoneFormat: item.fieldName == 'phone' ? true : false,
                          isAllowAutoAddEmailFormat: item.fieldName == 'email' ? true : false,
                        );
                      } else if (item.formType == formTypeDropdown) {
                        bool isDisable = true;
                        if (item.matchField != null) {
                          if (state.formResult!.where((element) => element.fieldName == item.matchField).first.value!.isNotEmpty &&
                              item.options!.length > 1) {
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
                            var field = state.formResult!.where((element) => item.fieldName == element.fieldName).first;
                            field.id = model.id;
                            field.value = model.nameTh;

                            final myBloc = BlocProvider.of<ShippingAddressBloc>(ctx);

                            await myBloc.updateDropdownSelected(ctx,
                                id: field.id,
                                fieldName: item.fieldName,
                                listForm: state.listFormWidget,
                                listResult: state.formResult,
                                filterRefId: field.id);

                            setState(() {});
                            //test
                          },
                        );
                      }

                      return input;
                    },
                  ).toList()));
            })
          ],
        ));
  }
}
