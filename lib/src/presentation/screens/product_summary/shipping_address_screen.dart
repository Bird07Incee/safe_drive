import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/app_strings.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/model/form_widget_model.dart';
import 'package:marketplace_line_oa/src/model/product_summary/args/shipping_address_args.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_summary/shipping_address_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_summary/dropdown_input_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/product_summary/text_input_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/navigator_helper.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  late RouteSettings? settings;
  late Uri uriData;
  late RoutingData routingData;
  String pid = '';
  int? optLv1;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      isLoaded = true;
      loadProduct();
    }
  }

  loadProduct() {
    settings = ModalRoute.of(context) != null ? ModalRoute.of(context)!.settings : null;
    if (settings != null) {
      uriData = Uri.parse(settings!.name!);
      routingData = RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
      pid = (routingData["pid"] == null) ? "" : routingData["pid"];
      optLv1 = (routingData["opt_lv1"] == null) ? null : int.parse(routingData["opt_lv1"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    double btmInset = MediaQuery.of(context).viewInsets.bottom;
    return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(builder: (ctx, state) {
      if (state.status.isInitial) {
        ShippingAddressArgs args = ShippingAddressArgs();
        if (ModalRoute.of(context)!.settings.arguments != null) {
          args = ModalRoute.of(context)!.settings.arguments as ShippingAddressArgs;
        }
        ctx.read<ShippingAddressBloc>().setFormData(isFromEditing: args.isFromEditing);
        return const LoadingScreen();
      } else if (state.status.isSuccess || state.status.isFetching) {
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
                    onPressed: () async {
                      final myBloc = ctx.read<ShippingAddressBloc>();
                      ShippingAddressArgs args = ShippingAddressArgs();
                      if (ModalRoute.of(context)!.settings.arguments != null) {
                        args = ModalRoute.of(context)!.settings.arguments as ShippingAddressArgs;
                      }
                      if (!args.isFromEditing) myBloc.onClearShippingData();
                      ProductDetailState pdState = context.read<ProductDetailBloc>().state;
                      if (pdState.status.isInitial && pid != "") {
                        refreshRoute(context: context, currentRoute: "address", queryParams: "pid=$pid${optLv1 != null ? '&opt_lv1=$optLv1' : ''}");
                      }
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded)),
              ),
              bottomSheet: btmInset == 0
                  ? BlocBuilder<ShippingAddressBloc, ShippingAddressState>(builder: (ctx, state) {
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
                                      final myBloc = ctx.read<ShippingAddressBloc>();
                                      myBloc.onSubmitPressed();
                                      ProductDetailState pdState = context.read<ProductDetailBloc>().state;
                                      if (pdState.status.isInitial && pid != "") {
                                        refreshRoute(
                                            context: context,
                                            currentRoute: "address",
                                            queryParams: "pid=$pid${optLv1 != null ? '&opt_lv1=$optLv1' : ''}");
                                      }
                                      Navigator.pop(context);
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
                    })
                  : null,
              titlePage: titleWebPage,
              child: buildBodyWidget(ctx, state)),
        );
      } else if (state.status.isError) {
        return ErrorScreen(
          title: ErrorConst().titleNS,
          subTitle: ErrorConst().subTitleNS,
          titleBtn: ErrorConst().titleBtnNS,
          onTap: () {
            final myBloc = ctx.read<ShippingAddressBloc>();
            myBloc.onSetInitialState();
          },
        );
      } else {
        return const LoadingScreen();
      }
    });
  }

  Widget buildBodyWidget(BuildContext ctx, ShippingAddressState state) {
    double btmInset = MediaQuery.of(ctx).viewInsets.bottom;
    final myBloc = ctx.read<ShippingAddressBloc>();
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: btmInset == 0 ? 96 : 0),
        color: whitePure,
        child: ListView(
          children: [
            AlvaText(title: AppStrings().shippingAddressDescription, textStyle: AlvaStyles().headingSize12w400(spaceGrey123)),
            AlvaText(title: "ก่อนดำเนินการต่อ", textStyle: AlvaStyles().headingSize12w400(spaceGrey123)),
            SizedBox(
              height: 24,
            ),
            StatefulBuilder(builder: (context, setState) {
              return Form(
                  key: myBloc.mainFormKey,
                  onChanged: () {
                    myBloc.validateToActiveSubmitButton();
                    setState(() {});
                  },
                  child: Column(
                      children: state.listFormWidget!.map(
                    (FormWidgetModel item) {
                      bool required = true;

                      Widget input = Container();

                      if (item.formType == formTypeTextField) {
                        input = Form(
                            key: item.key,
                            child: TextInputWidget(
                              inputFormatters: item.listInputFormatter,
                              autoValidateMode: AutovalidateMode.disabled,
                              controller: item.controller,
                              label: item.label,
                              outsideLabel: true,
                              marginBottom: 15,
                              required: required,
                              textInputAction: item.fieldName == 'address' ? TextInputAction.done : TextInputAction.next,
                              keyboardType: item.textInputType,
                              maxLength: item.maxLength,
                              maxLines: item.maxLines,
                              showCounter: item.isShowCounter,
                              focusNode: item.focusNode,
                              onFocus: () {
                                setState(() {});
                              },
                              onEditingCompleted: () {
                                // if (item.fieldName != 'address') {
                                //   int index = state.listFormWidget!.indexWhere((element) => element.fieldName == item.fieldName) + 1;
                                //   if (state.listFormWidget![index].focusNode != null) {
                                //     if (state.listFormWidget![index].controller!.text.isEmpty) {
                                //       FocusScope.of(context).requestFocus(state.listFormWidget![index].focusNode);
                                //     } else {
                                //       FocusScope.of(context).unfocus();
                                //     }
                                //   }
                                // } else {
                                //   FocusScope.of(context).unfocus();
                                // }
                                // FocusScope.of(context).unfocus();
                                FocusScope.of(context).nextFocus();
                                setState(() {});
                              },
                              onFocusChange: (bool isFocus) async {
                                if (!isFocus) {
                                  await myBloc.validateAnyFieldInForm(item: item, isFocus: isFocus);
                                }
                              },
                              isAllowAutoAddPhoneFormat: item.fieldName == 'phone' ? true : false,
                              isAllowAutoAddEmailFormat: item.fieldName == 'email' ? true : false,
                            ));
                      } else if (item.formType == formTypeDropdown) {
                        bool isDisable = true;
                        if (item.matchField != null) {
                          if (state.formResult!.where((element) => element.fieldName == item.matchField).first.value!.isNotEmpty &&
                              item.options!.isNotEmpty) {
                            if (item.options!.length > 1) {
                              isDisable = false;
                            } else if (item.fieldName != 'zipcode') {
                              isDisable = false;
                            }
                          }
                        } else {
                          isDisable = false;
                        }

                        input = IgnorePointer(
                            ignoring: state.status.isFetching,
                            child: DropDownInputWidget(
                              disable: isDisable,
                              textEditingController: item.controller,
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              label: item.label,
                              marginBottom: 15,
                              required: required,
                              value: item.value,
                              options: item.options!,
                              isDisableDropdownSuffixButton: item.fieldName == 'zipcode' ? true : false,
                              onChanged: (value) async {
                                DropdownAddressModel model = value;
                                var field = state.formResult!.where((element) => item.fieldName == element.fieldName).first;
                                field.id = model.id;
                                field.value = model.nameTh;

                                final myBloc = ctx.read<ShippingAddressBloc>();

                                await myBloc.updateDropdownSelected(
                                    id: field.id,
                                    fieldName: item.fieldName,
                                    listForm: state.listFormWidget,
                                    listResult: state.formResult,
                                    filterRefId: field.id);

                                setState(() {});
                                //test
                              },
                            ));
                      }

                      return input;
                    },
                  ).toList()));
            })
          ],
        ));
  }
}
