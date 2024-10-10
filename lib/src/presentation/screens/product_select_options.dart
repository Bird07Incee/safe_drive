import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/helpers/maintenance_helper.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/product_detail_bloc/product_detail_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_options/product_options_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/navigator_helper.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';

class ProductSelectOptions extends StatefulWidget {
  const ProductSelectOptions({super.key});
  @override
  State<ProductSelectOptions> createState() => _ProductSelectOptionsState();
}

class _ProductSelectOptionsState extends State<ProductSelectOptions> {
  late RouteSettings? settings;
  String pid = '';
  String maStatus = 'False';

  @override
  void didChangeDependencies() {
    loadProduct();
    super.didChangeDependencies();
  }

  loadProduct() {
    settings = ModalRoute.of(context)?.settings;
    if (settings != null) {
      var uriData = Uri.parse(settings!.name!);
      var routingData = RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
      pid = (routingData["pid"] == null) ? "" : routingData["pid"];
      ProductDetailState pdState = context.read<ProductDetailBloc>().state;
      if (pdState.status.isInitial && pid != "") {
        context.read<ProductDetailBloc>().add(GetProductByID(pid: pid));
      }
    }
  }

  getMaStatus() async {
    var status = await MaintenanceHelper().getMaintenanceDataForCreateTransaction();
    setState(() {
      maStatus = status;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductDetailState pdState = context.read<ProductDetailBloc>().state;
    getMaStatus();
    AmplitudeWebHelper.getInstance().logEnterProductOptionPage(
        productName: pdState.product.productName, contentId: pdState.product.productId, merchantName: pdState.product.merchantFullName);
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    final myBloc = BlocProvider.of<ProductOptionBloc>(context);
    ProductDetailState pdState = context.read<ProductDetailBloc>().state;
    resetAllState() {
      myBloc.updateStepOneVariables(
        groupValueRadio: "",
        price: 0,
        indexSelect: 0,
      );
      myBloc.updateStepTwoVariables(
        groupValueRadio: "",
        price: 0,
        indexSelect: 0,
      );
      myBloc.updateStepTreeVariables(
        groupValueRadio: "",
        price: 0,
        indexSelect: 0,
      );
      myBloc.updateStepFourVariables(
        groupValueRadio: "",
        price: 0,
        indexSelect: 0,
      );
      myBloc.updateStepFiveVariables(
        groupValueRadio: "",
        price: 0,
        indexSelect: 0,
      );
      myBloc.updateSelectCurrentOption(0);
      myBloc.updateLastOption(1);
      refreshRoute(context: context, currentRoute: "selectOption", queryParams: "pid=$pid", listOption: pdState.product.productionOptionals);
    }

    return BlocBuilder<ProductOptionBloc, ProductOptionState>(
      builder: (context, prodOptState) {
        return RootPageCondition(
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, Object? result) async {
              if (didPop) {
                return;
              }
              if (context.mounted) {
                AmplitudeWebHelper.getInstance().logEnterProductDetails(
                    productName: pdState.product.productName, contentId: pdState.product.productId, merchantName: pdState.product.merchantFullName);
                resetAllState();
              }
            },
            child: maStatus.toLowerCase() == "true"
                ? AlvaRootWidget(
                    titlePage: titleWebPage,
                    child: ErrorScreen(
                      title: ErrorConst().titleMaintenance,
                      subTitle: ErrorConst().subtitleMaintenance,
                      titleBtn: ErrorConst().titleBtnMaintenance,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ))
                : AlvaRootWidget(
                    titlePage: titleWebPage,
                    bottomSheet: Container(
                      width: maxWidth,
                      height: 96,
                      padding: const EdgeInsets.only(bottom: 32, top: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: const Color(0xff000000).withOpacity(0.04), spreadRadius: 0, blurRadius: 16, offset: const Offset(0, -4)),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              child: prodOptState.selectCurrentOption == prodOptState.lastOption &&
                                      (prodOptState.selectCurrentOption != 0 && prodOptState.lastOption != 0)
                                  ? OutlinedButton(
                                      onPressed: () async {
                                        String productOptionId = "";
                                        String productOptionPrice = "";
                                        if (pdState.product.productionOptionals.isNotEmpty) {
                                          productOptionId = pdState.product.productionOptionals[prodOptState.stepOneIndexSelect ?? 0].subProductId;
                                          productOptionPrice =
                                              pdState.product.productionOptionals[prodOptState.stepOneIndexSelect ?? 0].price.toDecimalFormat();
                                        }
                                        AmplitudeWebHelper.getInstance().logTapOnNextButton(
                                            productName: "${pdState.product.productName} ${prodOptState.stepOneGroupValueRadio}",
                                            contentId: pdState.product.productId,
                                            merchantName: pdState.product.merchantFullName,
                                            productOptionPrice: productOptionPrice,
                                            optionId: productOptionId);

                                        await Navigator.pushNamed(
                                            context, '${Routes.orderSummary.toStringPath()}?pid=$pid&opt_lv1=${prodOptState.stepOneIndexSelect}');
                                        resetAllState();
                                      },
                                      style: AlvaStyles().outlineNoneBorderButtonStyle(YellowKrungsri, Colors.transparent),
                                      child: Text(ProductSelectOptionsConst().continueText,
                                          style: AlvaStyles().headingSize16w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                                    )
                                  : OutlinedButton(
                                      onPressed: null,
                                      style: AlvaStyles().outlineNoneBorderButtonStyle(cloudSoftDeepWhite, Colors.transparent),
                                      child: Text(ProductSelectOptionsConst().continueText, style: AlvaStyles().headingSize16w700(smockGrey)),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                    appBar: AppBar(
                      title: AlvaText(
                          title: ProductSelectOptionsConst().selectProdText, textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                      titleSpacing: 0,
                      leadingWidth: 60,
                      elevation: 0,
                      centerTitle: false,
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                          key: Key(ProductSelectOptionsConst().backButtonKey),
                          onPressed: () {
                            AmplitudeWebHelper.getInstance().logEnterProductDetails(
                                productName: pdState.product.productName,
                                contentId: pdState.product.productId,
                                merchantName: pdState.product.merchantFullName);
                            resetAllState();
                          },
                          icon: const Icon(Icons.arrow_back_ios)),
                    ),
                    child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                      builder: (context, state) {
                        if (state.status.isSuccess) {
                          double aspectRatio = 16 / 9;

                          // Dynamically calculated cacheWidth
                          double cacheWidth = (MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio.toInt());
                          // Calculate cacheHeight based on aspect ratio
                          double cacheHeight = (cacheWidth / aspectRatio);

                          if (cacheWidth > 1194) cacheWidth = 1194;
                          if (cacheHeight > 671) cacheHeight = 671;

                          return Container(
                            color: whitePure,
                            child: Theme(
                              data: Theme.of(context).copyWith(unselectedWidgetColor: spaceGrey123, disabledColor: BlueFantasy),
                              child: ListView(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: maxWidth,
                                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                        color: cloudyWhite,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: maxWidth - 32,
                                              child: AlvaTextMaxLinesOverflow(
                                                  title: state.product.productionOptionals[0].levelName,
                                                  maxLines: 1,
                                                  textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: state.product.productionOptionals.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return state.product.productionOptionals[index].quantity > 0
                                                    ? GestureDetector(
                                                        key: Key("product_option_button_$index"),
                                                        onTap: () {
                                                          if (prodOptState.stepOneGroupValueRadio == state.product.productionOptionals[index].label) {
                                                            myBloc.updateStepOneVariables(
                                                              groupValueRadio: "",
                                                              price: 0,
                                                              indexSelect: myBloc.state.stepOneIndexSelect,
                                                            );
                                                            myBloc.updateStepTwoVariables(
                                                              groupValueRadio: "",
                                                              price: 0,
                                                              indexSelect: myBloc.state.stepTwoIndexSelect,
                                                            );
                                                            myBloc.updateStepTreeVariables(
                                                              groupValueRadio: "",
                                                              price: 0,
                                                              indexSelect: myBloc.state.stepTreeIndexSelect,
                                                            );
                                                            myBloc.updateStepFourVariables(
                                                              groupValueRadio: "",
                                                              price: 0,
                                                              indexSelect: myBloc.state.stepFourIndexSelect,
                                                            );
                                                            myBloc.updateStepFiveVariables(
                                                              groupValueRadio: "",
                                                              price: 0,
                                                              indexSelect: myBloc.state.stepFiveIndexSelect,
                                                            );
                                                            myBloc.updateSelectCurrentOption(0);
                                                            myBloc.updateLastOption(0);
                                                          } else {
                                                            myBloc.updateStepOneVariables(
                                                              groupValueRadio: state.product.productionOptionals[index].label,
                                                              price: state.product.productionOptionals[index].price,
                                                              indexSelect: index,
                                                            );
                                                            myBloc.updateStepTwoVariables(
                                                              groupValueRadio: "",
                                                              price: 0,
                                                              indexSelect: myBloc.state.stepTwoIndexSelect,
                                                            );
                                                            myBloc.updateStepTreeVariables(
                                                              groupValueRadio: "",
                                                              price: 0,
                                                              indexSelect: myBloc.state.stepTreeIndexSelect,
                                                            );
                                                            myBloc.updateStepFourVariables(
                                                              groupValueRadio: "",
                                                              price: 0,
                                                              indexSelect: myBloc.state.stepFourIndexSelect,
                                                            );
                                                            myBloc.updateStepFiveVariables(
                                                              groupValueRadio: "",
                                                              price: 0,
                                                              indexSelect: myBloc.state.stepFiveIndexSelect,
                                                            );
                                                            myBloc.updateSelectCurrentOption(1);
                                                            if (state.product.productionOptionals[index].level2.isNotEmpty) {
                                                              myBloc.updateLastOption(2);
                                                            } else {
                                                              myBloc.updateLastOption(1);
                                                            }
                                                          }
                                                        },
                                                        child: AbsorbPointer(
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Container(
                                                                      width: 24,
                                                                      height: 24,
                                                                      margin: const EdgeInsets.only(right: 16),
                                                                      child: Radio(
                                                                        value: state.product.productionOptionals[index].label,
                                                                        groupValue: prodOptState.stepOneGroupValueRadio,
                                                                        toggleable: true,
                                                                        onChanged: (value) {
                                                                          if (value == null) {
                                                                            myBloc.updateStepOneVariables(
                                                                              groupValueRadio: "",
                                                                              price: 0,
                                                                              indexSelect: myBloc.state.stepOneIndexSelect,
                                                                            );
                                                                            myBloc.updateStepTwoVariables(
                                                                              groupValueRadio: "",
                                                                              price: 0,
                                                                              indexSelect: myBloc.state.stepTwoIndexSelect,
                                                                            );
                                                                            myBloc.updateStepTreeVariables(
                                                                              groupValueRadio: "",
                                                                              price: 0,
                                                                              indexSelect: myBloc.state.stepTreeIndexSelect,
                                                                            );
                                                                            myBloc.updateStepFourVariables(
                                                                              groupValueRadio: "",
                                                                              price: 0,
                                                                              indexSelect: myBloc.state.stepFourIndexSelect,
                                                                            );
                                                                            myBloc.updateStepFiveVariables(
                                                                              groupValueRadio: "",
                                                                              price: 0,
                                                                              indexSelect: myBloc.state.stepFiveIndexSelect,
                                                                            );
                                                                            myBloc.updateSelectCurrentOption(0);
                                                                            myBloc.updateLastOption(0);
                                                                          } else {
                                                                            myBloc.updateStepOneVariables(
                                                                              groupValueRadio: value.toString(),
                                                                              price: state.product.productionOptionals[index].price,
                                                                              indexSelect: index,
                                                                            );
                                                                            myBloc.updateStepTwoVariables(
                                                                              groupValueRadio: "",
                                                                              price: 0,
                                                                              indexSelect: myBloc.state.stepTwoIndexSelect,
                                                                            );
                                                                            myBloc.updateStepTreeVariables(
                                                                              groupValueRadio: "",
                                                                              price: 0,
                                                                              indexSelect: myBloc.state.stepTreeIndexSelect,
                                                                            );
                                                                            myBloc.updateStepFourVariables(
                                                                              groupValueRadio: "",
                                                                              price: 0,
                                                                              indexSelect: myBloc.state.stepFourIndexSelect,
                                                                            );
                                                                            myBloc.updateStepFiveVariables(
                                                                              groupValueRadio: "",
                                                                              price: 0,
                                                                              indexSelect: myBloc.state.stepFiveIndexSelect,
                                                                            );
                                                                            myBloc.updateSelectCurrentOption(1);
                                                                            if (state.product.productionOptionals[index].level2.isNotEmpty) {
                                                                              myBloc.updateLastOption(2);
                                                                            } else {
                                                                              myBloc.updateLastOption(1);
                                                                            }
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom: 4),
                                                                            child: SizedBox(
                                                                              width: maxWidth - 32 - 24 - 72,
                                                                              child: Text(state.product.productionOptionals[index].label,
                                                                                  style: AlvaStyles()
                                                                                      .bodySize14W500(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                                      .copyWith(height: 22 / 14)),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom: 4),
                                                                            child: SizedBox(
                                                                              width: maxWidth - 32 - 24 - 72,
                                                                              child: Text(state.product.productName,
                                                                                  style: AlvaStyles()
                                                                                      .headingSize10w400(spaceGrey)
                                                                                      .copyWith(height: 1.6)),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width: maxWidth - 32 - 24 - 72,
                                                                            child: Text(
                                                                                "${(state.product.productionOptionals[index].price).toDecimalFormat()} บาท",
                                                                                style: AlvaStyles()
                                                                                    .headingSize16w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                                    .copyWith(height: 24 / 16)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height: 40,
                                                                      width: 72,
                                                                      padding: const EdgeInsets.only(left: 16),
                                                                      child: AspectRatio(
                                                                        aspectRatio: 16 / 9,
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(4),
                                                                          child: FadeInImage.assetNetwork(
                                                                            placeholder: ProductSelectOptionsConst().imgDefaultPath,
                                                                            image: state.product.productionOptionals[index].image == ""
                                                                                ? state.product.productionAssets.first
                                                                                : state.product.productionOptionals[index].image,
                                                                            fit: BoxFit.cover,
                                                                            width: cacheWidth,
                                                                            height: cacheHeight,
                                                                            imageCacheWidth: cacheWidth.round(),
                                                                            imageCacheHeight: cacheHeight.round(),
                                                                            imageErrorBuilder: (context, error, stackTrace) => Container(
                                                                              height: 40,
                                                                              width: 72,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(4),
                                                                              ),
                                                                              child: Image.asset(
                                                                                ProductSelectOptionsConst().imgDefaultPath,
                                                                                fit: BoxFit.fill,
                                                                                width: cacheWidth,
                                                                                height: cacheHeight,
                                                                                cacheWidth: cacheWidth.round(),
                                                                                cacheHeight: cacheHeight.round(),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                color: cloudSoftDeepWhite,
                                                                width: maxWidth,
                                                                height: 1,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox.shrink();
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 96,
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const LoadingScreen();
                        }
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }
}
