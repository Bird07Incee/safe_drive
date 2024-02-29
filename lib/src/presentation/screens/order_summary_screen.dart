import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/main.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/model/product_summary/arguments/shipping_address_args.dart';
import 'package:marketplace_line_oa/src/model/product_summary/create_order_request_model.dart';
import 'package:marketplace_line_oa/src/model/product_summary/shipping_address_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/order_summary_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/show_sale_code_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/show_summary_detail_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_options/product_options_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/shipping_address/shipping_address_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/navigator_helper.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';
import 'package:universal_html/html.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  late CreateOrderRequestModel requestModel;
  final FocusNode saleCodeNode = FocusNode();
  final TextEditingController staffCode = TextEditingController();
  late RouteSettings? settings;
  late Uri uriData;
  late RoutingData routingData;
  String pid = '';
  int? optLv1;
  var currentRoute = CurrentRouteObserver.instance.name;
  bool isLoaded = false;

  @override
  void initState() {
    context.read<OrderSummaryBloc>().add(InitialOrderState());
    super.initState();
  }

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
      ProductDetailState pdState = context.read<ProductDetailBloc>().state;
      if (pdState.status.isInitial && pid != "") {
        context.read<ProductDetailBloc>().add(GetProductByID(pid: pid));
      }
    }
  }

  loadSelectOption(Product product) {
    final option = BlocProvider.of<ProductOptionBloc>(context);
    if (optLv1 != null) {
      option.updateStepOneVariables(
        groupValueRadio: product.productionOptionals[optLv1!].label,
        price: product.productionOptionals[optLv1!].price,
        indexSelect: optLv1,
      );
    }
  }

  void onBack(BuildContext context) {
    GeneralDialog(
            onAccept: () {
              context.read<ShippingAddressBloc>().onClearShippingData();
              context.read<ProductOptionBloc>().updateStepOneVariables(
                    groupValueRadio: "",
                    price: 0,
                    indexSelect: 0,
                  );
              context.read<ProductOptionBloc>().updateStepTwoVariables(
                    groupValueRadio: "",
                    price: 0,
                    indexSelect: 0,
                  );
              context.read<ProductOptionBloc>().updateSelectCurrentOption(0);
              context.read<ProductOptionBloc>().updateLastOption(0);
              if (isLoaded) {
                refreshRoute(context: context, currentRoute: "summary", queryParams: "pid=$pid");
              }
              Navigator.popUntil(context, (route) => route.settings.name!.contains(Routes.productDetail.toStringPath()));
            },
            onCancel: () {})
        .showSummaryDialog(context: context);
  }

  @override
  Widget build(BuildContext context) {
    String step1 = "";
    int step1price = 0;
    String step2 = "";
    double btmInset = MediaQuery.of(context).viewInsets.bottom;
    // int step2price = selectOptionBloc.stepTwoPrice ?? 0;

    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return RootPageCondition(
        child: WillPopScope(
      onWillPop: () async {
        onBack(context);
        return true;
      },
      child: BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listener: (context, state) {
          if (state.status.isSuccess && currentRoute.contains(Routes.orderSummary.toStringPath())) {
            loadSelectOption(state.product);
          }
        },
        builder: (context, productState) {
          // if (!state.status.isSuccess) {
          //   context.read<ProductDetailBloc>().add(GetProductByID());
          //   context.read<ProductOptionBloc>().updateStepOneVariables(
          //       groupValueRadio:
          //           "5เมตร สีขาวhkerhckjfshdjkhfgksdjhfgkjshdlkfjghlskdjfhglksjhdfkjghslkdfhglkhsldkfhlgkhsldfhgjsdhfgjhslkdfghlksjhfglkshldfghljkshdkfghlsjkdhfjgklhsjlkdfhgjlkshljkdfhglwkercmnwltkenhvtksduhnlkh",
          //       price: 50000,
          //       indexSelect: 1);
          //   // context
          //   //     .read<ProductOptionBloc>()
          //   //     .updateStepTwoVariables(groupValueRadio: "ความยาวสาย 3 เมตร", price: 99999999);
          // }
          int showPrice = productState.product.discountPrice > 0 ? productState.product.discountPrice : productState.product.price;
          return BlocConsumer<OrderSummaryBloc, OrderSummaryState>(
            listener: (context, state) {
              if (currentRoute.contains(Routes.orderSummary.toStringPath())) {
                if (state.orderStatus.isLoading) {
                  GeneralDialog().showLoadingDialog(context: context);
                } else if (state.orderStatus.isSuccess) {
                  Navigator.pop(context);
                  if (state.orderResponseModel.paymentURL != null && state.orderResponseModel.paymentURL!.isNotEmpty) {
                    window.open(state.orderResponseModel.paymentURL!, '_self');
                  }
                } else if (state.orderStatus.isError) {
                  Navigator.pop(context);
                }
              }
            },
            builder: (context, orderState) {
              if (orderState.orderStatus.isError) {
                return ErrorScreen(
                  title: ErrorConst().titleNS,
                  subTitle: ErrorConst().subTitleNS,
                  titleBtn: ErrorConst().titleBtnNS,
                  onTap: () {
                    context.read<OrderSummaryBloc>().add(CreateOrder(requestModel: requestModel));
                  },
                );
              }
              return BlocBuilder<ShowSummaryDetailCubit, bool>(
                builder: (context, showDetail) {
                  return BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
                    builder: (context, shippingState) {
                      bool validated = shippingState.addressModel != ShippingAddressModel.empty && !orderState.paymentType.isNone;
                      return BlocBuilder<ProductOptionBloc, ProductOptionState>(
                        builder: (context, pdOptState) {
                          step1 = pdOptState.stepOneGroupValueRadio;
                          step1price = pdOptState.stepOnePrice ?? 0;
                          step2 = pdOptState.stepTwoGroupValueRadio;
                          if (productState.status.isSuccess) {
                            return Scaffold(
                                resizeToAvoidBottomInset: true,
                                backgroundColor: Colors.white,
                                body: Stack(
                                  children: [
                                    AlvaRootWidget(
                                        titlePage: titleWebPage,
                                        appBar: AppBar(
                                          title: AlvaText(
                                              title: "สรุปรายการสั่งซื้อ",
                                              textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 24 / 18)),
                                          titleSpacing: 0,
                                          elevation: 0.4,
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
                                        child: Container(
                                          color: Colors.white,
                                          height: maxHeight,
                                          child: ListView(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                                                child: AlvaText(
                                                    title: "รายละเอียดสินค้า",
                                                    textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 24 / 14)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          height: 40,
                                                          width: 72,
                                                          child: productState.product.productionAssets.isNotEmpty
                                                              ? ClipRRect(
                                                                  borderRadius: BorderRadius.circular(4),
                                                                  child: FadeInImage(
                                                                    placeholder: AssetImage(ProductSelectOptionsConst().imgDefaultPath),
                                                                    image: NetworkImage(step1.isNotEmpty &&
                                                                            productState
                                                                                .product
                                                                                .productionOptionals[pdOptState.stepOneIndexSelect ?? 0]
                                                                                .image
                                                                                .isNotEmpty
                                                                        ? productState
                                                                            .product.productionOptionals[pdOptState.stepOneIndexSelect ?? 0].image
                                                                        : productState.product.productionAssets.first),
                                                                    fit: BoxFit.cover,
                                                                    imageErrorBuilder: (context, error, stackTrace) =>
                                                                        Image.asset(ProductSelectOptionsConst().imgDefaultPath, fit: BoxFit.fitWidth),
                                                                  ),
                                                                )
                                                              : ClipRRect(
                                                                  borderRadius: BorderRadius.circular(4),
                                                                  child: Image.asset(ProductSelectOptionsConst().imgDefaultPath),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: maxWidth - 32 - 16 - 72,
                                                          child: AlvaTextMaxLinesOverflow(
                                                              maxLines: 1,
                                                              title: productState.product.productName,
                                                              textStyle: AlvaStyles()
                                                                  .headingSize14w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                  .copyWith(height: 24 / 14)),
                                                        ),
                                                        productState.product.productionOptionals.isEmpty
                                                            ? SizedBox.shrink()
                                                            : Padding(
                                                                padding: const EdgeInsets.only(top: 4),
                                                                child: SizedBox(
                                                                  width: maxWidth - 32 - 16 - 72,
                                                                  child: AlvaTextMaxLinesOverflow(
                                                                      maxLines: 5,
                                                                      title:
                                                                          "${productState.product.productionOptionals[pdOptState.stepOneIndexSelect ?? 0].levelName}: $step1",
                                                                      textStyle: AlvaStyles()
                                                                          .headingSize10w400(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                          .copyWith(height: 1.6)),
                                                                ),
                                                              ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: maxWidth,
                                                height: 1,
                                                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: cloudSoftDeepWhite))),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                                                child: AlvaText(
                                                    title: "ที่อยู่ในการจัดส่งสินค้า",
                                                    textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 24 / 14)),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 24),
                                                  child: shippingState.addressModel == ShippingAddressModel.empty
                                                      ? GestureDetector(
                                                          behavior: HitTestBehavior.translucent,
                                                          onTap: () {
                                                            Navigator.pushNamed(context,
                                                                '${Routes.shippingAddress.toStringPath()}?pid=$pid${productState.product.productionOptionals.isEmpty ? "" : "&opt_lv1=$optLv1"}');
                                                          },
                                                          child: Container(
                                                            width: maxWidth - 32,
                                                            height: 48,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8),
                                                                border: Border.all(width: 2, color: YellowKrungsri)),
                                                            child: Center(
                                                              child: Text("เพิ่มที่อยู่",
                                                                  style: AlvaStyles()
                                                                      .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                      .copyWith(height: 24 / 14)),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding: EdgeInsets.only(bottom: 8),
                                                          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: grey300))),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  shippingState.addressModel.fullName.isNotEmpty
                                                                      ? SizedBox(
                                                                          width: maxWidth - 32 - 16 - 24,
                                                                          child: AlvaTextMaxLinesOverflow(
                                                                              maxLines: 5,
                                                                              title: shippingState.addressModel.fullName,
                                                                              textStyle: AlvaStyles()
                                                                                  .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                                  .copyWith(height: 2)),
                                                                        )
                                                                      : SizedBox.shrink(),
                                                                  shippingState.addressModel.mobileNumber.isNotEmpty
                                                                      ? AlvaText(
                                                                          title: shippingState.addressModel.mobileNumber,
                                                                          textStyle: AlvaStyles()
                                                                              .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                              .copyWith(height: 2))
                                                                      : SizedBox.shrink(),
                                                                  shippingState.addressModel.emailAddress.isNotEmpty
                                                                      ? AlvaText(
                                                                          title: shippingState.addressModel.emailAddress,
                                                                          textStyle: AlvaStyles()
                                                                              .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                              .copyWith(height: 2))
                                                                      : SizedBox.shrink(),
                                                                  shippingState.addressModel.fullAddress.isNotEmpty
                                                                      ? SizedBox(
                                                                          width: maxWidth - 32 - 16 - 24,
                                                                          child: AlvaTextMaxLinesOverflow(
                                                                              maxLines: 5,
                                                                              title: shippingState.addressModel.fullAddress,
                                                                              textStyle: AlvaStyles()
                                                                                  .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                                  .copyWith(height: 2)),
                                                                        )
                                                                      : SizedBox.shrink(),
                                                                  SizedBox(
                                                                    width: maxWidth - 32 - 16 - 24,
                                                                    child: AlvaTextMaxLinesOverflow(
                                                                        maxLines: 5,
                                                                        title:
                                                                            "${shippingState.addressModel.subDistrict} ${shippingState.addressModel.district} ${shippingState.addressModel.province} ${shippingState.addressModel.zipCode}",
                                                                        textStyle: AlvaStyles()
                                                                            .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                            .copyWith(height: 2)),
                                                                  ),
                                                                ],
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                  Navigator.pushNamed(context,
                                                                      '${Routes.shippingAddress.toStringPath()}?pid=$pid${productState.product.productionOptionals.isEmpty ? "" : "&opt_lv1=$optLv1"}',
                                                                      arguments: ShippingAddressArgs(isFromEditing: true));
                                                                },
                                                                child: Container(
                                                                  width: 24,
                                                                  height: 24,
                                                                  decoration:
                                                                      BoxDecoration(color: cloudyWhite, borderRadius: BorderRadius.circular(36)),
                                                                  child: Center(
                                                                    child: SizedBox(
                                                                      width: 10,
                                                                      height: 10,
                                                                      child: Image.asset(
                                                                        'assets/icons/edit.png',
                                                                        fit: BoxFit.fitWidth,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )),
                                              Container(
                                                width: maxWidth,
                                                height: 1,
                                                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: cloudSoftDeepWhite))),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                                                child: AlvaText(
                                                    title: "ช่องทางการชำระเงิน",
                                                    textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 24 / 14)),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                  if (!orderState.paymentType.isFullPayment) {
                                                    context.read<OrderSummaryBloc>().add(SelectPaymentType(paymentType: PaymentType.fullPayment));
                                                  }
                                                },
                                                child: Container(
                                                  key: const Key("select_payment_type_cc"),
                                                  width: maxWidth,
                                                  height: 48,
                                                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 24,
                                                            height: 24,
                                                            child: Radio(
                                                              value: "CC",
                                                              groupValue: orderState.paymentType.isFullPayment ? "CC" : "",
                                                              toggleable: true,
                                                              onChanged: (value) {
                                                                if (!orderState.paymentType.isFullPayment) {
                                                                  context
                                                                      .read<OrderSummaryBloc>()
                                                                      .add(SelectPaymentType(paymentType: PaymentType.fullPayment));
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          SizedBox(
                                                            width: maxWidth - 32 - 24 - 16 - 85,
                                                            child: Text("ชำระเต็มจำนวน",
                                                                style: AlvaStyles()
                                                                    .headingSize14w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                    .copyWith(height: 24 / 14)),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 85,
                                                        child: Text("บัตรเครดิต/เดบิต",
                                                            style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              productState.product.paymentChannelCode.contains("IPP")
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                        if (!orderState.paymentType.isInstallment) {
                                                          context
                                                              .read<OrderSummaryBloc>()
                                                              .add(SelectPaymentType(paymentType: PaymentType.installment));
                                                        }
                                                      },
                                                      child: Container(
                                                        key: const Key("select_payment_type_ipp"),
                                                        width: maxWidth,
                                                        height: 48,
                                                        padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                                                        margin: const EdgeInsets.only(bottom: 16),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 24,
                                                                  height: 24,
                                                                  child: Radio(
                                                                    value: "IPP",
                                                                    groupValue: orderState.paymentType.isInstallment ? "IPP" : "",
                                                                    toggleable: true,
                                                                    onChanged: (value) {
                                                                      if (!orderState.paymentType.isInstallment) {
                                                                        context
                                                                            .read<OrderSummaryBloc>()
                                                                            .add(SelectPaymentType(paymentType: PaymentType.installment));
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 16,
                                                                ),
                                                                SizedBox(
                                                                  width: maxWidth - 32 - 24 - 16 - 148,
                                                                  child: Text("ผ่อนชำระ",
                                                                      style: AlvaStyles()
                                                                          .headingSize14w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                          .copyWith(height: 24 / 14)),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 148,
                                                              child: Text("เฉพาะบัตรเครดิตในเครือกรุงศรี",
                                                                  style: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox.shrink(),
                                              Container(
                                                width: maxWidth,
                                                height: 1,
                                                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: cloudSoftDeepWhite))),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                                                child: Row(
                                                  children: [
                                                    AlvaText(
                                                        title: "รหัสผู้แนะนำ",
                                                        textStyle:
                                                            AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 24 / 14)),
                                                    AlvaText(
                                                        title: "(ถ้ามี)",
                                                        textStyle: AlvaStyles().headingSize14w400(spaceGrey123).copyWith(height: 24 / 14)),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 32 + 24,
                                                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                                                child: BlocBuilder<ShowSaleCodeCubit, bool>(
                                                  builder: (context, showEditForm) {
                                                    return TextFormField(
                                                      key: const Key("sale_code_box"),
                                                      controller: staffCode,
                                                      onTap: () {
                                                        setState(() {});
                                                      },
                                                      onChanged: (text) {
                                                        if (text != "") {
                                                          context.read<ShowSaleCodeCubit>().show(true);
                                                        } else {
                                                          context.read<ShowSaleCodeCubit>().show(false);
                                                        }
                                                      },
                                                      maxLines: 1,
                                                      maxLength: 50,
                                                      style: AlvaStyles().headingSize16w500(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 26 / 16),
                                                      cursorColor: BTN_SELECTED_TEXT_COLOR_NEW,
                                                      cursorWidth: 1,
                                                      cursorHeight: 20,
                                                      decoration: InputDecoration(
                                                        suffix: showEditForm
                                                            ? Container(
                                                                margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                                child: GestureDetector(
                                                                    key: const Key("clear_search_box"),
                                                                    onTap: () {
                                                                      saleCodeNode.requestFocus();
                                                                    },
                                                                    child: Container(
                                                                      width: 24,
                                                                      height: 24,
                                                                      decoration:
                                                                          BoxDecoration(color: cloudyWhite, borderRadius: BorderRadius.circular(36)),
                                                                      child: Center(
                                                                        child: SizedBox(
                                                                          width: 10,
                                                                          height: 10,
                                                                          child: Image.asset(
                                                                            'assets/icons/edit.png',
                                                                            fit: BoxFit.fitWidth,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )),
                                                              )
                                                            : null,
                                                        contentPadding: const EdgeInsets.only(bottom: 12),
                                                        counterText: "",
                                                        hintMaxLines: 1,
                                                        enabledBorder: UnderlineInputBorder(
                                                          borderSide: const BorderSide(
                                                            color: grey300,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        focusedBorder: UnderlineInputBorder(
                                                          borderSide: const BorderSide(
                                                            color: BlueFantasy,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      onFieldSubmitted: (value) {
                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 160 + btmInset,
                                              ),
                                            ],
                                          ),
                                        )),
                                    showDetail
                                        ? GestureDetector(
                                            onTap: () {
                                              context.read<ShowSummaryDetailCubit>().toggle();
                                            },
                                            child: Container(
                                              color: Colors.black.withOpacity(.32),
                                              width: maxWidth,
                                              height: maxHeight,
                                            ),
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                                bottomSheet: btmInset == 0
                                    ? Container(
                                        width: maxWidth,
                                        constraints: BoxConstraints(minHeight: 160),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: const Color(0xff000000).withOpacity(0.04),
                                                spreadRadius: 0,
                                                blurRadius: 16,
                                                offset: const Offset(0, -4)),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(bottom: 32),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            AnimatedSize(
                                              alignment: Alignment(0, -5),
                                              curve: Curves.easeOutCirc,
                                              duration: const Duration(milliseconds: 500),
                                              child: showDetail
                                                  ? Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                            padding: EdgeInsets.only(top: 16, bottom: 16),
                                                            decoration:
                                                                BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: cloudWhite))),
                                                            child: Center(
                                                                child: AlvaText(
                                                                    title: "รายการสั่งซื้อ",
                                                                    textStyle: AlvaStyles()
                                                                        .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                        .copyWith(height: 24 / 14)))),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 16, right: 16, top: 16, bottom: (step1.isEmpty && step2.isEmpty) ? 16 : 4),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Flexible(
                                                                child: AlvaTextMaxLinesOverflow(
                                                                    title: productState.product.productName,
                                                                    maxLines: 1,
                                                                    textStyle: AlvaStyles()
                                                                        .headingSize12w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                        .copyWith(height: 2)),
                                                              ),
                                                              SizedBox(
                                                                width: 16,
                                                              ),
                                                              AlvaText(
                                                                  title:
                                                                      "${(productState.product.productionOptionals.isNotEmpty ? step1price : showPrice).toDecimalFormat()} บาท",
                                                                  textStyle: AlvaStyles()
                                                                      .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                      .copyWith(height: 2)),
                                                            ],
                                                          ),
                                                        ),
                                                        // step1.isNotEmpty
                                                        //     ? SizedBox(
                                                        //         height: 8,
                                                        //       )
                                                        //     : SizedBox.shrink(),
                                                        step1.isNotEmpty
                                                            ? Padding(
                                                                padding: EdgeInsets.only(left: 16, right: 16, bottom: step2.isEmpty ? 16 : 0),
                                                                child: SizedBox(
                                                                  width: maxWidth - 32,
                                                                  child: AlvaTextMaxLinesOverflow(
                                                                      title:
                                                                          "${productState.product.productionOptionals[pdOptState.stepOneIndexSelect ?? 0].levelName}: ${productState.product.productionOptionals[pdOptState.stepOneIndexSelect ?? 0].label}",
                                                                      maxLines: 5,
                                                                      textStyle: AlvaStyles()
                                                                          .headingSize10w400(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                          .copyWith(height: 1.6)),
                                                                ),
                                                              )
                                                            : SizedBox.shrink(),
                                                        // step2.isNotEmpty
                                                        //     ? SizedBox(
                                                        //         height: 8,
                                                        //       )
                                                        //     : SizedBox.shrink(),
                                                        // step2.isNotEmpty
                                                        //     ? Padding(
                                                        //         padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                                        //         child: Row(
                                                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //           children: [
                                                        //             SizedBox(
                                                        //               width: maxWidth - 32 - 16 - 79,
                                                        //               child: AlvaTextMaxLinesOverflow(
                                                        //                   title: step2,
                                                        //                   maxLines: 1,
                                                        //                   textStyle:
                                                        //                       AlvaStyles().headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 2)),
                                                        //             ),
                                                        //             AlvaText(
                                                        //                 title: "${step2price.toDecimalFormat()} บาท",
                                                        //                 textStyle:
                                                        //                     AlvaStyles().headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 2)),
                                                        //           ],
                                                        //         ),
                                                        //       )
                                                        //     : SizedBox.shrink(),
                                                        Container(
                                                          height: 16,
                                                          color: backgroundNo2,
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox.shrink(),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                          context.read<ShowSummaryDetailCubit>().toggle();
                                                        },
                                                        child: Container(
                                                          width: 24,
                                                          height: 24,
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(36), color: YellowKrungsri),
                                                          child: Center(
                                                            child: SizedBox(
                                                              width: 10,
                                                              height: 10,
                                                              child: Image.asset(
                                                                  showDetail ? 'assets/icons/arrow_down.png' : 'assets/icons/arrow_up.png',
                                                                  fit: BoxFit.contain),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 16),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            AlvaText(
                                                                title: "ยอดชำระเงิน",
                                                                textStyle: AlvaStyles()
                                                                    .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                    .copyWith(height: 24 / 14)),
                                                            AlvaText(
                                                                title: "(รวมภาษีมูลค่าเพิ่มแล้ว)",
                                                                textStyle: AlvaStyles().body1().copyWith(
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: 8,
                                                                      color: BTN_SELECTED_TEXT_COLOR_NEW,
                                                                      height: 2,
                                                                    )),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  AlvaText(
                                                      title:
                                                          "${(productState.product.productionOptionals.isNotEmpty ? step1price : showPrice).toDecimalFormat()} บาท",
                                                      textStyle:
                                                          AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 24 / 14)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                              height: 48,
                                              width: maxWidth - 32,
                                              child: OutlinedButton(
                                                onPressed: validated
                                                    ? () {
                                                        if (showDetail) {
                                                          context.read<ShowSummaryDetailCubit>().toggle();
                                                        }
                                                        GeneralDialog(
                                                                onAccept: () async {
                                                                  final orderBloc = context.read<OrderSummaryBloc>();
                                                                  ProductionOptionals step1SelectedOption = productState
                                                                          .product.productionOptionals.isEmpty
                                                                      ? ProductionOptionals.fromJson(const {})
                                                                      : productState.product.productionOptionals[pdOptState.stepOneIndexSelect ?? 0];
                                                                  // Level2 step2SelectedOption =
                                                                  //     step1SelectedOption.level2[selectOptionBloc.stepTwoIndexSelect ?? 0];
                                                                  requestModel = CreateOrderRequestModel(
                                                                      uid: await LineDataHelper().getLineUid(),
                                                                      products: [
                                                                        OrderProduct(
                                                                            productId: productState.product.productId,
                                                                            qty: 1,
                                                                            unitPrice: productState.product.productionOptionals.isNotEmpty
                                                                                ? step1price
                                                                                : showPrice,
                                                                            optional: productState.product.productionOptionals.isEmpty
                                                                                ? null
                                                                                : Optional(
                                                                                    productId: step1SelectedOption.subProductId,
                                                                                    qty: 1,
                                                                                    unitPrice: step1SelectedOption.price))
                                                                      ],
                                                                      paymentInfo: PaymentInfo(
                                                                          channel: orderState.paymentType.isFullPayment ? "CC" : "IPP",
                                                                          staffCode: staffCode.text),
                                                                      shippingInfo: ShippingInfo(
                                                                          fullName: shippingState.addressModel.fullName,
                                                                          address:
                                                                              '${shippingState.addressModel.fullAddress} ${shippingState.addressModel.subDistrict} ${shippingState.addressModel.district} ${shippingState.addressModel.province} ${shippingState.addressModel.zipCode}',
                                                                          firstName: shippingState.addressModel.fullName,
                                                                          lastName: "", //TODO: waiting for UI
                                                                          mobileNo: shippingState.addressModel.mobileNumber,
                                                                          houseNo: shippingState.addressModel.fullAddress,
                                                                          lane: "",
                                                                          street: "",
                                                                          subDistrict: shippingState.addressModel.subDistrict,
                                                                          district: shippingState.addressModel.district,
                                                                          province: shippingState.addressModel.province,
                                                                          postalCode: shippingState.addressModel.zipCode,
                                                                          email: shippingState.addressModel.emailAddress),
                                                                      email: shippingState.addressModel.emailAddress,
                                                                      mobilePhone: shippingState.addressModel.mobileNumber.replaceAll('-', ''));
                                                                  // debugPrint(requestModel.toJson().toString());
                                                                  orderBloc.add(CreateOrder(requestModel: requestModel));
                                                                },
                                                                onCancel: () {})
                                                            .showSummaryDialog(context: context, isConfirmPayment: true);
                                                      }
                                                    : null,
                                                style: AlvaStyles().outlineNoneBorderButtonStyle(
                                                    validated ? YellowKrungsri : cloudDeepWhite, Colors.transparent,
                                                    isRadius8: true),
                                                child: Text("ชำระเงิน",
                                                    style: AlvaStyles().headingSize16w700(validated ? BTN_SELECTED_TEXT_COLOR_NEW : smockGrey)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox.shrink());
                          } else {
                            return const LoadingScreen();
                          }
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    ));
  }
}
