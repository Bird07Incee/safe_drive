import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/main.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/model/product_summary/shipping_address_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/order_summary_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/show_sale_code_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/show_summary_detail_cubit.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_options/product_options_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_summary/shipping_address_bloc.dart';
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
    final FocusNode saleCodeNode = FocusNode();
    final TextEditingController saleCodeController = TextEditingController();
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
          if (!state.status.isSuccess) {
            //TODO: remove mock product
            context.read<ProductDetailBloc>().add(GetProductByID());
          }
          return BlocBuilder<OrderSummaryBloc, OrderSummaryState>(
            builder: (context, orderState) {
              return BlocBuilder<ShowSummaryDetailCubit, bool>(
                builder: (context, showDetail) {
                  return Scaffold(
                      body: Stack(
                        children: [
                          AlvaRootWidget(
                              titlePage: titleWebPage,
                              appBar: AppBar(
                                title: AlvaText(
                                    title: "สรุปรายการสั่งซื้อ",
                                    textStyle: AlvaStyles()
                                        .headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                        .copyWith(height: 24 / 18)),
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
                              // child: ProductDetailBody(),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(left: 16, right: 16),
                                height: maxHeight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 12, bottom: 12),
                                      child: AlvaText(
                                          title: "รายละเอียดสินค้า",
                                          textStyle: AlvaStyles()
                                              .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                              .copyWith(height: 24 / 14)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 42,
                                                width: 76,
                                                child: state.product.productionAssets.isNotEmpty
                                                    ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(4),
                                                        child: FadeInImage(
                                                          placeholder:
                                                              AssetImage(ProductSelectOptionsConst().imgDefaultPath),
                                                          image: NetworkImage(state.product.productionAssets.first),
                                                          fit: BoxFit.fitWidth,
                                                          imageErrorBuilder: (context, error, stackTrace) =>
                                                              Image.asset(ProductSelectOptionsConst().imgDefaultPath,
                                                                  fit: BoxFit.fitWidth),
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
                                              AlvaText(
                                                  title: state.product.productName,
                                                  textStyle: AlvaStyles()
                                                      .headingSize12w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                      .copyWith(height: 2)),
                                              //TODO: bind product selected option
                                              AlvaText(
                                                  title: "สีดำ, ความยาวสาย 3 เมตร",
                                                  textStyle: AlvaStyles()
                                                      .headingSize10w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                      .copyWith(height: 1.6)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 12, bottom: 12),
                                      child: AlvaText(
                                          title: "ที่อยู่ในการจัดส่งสินค้า",
                                          textStyle: AlvaStyles()
                                              .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                              .copyWith(height: 24 / 14)),
                                    ),
                                    BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
                                      builder: (context, shippingState) {
                                        return Container(
                                            padding: EdgeInsets.only(top: 8, bottom: 24),
                                            child: shippingState.addressModel.isEmpty
                                                ? GestureDetector(
                                                    behavior: HitTestBehavior.translucent,
                                                    onTap: () {
                                                      //TODO: Go add address
                                                      context.read<ShippingAddressBloc>().mockAddress();
                                                    },
                                                    child: Container(
                                                      width: maxWidth - 32,
                                                      height: 48,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(width: 2, color: YellowKrungsri)),
                                                      child: Center(
                                                          child: AlvaText(
                                                              title: "เพิ่มที่อยู่",
                                                              textStyle: AlvaStyles()
                                                                  .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                  .copyWith(height: 24 / 14))),
                                                    ),
                                                  )
                                                : Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          shippingState.addressModel.fullName.isNotEmpty
                                                              ? AlvaText(
                                                                  title: shippingState.addressModel.fullName,
                                                                  textStyle: AlvaStyles()
                                                                      .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                      .copyWith(height: 2))
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
                                                              ? AlvaText(
                                                                  title: shippingState.addressModel.fullName,
                                                                  textStyle: AlvaStyles()
                                                                      .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                      .copyWith(height: 2))
                                                              : SizedBox.shrink(),
                                                          AlvaText(
                                                              title:
                                                                  "${shippingState.addressModel.subDistrict} ${shippingState.addressModel.district} ${shippingState.addressModel.province} ${shippingState.addressModel.zipCode}",
                                                              textStyle: AlvaStyles()
                                                                  .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                  .copyWith(height: 2)),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          //TODO: Go to edit address
                                                        },
                                                        child: Container(
                                                          width: 24,
                                                          height: 24,
                                                          decoration: BoxDecoration(
                                                              color: cloudyWhite,
                                                              borderRadius: BorderRadius.circular(36)),
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
                                                  ));
                                      },
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 12, bottom: 12),
                                      child: AlvaText(
                                          title: "ช่องทางการชำระเงิน",
                                          textStyle: AlvaStyles()
                                              .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                              .copyWith(height: 24 / 14)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (orderState.paymentType.isInstallment) {
                                                    context
                                                        .read<OrderSummaryBloc>()
                                                        .add(SelectPaymentType(paymentType: PaymentType.fullPayment));
                                                  }
                                                },
                                                child: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(36),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: orderState.paymentType.isFullPayment
                                                              ? BlueFantasy
                                                              : spaceGrey123)),
                                                  child: Center(
                                                    child: Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        color: orderState.paymentType.isFullPayment
                                                            ? BlueFantasy
                                                            : spaceGrey123,
                                                        borderRadius: BorderRadius.circular(36),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              AlvaText(
                                                  title: "ชำระเต็มจำนวน",
                                                  textStyle: AlvaStyles()
                                                      .headingSize14w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                      .copyWith(height: 24 / 14)),
                                            ],
                                          ),
                                          AlvaText(
                                              title: "บัตรเครดิต/เดบิต",
                                              textStyle: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12, bottom: 28),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (orderState.paymentType.isFullPayment) {
                                                    context
                                                        .read<OrderSummaryBloc>()
                                                        .add(SelectPaymentType(paymentType: PaymentType.installment));
                                                  }
                                                },
                                                child: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(36),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: orderState.paymentType.isInstallment
                                                              ? BlueFantasy
                                                              : spaceGrey123)),
                                                  child: Center(
                                                    child: Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        color: orderState.paymentType.isInstallment
                                                            ? BlueFantasy
                                                            : spaceGrey123,
                                                        borderRadius: BorderRadius.circular(36),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              AlvaText(
                                                  title: "ผ่อนชำระ",
                                                  textStyle: AlvaStyles()
                                                      .headingSize14w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                      .copyWith(height: 24 / 14)),
                                            ],
                                          ),
                                          AlvaText(
                                              title: "เฉพาะบัตรเครดิตในเครือกรุงศรี",
                                              textStyle: AlvaStyles().headingSize12w400(spaceGrey).copyWith(height: 2)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 12, bottom: 12),
                                      child: Row(
                                        children: [
                                          AlvaText(
                                              title: "รหัสการขาย",
                                              textStyle: AlvaStyles()
                                                  .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                  .copyWith(height: 24 / 14)),
                                          AlvaText(
                                              title: "(ถ้ามี)",
                                              textStyle: AlvaStyles()
                                                  .headingSize14w400(spaceGrey123)
                                                  .copyWith(height: 24 / 14)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 12 + 32 + 24,
                                      padding: EdgeInsets.only(top: 12, bottom: 24),
                                      child: BlocBuilder<ShowSaleCodeCubit, bool>(
                                        builder: (context, showEditForm) {
                                          return TextFormField(
                                            key: const Key("sale_code_box"),
                                            controller: saleCodeController,
                                            onChanged: (text) {
                                              if (text != "") {
                                                context.read<ShowSaleCodeCubit>().show(true);
                                              } else {
                                                context.read<ShowSaleCodeCubit>().show(false);
                                              }
                                            },
                                            focusNode: saleCodeNode,
                                            maxLines: 1,
                                            textInputAction: TextInputAction.search,
                                            style: AlvaStyles()
                                                .headingSize16w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                .copyWith(height: 26 / 16),
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
                                                            saleCodeController.clear();
                                                            saleCodeNode.requestFocus();
                                                          },
                                                          child: Container(
                                                            width: 24,
                                                            height: 24,
                                                            decoration: BoxDecoration(
                                                                color: cloudyWhite,
                                                                borderRadius: BorderRadius.circular(36)),
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
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintMaxLines: 1,
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xff9c9c9c),
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
                                              if (saleCodeController.text.length <= 1) {
                                                FocusManager.instance.primaryFocus?.requestFocus();
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32,
                                    )
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
                      bottomSheet: Container(
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
                        width: maxWidth,
                        height: showDetail ? 321 : 160,
                        padding: const EdgeInsets.only(bottom: 32),
                        child: Column(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: showDetail
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(top: 16, bottom: 16),
                                            decoration: BoxDecoration(
                                                border: Border(bottom: BorderSide(width: 1, color: cloudWhite))),
                                            child: Center(
                                                child: AlvaText(
                                                    title: "รายการสั่งซื้อ",
                                                    textStyle: AlvaStyles()
                                                        .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                        .copyWith(height: 24 / 14)))),
                                        //TODO: loop for product options
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              AlvaText(
                                                  title: "Pulsar MAX สีดำ",
                                                  textStyle: AlvaStyles()
                                                      .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                      .copyWith(height: 2)),
                                              AlvaText(
                                                  title: "56,640 บาท",
                                                  textStyle: AlvaStyles()
                                                      .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                      .copyWith(height: 2)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              AlvaText(
                                                  title: "ความยาวสาย 3 เมตร",
                                                  textStyle: AlvaStyles()
                                                      .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                      .copyWith(height: 2)),
                                              AlvaText(
                                                  title: "0 บาท",
                                                  textStyle: AlvaStyles()
                                                      .headingSize12w500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                      .copyWith(height: 2)),
                                            ],
                                          ),
                                        ),
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
                                          context.read<ShowSummaryDetailCubit>().toggle();
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(36), color: YellowKrungsri),
                                          child: Center(
                                            child: SizedBox(
                                              width: 10,
                                              height: 10,
                                              child: Image.asset(
                                                  showDetail
                                                      ? 'assets/icons/arrow_down.png'
                                                      : 'assets/icons/arrow_up.png',
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
                                                title: "ยอดรวมสุทธิ",
                                                textStyle: AlvaStyles()
                                                    .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                    .copyWith(height: 24 / 14)),
                                            AlvaText(
                                                title: "(ยอดชำระนี้รวมภาษีมูลค่าเพิ่มแล้ว)",
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
                                  //TODO: bind price
                                  AlvaText(
                                      title: "56,640 บาท",
                                      textStyle: AlvaStyles()
                                          .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                          .copyWith(height: 24 / 14)),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                              height: 48,
                              width: maxWidth - 32,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: AlvaStyles()
                                    .outlineNoneBorderButtonStyle(YellowKrungsri, Colors.transparent, isRadius8: true),
                                child: Text("ชำระเงิน",
                                    style: AlvaStyles().headingSize16w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              );
            },
          );
        },
      ),
    ));
  }
}
