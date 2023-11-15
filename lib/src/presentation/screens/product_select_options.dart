import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/model/product_detail/product_detail_args.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_options/product_options_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';

class ProductSelectOptions extends StatefulWidget {
  const ProductSelectOptions({Key? key, this.arguments}) : super(key: key);
  final ProductDetailArgs? arguments;
  @override
  State<ProductSelectOptions> createState() => _ProductSelectOptionsState();
}

class _ProductSelectOptionsState extends State<ProductSelectOptions> {
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    final myBloc = BlocProvider.of<ProductOptionBloc>(context);
    resetAllState() {
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
      myBloc.updateLastOption(1);
    }

    return BlocBuilder<ProductOptionBloc, ProductOptionState>(
      builder: (context, prodOptState) {
        return RootPageCondition(
          child: WillPopScope(
            onWillPop: () async {
              resetAllState();
              return true;
            },
            child: AlvaRootWidget(
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
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.orderSummary.toStringPath());
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
                      resetAllState();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
              ),
              child: Container(
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
                                      title: widget.arguments!.product.productionOptionals[0].levelName,
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
                                  itemCount: widget.arguments!.product.productionOptionals.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (prodOptState.stepOneGroupValueRadio == widget.arguments!.product.productionOptionals[index].label) {
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
                                            groupValueRadio: widget.arguments!.product.productionOptionals[index].label,
                                            price: widget.arguments!.product.productionOptionals[index].price,
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
                                          if (widget.arguments!.product.productionOptionals[index].level2.isNotEmpty) {
                                            myBloc.updateLastOption(2);
                                          } else {
                                            myBloc.updateLastOption(1);
                                          }
                                        }
                                      },
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
                                                    value: widget.arguments!.product.productionOptionals[index].label,
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
                                                          price: widget.arguments!.product.productionOptionals[index].price,
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
                                                        if (widget.arguments!.product.productionOptionals[index].level2.isNotEmpty) {
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
                                                          child: Text(widget.arguments!.product.productionOptionals[index].label,
                                                              style: AlvaStyles().bodySize12W600(BTN_SELECTED_TEXT_COLOR_NEW).copyWith(height: 2)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 4),
                                                        child: Text(widget.arguments!.product.productName,
                                                            style: AlvaStyles().headingSize10w400(spaceGrey).copyWith(height: 1.6)),
                                                      ),
                                                      SizedBox(
                                                        width: maxWidth - 32 - 24 - 72 - 32,
                                                        child: Text(
                                                            "${(widget.arguments!.product.productionOptionals[index].price).toDecimalFormat()} บาท",
                                                            style: AlvaStyles()
                                                                .headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)
                                                                .copyWith(height: 24 / 14)),
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
                                                      child: FadeInImage(
                                                        placeholder: AssetImage(ProductSelectOptionsConst().imgDefaultPath),
                                                        image: NetworkImage(widget.arguments!.product.productionOptionals[index].image == ""
                                                            ? widget.arguments!.product.productionAssets.first
                                                            : widget.arguments!.product.productionOptionals[index].image),
                                                        fit: BoxFit.cover,
                                                        imageErrorBuilder: (context, error, stackTrace) => Container(
                                                          height: 40,
                                                          width: 72,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: Image.asset(ProductSelectOptionsConst().imgDefaultPath, fit: BoxFit.fill),
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
                                    );
                                  }),
                              // Container(
                              //   margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       prodOptState.stepOneGroupValueRadio == ""
                              //           ? Expanded(
                              //               child: AlvaTextMaxLinesOverflow(
                              //                   title: "ตัวเลือก${widget.arguments!.product.productionOptionals[0].levelName}",
                              //                   maxLines: 1,
                              //                   textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite)),
                              //             )
                              //           : Expanded(
                              //               child: AlvaTextMaxLinesOverflow(
                              //                   title: prodOptState.stepOneGroupValueRadio,
                              //                   maxLines: 1,
                              //                   textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                              //             ),
                              //       prodOptState.stepOnePrice == 0 && prodOptState.selectCurrentOption != 1
                              //           ? AlvaText(
                              //               title: ProductSelectOptionsConst().priceProdDefaultText,
                              //               textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                              //           : AlvaText(
                              //               title: "${prodOptState.stepOnePrice!.toDecimalFormat()} บาท",
                              //               textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      // prodOptState.stepOneGroupValueRadio == "" ||
                      //         widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2.isEmpty
                      //     ? Container()
                      //     : Column(
                      //         children: [
                      //           Container(
                      //             width: maxWidth,
                      //             color: cloudyWhite,
                      //             padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 SizedBox(
                      //                   width: maxWidth - 32,
                      //                   child: AlvaTextMaxLinesOverflow(
                      //                     title: widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[0].levelName,
                      //                     maxLines: 1,
                      //                     textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           Container(
                      //             color: whitePure,
                      //             child: Column(
                      //               children: [
                      //                 ListView.builder(
                      //                   shrinkWrap: true,
                      //                   physics: NeverScrollableScrollPhysics(),
                      //                   itemCount: widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2.length,
                      //                   itemBuilder: (BuildContext context, int index) {
                      //                     return GestureDetector(
                      //                       onTap: () {
                      //                         if (prodOptState.stepTwoGroupValueRadio ==
                      //                             widget
                      //                                 .arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[index].label) {
                      //                           myBloc.updateStepTwoVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepTwoIndexSelect,
                      //                           );
                      //                           myBloc.updateStepTreeVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepTreeIndexSelect,
                      //                           );
                      //                           myBloc.updateStepFourVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFourIndexSelect,
                      //                           );
                      //                           myBloc.updateStepFiveVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                           );
                      //                           myBloc.updateSelectCurrentOption(1);
                      //                           myBloc.updateLastOption(2);
                      //                         } else {
                      //                           myBloc.updateStepTwoVariables(
                      //                             groupValueRadio: widget
                      //                                 .arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[index].label,
                      //                             price: widget
                      //                                 .arguments!.product.productionOptionals[myBloc.state.stepOneIndexSelect!].level2[index].price,
                      //                             indexSelect: index,
                      //                           );
                      //                           myBloc.updateStepTreeVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepTreeIndexSelect,
                      //                           );
                      //                           myBloc.updateStepFourVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFourIndexSelect,
                      //                           );
                      //                           myBloc.updateStepFiveVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                           );
                      //                           myBloc.updateSelectCurrentOption(2);
                      //                           if (widget.arguments!.product.productionOptionals[myBloc.state.stepOneIndexSelect!].level2[index]
                      //                               .level3.isNotEmpty) {
                      //                             myBloc.updateLastOption(3);
                      //                           } else {
                      //                             myBloc.updateLastOption(2);
                      //                           }
                      //                         }
                      //                       },
                      //                       child: Container(
                      //                         color: whitePure,
                      //                         child: Column(
                      //                           children: [
                      //                             Container(
                      //                               margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      //                               child: Row(
                      //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                                 children: [
                      //                                   Row(
                      //                                     children: [
                      //                                       SizedBox(
                      //                                         width: 24,
                      //                                         height: 24,
                      //                                         child: Radio(
                      //                                           value: widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                               .level2[index].label,
                      //                                           groupValue: prodOptState.stepTwoGroupValueRadio,
                      //                                           toggleable: true,
                      //                                           onChanged: (value) {
                      //                                             if (value == null) {
                      //                                               myBloc.updateStepTwoVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepTwoIndexSelect,
                      //                                               );
                      //                                               myBloc.updateStepTreeVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepTreeIndexSelect,
                      //                                               );
                      //                                               myBloc.updateStepFourVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFourIndexSelect,
                      //                                               );
                      //                                               myBloc.updateStepFiveVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                                               );
                      //                                               myBloc.updateSelectCurrentOption(1);
                      //                                               myBloc.updateLastOption(2);
                      //                                             } else {
                      //                                               myBloc.updateStepTwoVariables(
                      //                                                 groupValueRadio: value.toString(),
                      //                                                 price: widget.arguments!.product
                      //                                                     .productionOptionals[myBloc.state.stepOneIndexSelect!].level2[index].price,
                      //                                                 indexSelect: index,
                      //                                               );
                      //                                               myBloc.updateStepTreeVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepTreeIndexSelect,
                      //                                               );
                      //                                               myBloc.updateStepFourVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFourIndexSelect,
                      //                                               );
                      //                                               myBloc.updateStepFiveVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                                               );
                      //                                               myBloc.updateSelectCurrentOption(2);
                      //                                               if (widget
                      //                                                   .arguments!
                      //                                                   .product
                      //                                                   .productionOptionals[myBloc.state.stepOneIndexSelect!]
                      //                                                   .level2[index]
                      //                                                   .level3
                      //                                                   .isNotEmpty) {
                      //                                                 myBloc.updateLastOption(3);
                      //                                               } else {
                      //                                                 myBloc.updateLastOption(2);
                      //                                               }
                      //                                             }
                      //                                           },
                      //                                         ),
                      //                                       ),
                      //                                       widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                   .level2[index].image ==
                      //                                               ""
                      //                                           ? SizedBox.shrink()
                      //                                           : Row(
                      //                                               children: [
                      //                                                 SizedBox(
                      //                                                   width: 16,
                      //                                                 ),
                      //                                                 SizedBox(
                      //                                                   height: 42,
                      //                                                   child: AspectRatio(
                      //                                                     aspectRatio: 16 / 9,
                      //                                                     child: ClipRRect(
                      //                                                       borderRadius: BorderRadius.circular(4),
                      //                                                       child: FadeInImage(
                      //                                                         placeholder: AssetImage(ProductSelectOptionsConst().imgDefaultPath),
                      //                                                         image: NetworkImage(
                      //                                                           widget
                      //                                                               .arguments!
                      //                                                               .product
                      //                                                               .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                               .level2[index]
                      //                                                               .image,
                      //                                                         ),
                      //                                                         fit: BoxFit.fitWidth,
                      //                                                         imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                      //                                                             ProductSelectOptionsConst().imgDefaultPath,
                      //                                                             fit: BoxFit.fitWidth),
                      //                                                       ),
                      //                                                     ),
                      //                                                   ),
                      //                                                 ),
                      //                                               ],
                      //                                             ),
                      //                                       SizedBox(width: 16),
                      //                                     ],
                      //                                   ),
                      //                                   // SizedBox, AlvaText for price
                      //                                   Expanded(
                      //                                     child: Container(
                      //                                       margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      //                                       child: Text(
                      //                                           widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                               .level2[index].label,
                      //                                           style: AlvaStyles().bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW)),
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(width: 16),
                      //                                   Container(
                      //                                     margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                      //                                     child: Text(
                      //                                       "${widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[index].price.toDecimalFormat()} บาท",
                      //                                       style: AlvaStyles().headingSize12w400(spaceGrey),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                             // Divider
                      //                             Container(
                      //                               color: cloudSoftDeepWhite,
                      //                               width: maxWidth - 32,
                      //                               height: 1,
                      //                             )
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //                 Container(
                      //                   margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     children: [
                      //                       prodOptState.stepTwoGroupValueRadio == ""
                      //                           ? Expanded(
                      //                               child: AlvaTextMaxLinesOverflow(
                      //                                 title:
                      //                                     "ตัวเลือก${widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[0].levelName}",
                      //                                 maxLines: 1,
                      //                                 textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite),
                      //                               ),
                      //                             )
                      //                           : Expanded(
                      //                               child: AlvaTextMaxLinesOverflow(
                      //                                   title: prodOptState.stepTwoGroupValueRadio,
                      //                                   maxLines: 1,
                      //                                   textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                      //                             ),
                      //                       SizedBox(width: 16),
                      //                       prodOptState.stepTwoPrice == 0 && prodOptState.selectCurrentOption != 2
                      //                           ? AlvaText(
                      //                               title: ProductSelectOptionsConst().priceProdDefaultText,
                      //                               textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite),
                      //                             )
                      //                           : AlvaText(
                      //                               title: "${prodOptState.stepTwoPrice!.toDecimalFormat()} บาท",
                      //                               textStyle: AlvaStyles().bodySize16W600(blackGoMunTo),
                      //                             ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      // prodOptState.stepTwoGroupValueRadio == "" ||
                      //         widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!]
                      //             .level3.isEmpty
                      //     ? Container()
                      //     : Column(
                      //         children: [
                      //           Container(
                      //             color: cloudyWhite,
                      //             width: maxWidth,
                      //             padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 SizedBox(
                      //                   width: maxWidth - 32,
                      //                   child: AlvaTextMaxLinesOverflow(
                      //                       title: widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                           .level2[prodOptState.stepTwoIndexSelect!].level3[0].levelName,
                      //                       maxLines: 1,
                      //                       textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           Container(
                      //             color: whitePure,
                      //             child: Column(
                      //               children: [
                      //                 ListView.builder(
                      //                   shrinkWrap: true,
                      //                   physics: NeverScrollableScrollPhysics(),
                      //                   itemCount: widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                       .level2[prodOptState.stepTwoIndexSelect!].level3.length,
                      //                   itemBuilder: (BuildContext context, int index) {
                      //                     return GestureDetector(
                      //                       onTap: () {
                      //                         if (prodOptState.stepTreeGroupValueRadio ==
                      //                             widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                 .level2[prodOptState.stepTwoIndexSelect!].level3[index].label) {
                      //                           myBloc.updateStepTreeVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepTreeIndexSelect,
                      //                           );
                      //                           myBloc.updateStepFourVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFourIndexSelect,
                      //                           );
                      //                           myBloc.updateStepFiveVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                           );
                      //                           myBloc.updateSelectCurrentOption(2);
                      //                           myBloc.updateLastOption(3);
                      //                         } else {
                      //                           myBloc.updateStepTreeVariables(
                      //                             groupValueRadio: widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                 .level2[prodOptState.stepTwoIndexSelect!].level3[index].label,
                      //                             price: widget.arguments!.product.productionOptionals[myBloc.state.stepOneIndexSelect!]
                      //                                 .level2[myBloc.state.stepTwoIndexSelect!].level3[index].price,
                      //                             indexSelect: index,
                      //                           );
                      //                           myBloc.updateStepFourVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFourIndexSelect,
                      //                           );
                      //                           myBloc.updateStepFiveVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                           );
                      //                           myBloc.updateSelectCurrentOption(3);
                      //                           if (widget.arguments!.product.productionOptionals[myBloc.state.stepOneIndexSelect!]
                      //                               .level2[myBloc.state.stepTwoIndexSelect!].level3[index].level4.isNotEmpty) {
                      //                             myBloc.updateLastOption(4);
                      //                           } else {
                      //                             myBloc.updateLastOption(3);
                      //                           }
                      //                         }
                      //                       },
                      //                       child: Container(
                      //                         color: whitePure,
                      //                         child: Column(
                      //                           children: [
                      //                             Container(
                      //                               margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      //                               child: Row(
                      //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                                 children: [
                      //                                   Row(
                      //                                     children: [
                      //                                       SizedBox(
                      //                                         width: 24,
                      //                                         height: 24,
                      //                                         child: Radio(
                      //                                           value: widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                               .level2[prodOptState.stepTwoIndexSelect!].level3[index].label,
                      //                                           groupValue: prodOptState.stepTreeGroupValueRadio,
                      //                                           toggleable: true,
                      //                                           onChanged: (value) {
                      //                                             if (value == null) {
                      //                                               myBloc.updateStepTreeVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepTreeIndexSelect,
                      //                                               );
                      //                                               myBloc.updateStepFourVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFourIndexSelect,
                      //                                               );
                      //                                               myBloc.updateStepFiveVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                                               );
                      //                                               myBloc.updateSelectCurrentOption(2);
                      //                                               myBloc.updateLastOption(3);
                      //                                             } else {
                      //                                               myBloc.updateStepTreeVariables(
                      //                                                 groupValueRadio: value.toString(),
                      //                                                 price: widget
                      //                                                     .arguments!
                      //                                                     .product
                      //                                                     .productionOptionals[myBloc.state.stepOneIndexSelect!]
                      //                                                     .level2[myBloc.state.stepTwoIndexSelect!]
                      //                                                     .level3[index]
                      //                                                     .price,
                      //                                                 indexSelect: index,
                      //                                               );
                      //                                               myBloc.updateStepFourVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFourIndexSelect,
                      //                                               );
                      //                                               myBloc.updateStepFiveVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                                               );
                      //                                               myBloc.updateSelectCurrentOption(3);
                      //                                               if (widget
                      //                                                   .arguments!
                      //                                                   .product
                      //                                                   .productionOptionals[myBloc.state.stepOneIndexSelect!]
                      //                                                   .level2[myBloc.state.stepTwoIndexSelect!]
                      //                                                   .level3[index]
                      //                                                   .level4
                      //                                                   .isNotEmpty) {
                      //                                                 myBloc.updateLastOption(4);
                      //                                               } else {
                      //                                                 myBloc.updateLastOption(3);
                      //                                               }
                      //                                             }
                      //                                           },
                      //                                         ),
                      //                                       ),
                      //                                       widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                   .level2[prodOptState.stepTwoIndexSelect!].level3[index].image ==
                      //                                               ""
                      //                                           ? SizedBox.shrink()
                      //                                           : Row(
                      //                                               children: [
                      //                                                 SizedBox(
                      //                                                   width: 16,
                      //                                                 ),
                      //                                                 SizedBox(
                      //                                                   height: 42,
                      //                                                   child: AspectRatio(
                      //                                                     aspectRatio: 16 / 9,
                      //                                                     child: ClipRRect(
                      //                                                       borderRadius: BorderRadius.circular(4),
                      //                                                       child: FadeInImage(
                      //                                                         placeholder: AssetImage(ProductSelectOptionsConst().imgDefaultPath),
                      //                                                         image: NetworkImage(
                      //                                                           widget
                      //                                                               .arguments!
                      //                                                               .product
                      //                                                               .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                               .level2[prodOptState.stepTwoIndexSelect!]
                      //                                                               .level3[index]
                      //                                                               .image,
                      //                                                         ),
                      //                                                         fit: BoxFit.fitWidth,
                      //                                                         imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                      //                                                             ProductSelectOptionsConst().imgDefaultPath,
                      //                                                             fit: BoxFit.fitWidth),
                      //                                                       ),
                      //                                                     ),
                      //                                                   ),
                      //                                                 ),
                      //                                               ],
                      //                                             ),
                      //                                       SizedBox(width: 16),
                      //                                     ],
                      //                                   ),
                      //                                   Expanded(
                      //                                     child: Container(
                      //                                       margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      //                                       child: Text(
                      //                                           widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                               .level2[prodOptState.stepTwoIndexSelect!].level3[index].label,
                      //                                           style: AlvaStyles().bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW)),
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(width: 16),
                      //                                   Container(
                      //                                     margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                      //                                     child: Text(
                      //                                       "${widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!].level3[index].price.toDecimalFormat()} บาท",
                      //                                       style: AlvaStyles().headingSize12w400(spaceGrey),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                             // Divider
                      //                             Container(
                      //                               color: cloudSoftDeepWhite,
                      //                               width: maxWidth - 32,
                      //                               height: 1,
                      //                             )
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //                 // Another Container for additional information
                      //                 Container(
                      //                   margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     children: [
                      //                       // AlvaText based on the selected option
                      //                       prodOptState.stepTreeGroupValueRadio == ""
                      //                           ? Expanded(
                      //                               child: AlvaTextMaxLinesOverflow(
                      //                                 title:
                      //                                     "ตัวเลือก${widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!].level3[0].levelName}",
                      //                                 maxLines: 1,
                      //                                 textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite),
                      //                               ),
                      //                             )
                      //                           : Expanded(
                      //                               child: AlvaTextMaxLinesOverflow(
                      //                                   title: prodOptState.stepTreeGroupValueRadio,
                      //                                   maxLines: 1,
                      //                                   textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                      //                             ),
                      //                       // AlvaText for price
                      //                       SizedBox(width: 16),
                      //                       prodOptState.stepTreePrice == 0 && prodOptState.selectCurrentOption != 3
                      //                           ? AlvaText(
                      //                               title: ProductSelectOptionsConst().priceProdDefaultText,
                      //                               textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite),
                      //                             )
                      //                           : AlvaText(
                      //                               title: "${prodOptState.stepTreePrice!.toDecimalFormat()} บาท",
                      //                               textStyle: AlvaStyles().bodySize16W600(blackGoMunTo),
                      //                             ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      // prodOptState.stepTreeGroupValueRadio == "" ||
                      //         widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!]
                      //             .level3[prodOptState.stepTreeIndexSelect!].level4.isEmpty
                      //     ? Container()
                      //     : Column(
                      //         children: [
                      //           // First Container
                      //           Container(
                      //             color: cloudyWhite,
                      //             width: maxWidth,
                      //             padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 SizedBox(
                      //                   width: maxWidth - 32,
                      //                   child: AlvaTextMaxLinesOverflow(
                      //                       title: widget
                      //                           .arguments!
                      //                           .product
                      //                           .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                           .level2[prodOptState.stepTwoIndexSelect!]
                      //                           .level3[prodOptState.stepTreeIndexSelect!]
                      //                           .level4[0]
                      //                           .levelName,
                      //                       maxLines: 1,
                      //                       textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           // Second Container
                      //           Container(
                      //             color: whitePure,
                      //             child: Column(
                      //               children: [
                      //                 ListView.builder(
                      //                   shrinkWrap: true,
                      //                   physics: NeverScrollableScrollPhysics(),
                      //                   itemCount: widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                       .level2[prodOptState.stepTwoIndexSelect!].level3[prodOptState.stepTreeIndexSelect!].level4.length,
                      //                   itemBuilder: (BuildContext context, int index) {
                      //                     return GestureDetector(
                      //                       onTap: () {
                      //                         if (prodOptState.stepFourGroupValueRadio ==
                      //                             widget
                      //                                 .arguments!
                      //                                 .product
                      //                                 .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                 .level2[prodOptState.stepTwoIndexSelect!]
                      //                                 .level3[prodOptState.stepTreeIndexSelect!]
                      //                                 .level4[index]
                      //                                 .label) {
                      //                           myBloc.updateStepFourVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFourIndexSelect,
                      //                           );
                      //                           myBloc.updateStepFiveVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                           );
                      //                           myBloc.updateSelectCurrentOption(3);
                      //                           myBloc.updateLastOption(4);
                      //                         } else {
                      //                           myBloc.updateStepFourVariables(
                      //                             groupValueRadio: widget
                      //                                 .arguments!
                      //                                 .product
                      //                                 .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                 .level2[prodOptState.stepTwoIndexSelect!]
                      //                                 .level3[prodOptState.stepTreeIndexSelect!]
                      //                                 .level4[index]
                      //                                 .label,
                      //                             price: widget
                      //                                 .arguments!
                      //                                 .product
                      //                                 .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                 .level2[prodOptState.stepTwoIndexSelect!]
                      //                                 .level3[prodOptState.stepTreeIndexSelect!]
                      //                                 .level4[index]
                      //                                 .price,
                      //                             indexSelect: index,
                      //                           );
                      //                           myBloc.updateStepFiveVariables(
                      //                             groupValueRadio: "",
                      //                             price: myBloc.state.stepFivePrice,
                      //                             indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                           );
                      //                           myBloc.updateSelectCurrentOption(4);
                      //                           if (widget
                      //                               .arguments!
                      //                               .product
                      //                               .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                               .level2[prodOptState.stepTwoIndexSelect!]
                      //                               .level3[prodOptState.stepTreeIndexSelect!]
                      //                               .level4[index]
                      //                               .level5
                      //                               .isNotEmpty) {
                      //                             myBloc.updateLastOption(5);
                      //                           } else {
                      //                             myBloc.updateLastOption(4);
                      //                           }
                      //                         }
                      //                       },
                      //                       child: Container(
                      //                         color: whitePure,
                      //                         child: Column(
                      //                           children: [
                      //                             // Nested Container inside ListView.builder
                      //                             Container(
                      //                               margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      //                               child: Row(
                      //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                                 children: [
                      //                                   // Row with Radio, SizedBox, AlvaText
                      //                                   Row(
                      //                                     children: [
                      //                                       SizedBox(
                      //                                         width: 24,
                      //                                         height: 24,
                      //                                         child: Radio(
                      //                                           value: widget
                      //                                               .arguments!
                      //                                               .product
                      //                                               .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                               .level2[prodOptState.stepTwoIndexSelect!]
                      //                                               .level3[prodOptState.stepTreeIndexSelect!]
                      //                                               .level4[index]
                      //                                               .label,
                      //                                           groupValue: prodOptState.stepFourGroupValueRadio,
                      //                                           toggleable: true,
                      //                                           onChanged: (value) {
                      //                                             // Radio onChanged logic
                      //                                             if (value == null) {
                      //                                               myBloc.updateStepFourVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFourIndexSelect,
                      //                                               );
                      //                                               myBloc.updateStepFiveVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                                               );
                      //                                               myBloc.updateSelectCurrentOption(3);
                      //                                               myBloc.updateLastOption(4);
                      //                                             } else {
                      //                                               myBloc.updateStepFourVariables(
                      //                                                 groupValueRadio: value.toString(),
                      //                                                 price: widget
                      //                                                     .arguments!
                      //                                                     .product
                      //                                                     .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                     .level2[prodOptState.stepTwoIndexSelect!]
                      //                                                     .level3[prodOptState.stepTreeIndexSelect!]
                      //                                                     .level4[index]
                      //                                                     .price,
                      //                                                 indexSelect: index,
                      //                                               );
                      //                                               myBloc.updateStepFiveVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: myBloc.state.stepFivePrice,
                      //                                                 indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                                               );
                      //                                               myBloc.updateSelectCurrentOption(4);
                      //                                               if (widget
                      //                                                   .arguments!
                      //                                                   .product
                      //                                                   .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                   .level2[prodOptState.stepTwoIndexSelect!]
                      //                                                   .level3[prodOptState.stepTreeIndexSelect!]
                      //                                                   .level4[index]
                      //                                                   .level5
                      //                                                   .isNotEmpty) {
                      //                                                 myBloc.updateLastOption(5);
                      //                                               } else {
                      //                                                 myBloc.updateLastOption(4);
                      //                                               }
                      //                                             }
                      //                                           },
                      //                                         ),
                      //                                       ),
                      //                                       widget
                      //                                                   .arguments!
                      //                                                   .product
                      //                                                   .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                   .level2[prodOptState.stepTwoIndexSelect!]
                      //                                                   .level3[prodOptState.stepTreeIndexSelect!]
                      //                                                   .level4[index]
                      //                                                   .image ==
                      //                                               ""
                      //                                           ? SizedBox.shrink()
                      //                                           : Row(
                      //                                               children: [
                      //                                                 SizedBox(
                      //                                                   width: 16,
                      //                                                 ),
                      //                                                 SizedBox(
                      //                                                   height: 42,
                      //                                                   child: AspectRatio(
                      //                                                     aspectRatio: 16 / 9,
                      //                                                     child: ClipRRect(
                      //                                                       borderRadius: BorderRadius.circular(4),
                      //                                                       child: FadeInImage(
                      //                                                         placeholder: AssetImage(ProductSelectOptionsConst().imgDefaultPath),
                      //                                                         // Replace with your placeholder image path
                      //                                                         image: NetworkImage(
                      //                                                           widget
                      //                                                               .arguments!
                      //                                                               .product
                      //                                                               .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                               .level2[prodOptState.stepTwoIndexSelect!]
                      //                                                               .level3[prodOptState.stepTreeIndexSelect!]
                      //                                                               .level4[index]
                      //                                                               .image,
                      //                                                         ),
                      //                                                         fit: BoxFit.fitWidth,
                      //                                                         imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                      //                                                             ProductSelectOptionsConst().imgDefaultPath,
                      //                                                             fit: BoxFit.fitWidth),
                      //                                                       ),
                      //                                                     ),
                      //                                                   ),
                      //                                                 ),
                      //                                               ],
                      //                                             ),
                      //                                       SizedBox(
                      //                                         width: 16,
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                   // SizedBox, AlvaText for price
                      //                                   Expanded(
                      //                                     child: Container(
                      //                                       margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      //                                       child: Text(
                      //                                           widget
                      //                                               .arguments!
                      //                                               .product
                      //                                               .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                               .level2[prodOptState.stepTwoIndexSelect!]
                      //                                               .level3[prodOptState.stepTreeIndexSelect!]
                      //                                               .level4[index]
                      //                                               .label,
                      //                                           style: AlvaStyles().bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW)),
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(width: 16),
                      //                                   Container(
                      //                                     margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                      //                                     child: Text(
                      //                                       "${widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!].level3[prodOptState.stepTreeIndexSelect!].level4[index].price.toDecimalFormat()} บาท",
                      //                                       style: AlvaStyles().headingSize12w400(spaceGrey),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                             // Divider
                      //                             Container(
                      //                               color: cloudSoftDeepWhite,
                      //                               width: maxWidth - 32,
                      //                               height: 1,
                      //                             )
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //                 // Another Container for additional information
                      //                 Container(
                      //                   margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     children: [
                      //                       // AlvaText based on the selected option
                      //                       prodOptState.stepFourGroupValueRadio == ""
                      //                           ? Expanded(
                      //                               child: AlvaTextMaxLinesOverflow(
                      //                                 title:
                      //                                     "ตัวเลือก${widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!].level3[prodOptState.stepTreeIndexSelect!].level4[0].levelName}",
                      //                                 maxLines: 1,
                      //                                 textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite),
                      //                               ),
                      //                             )
                      //                           : Expanded(
                      //                               child: AlvaTextMaxLinesOverflow(
                      //                                   title: prodOptState.stepFourGroupValueRadio,
                      //                                   maxLines: 1,
                      //                                   textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                      //                             ),
                      //                       // AlvaText for price
                      //                       SizedBox(width: 16),
                      //                       prodOptState.stepFourPrice == 0 && prodOptState.selectCurrentOption != 4
                      //                           ? AlvaText(
                      //                               title: ProductSelectOptionsConst().priceProdDefaultText,
                      //                               textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite),
                      //                             )
                      //                           : AlvaText(
                      //                               title: "${prodOptState.stepFourPrice!.toDecimalFormat()} บาท",
                      //                               textStyle: AlvaStyles().bodySize16W600(blackGoMunTo),
                      //                             ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      // prodOptState.stepFourGroupValueRadio == "" ||
                      //         widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!]
                      //             .level3[prodOptState.stepTreeIndexSelect!].level4[prodOptState.stepFourIndexSelect!].level5.isEmpty
                      //     ? Container()
                      //     : Column(
                      //         children: [
                      //           // First Container
                      //           Container(
                      //             color: cloudyWhite,
                      //             width: maxWidth,
                      //             padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 SizedBox(
                      //                   width: maxWidth - 32,
                      //                   child: AlvaTextMaxLinesOverflow(
                      //                       title: widget
                      //                           .arguments!
                      //                           .product
                      //                           .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                           .level2[prodOptState.stepTwoIndexSelect!]
                      //                           .level3[prodOptState.stepTreeIndexSelect!]
                      //                           .level4[prodOptState.stepFourIndexSelect!]
                      //                           .level5[0]
                      //                           .levelName,
                      //                       maxLines: 1,
                      //                       textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           // Second Container
                      //           Container(
                      //             color: whitePure,
                      //             child: Column(
                      //               children: [
                      //                 // ListView.builder
                      //                 ListView.builder(
                      //                   shrinkWrap: true,
                      //                   physics: NeverScrollableScrollPhysics(),
                      //                   itemCount: widget
                      //                       .arguments!
                      //                       .product
                      //                       .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                       .level2[prodOptState.stepTwoIndexSelect!]
                      //                       .level3[prodOptState.stepTreeIndexSelect!]
                      //                       .level4[prodOptState.stepFourIndexSelect!]
                      //                       .level5
                      //                       .length,
                      //                   itemBuilder: (BuildContext context, int index) {
                      //                     return GestureDetector(
                      //                       onTap: () {
                      //                         if (prodOptState.stepFiveGroupValueRadio ==
                      //                             widget
                      //                                 .arguments!
                      //                                 .product
                      //                                 .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                 .level2[prodOptState.stepTwoIndexSelect!]
                      //                                 .level3[prodOptState.stepTreeIndexSelect!]
                      //                                 .level4[prodOptState.stepFourIndexSelect!]
                      //                                 .level5[index]
                      //                                 .label) {
                      //                           myBloc.updateStepFiveVariables(
                      //                             groupValueRadio: "",
                      //                             price: 0,
                      //                             indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                           );
                      //                           myBloc.updateSelectCurrentOption(4);
                      //                           myBloc.updateLastOption(5);
                      //                         } else {
                      //                           myBloc.updateStepFiveVariables(
                      //                             groupValueRadio: widget
                      //                                 .arguments!
                      //                                 .product
                      //                                 .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                 .level2[prodOptState.stepTwoIndexSelect!]
                      //                                 .level3[prodOptState.stepTreeIndexSelect!]
                      //                                 .level4[prodOptState.stepFourIndexSelect!]
                      //                                 .level5[index]
                      //                                 .label,
                      //                             price: widget
                      //                                 .arguments!
                      //                                 .product
                      //                                 .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                 .level2[prodOptState.stepTwoIndexSelect!]
                      //                                 .level3[prodOptState.stepTreeIndexSelect!]
                      //                                 .level4[prodOptState.stepFourIndexSelect!]
                      //                                 .level5[index]
                      //                                 .price,
                      //                             indexSelect: index,
                      //                           );
                      //                           myBloc.updateSelectCurrentOption(5);
                      //                           myBloc.updateLastOption(5);
                      //                         }
                      //                       },
                      //                       child: Container(
                      //                         color: whitePure,
                      //                         child: Column(
                      //                           children: [
                      //                             // Nested Container inside ListView.builder
                      //                             Container(
                      //                               margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      //                               child: Row(
                      //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                                 children: [
                      //                                   // Row with Radio, SizedBox, AlvaText
                      //                                   Row(
                      //                                     children: [
                      //                                       SizedBox(
                      //                                         width: 24,
                      //                                         height: 24,
                      //                                         child: Radio(
                      //                                           value: widget
                      //                                               .arguments!
                      //                                               .product
                      //                                               .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                               .level2[prodOptState.stepTwoIndexSelect!]
                      //                                               .level3[prodOptState.stepTreeIndexSelect!]
                      //                                               .level4[prodOptState.stepFourIndexSelect!]
                      //                                               .level5[index]
                      //                                               .label,
                      //                                           groupValue: prodOptState.stepFiveGroupValueRadio,
                      //                                           toggleable: true,
                      //                                           onChanged: (value) {
                      //                                             // Radio onChanged logic
                      //                                             if (value == null) {
                      //                                               myBloc.updateStepFiveVariables(
                      //                                                 groupValueRadio: "",
                      //                                                 price: 0,
                      //                                                 indexSelect: myBloc.state.stepFiveIndexSelect,
                      //                                               );
                      //                                               myBloc.updateSelectCurrentOption(4);
                      //                                               myBloc.updateLastOption(5);
                      //                                             } else {
                      //                                               myBloc.updateStepFiveVariables(
                      //                                                 groupValueRadio: value.toString(),
                      //                                                 price: widget
                      //                                                     .arguments!
                      //                                                     .product
                      //                                                     .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                     .level2[prodOptState.stepTwoIndexSelect!]
                      //                                                     .level3[prodOptState.stepTreeIndexSelect!]
                      //                                                     .level4[prodOptState.stepFourIndexSelect!]
                      //                                                     .level5[index]
                      //                                                     .price,
                      //                                                 indexSelect: index,
                      //                                               );
                      //                                               myBloc.updateSelectCurrentOption(5);
                      //                                               myBloc.updateLastOption(5);
                      //                                             }
                      //                                           },
                      //                                         ),
                      //                                       ),
                      //                                       widget
                      //                                                   .arguments!
                      //                                                   .product
                      //                                                   .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                   .level2[prodOptState.stepTwoIndexSelect!]
                      //                                                   .level3[prodOptState.stepTreeIndexSelect!]
                      //                                                   .level4[prodOptState.stepFourIndexSelect!]
                      //                                                   .level5[index]
                      //                                                   .image ==
                      //                                               ""
                      //                                           ? SizedBox.shrink()
                      //                                           : Row(
                      //                                               children: [
                      //                                                 SizedBox(
                      //                                                   width: 16,
                      //                                                 ),
                      //                                                 SizedBox(
                      //                                                   height: 42,
                      //                                                   child: AspectRatio(
                      //                                                     aspectRatio: 16 / 9,
                      //                                                     child: ClipRRect(
                      //                                                       borderRadius: BorderRadius.circular(4),
                      //                                                       child: FadeInImage(
                      //                                                         placeholder: AssetImage(ProductSelectOptionsConst().imgDefaultPath),
                      //                                                         // Replace with your placeholder image path
                      //                                                         image: NetworkImage(
                      //                                                           widget
                      //                                                               .arguments!
                      //                                                               .product
                      //                                                               .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                                               .level2[prodOptState.stepTwoIndexSelect!]
                      //                                                               .level3[prodOptState.stepTreeIndexSelect!]
                      //                                                               .level4[prodOptState.stepFourIndexSelect!]
                      //                                                               .level5[index]
                      //                                                               .image,
                      //                                                         ),
                      //                                                         fit: BoxFit.fitWidth,
                      //                                                         imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                      //                                                             ProductSelectOptionsConst().imgDefaultPath,
                      //                                                             fit: BoxFit.fitWidth),
                      //                                                       ),
                      //                                                     ),
                      //                                                   ),
                      //                                                 ),
                      //                                               ],
                      //                                             ),
                      //                                       SizedBox(
                      //                                         width: 16,
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                   // SizedBox, AlvaText for price
                      //                                   Expanded(
                      //                                     child: Container(
                      //                                       margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      //                                       child: Text(
                      //                                           widget
                      //                                               .arguments!
                      //                                               .product
                      //                                               .productionOptionals[prodOptState.stepOneIndexSelect!]
                      //                                               .level2[prodOptState.stepTwoIndexSelect!]
                      //                                               .level3[prodOptState.stepTreeIndexSelect!]
                      //                                               .level4[prodOptState.stepFourIndexSelect!]
                      //                                               .level5[index]
                      //                                               .label,
                      //                                           style: AlvaStyles().bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW)),
                      //                                     ),
                      //                                   ),
                      //                                   SizedBox(width: 16),
                      //                                   Container(
                      //                                     margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                      //                                     child: Text(
                      //                                       "${widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!].level3[prodOptState.stepTreeIndexSelect!].level4[prodOptState.stepFourIndexSelect!].level5[index].price.toDecimalFormat()} บาท",
                      //                                       style: AlvaStyles().headingSize12w400(spaceGrey),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                             // Divider
                      //                             Container(
                      //                               color: cloudSoftDeepWhite,
                      //                               width: maxWidth - 32,
                      //                               height: 1,
                      //                             )
                      //                           ],
                      //                         ),
                      //                       ),
                      //                     );
                      //                   },
                      //                 ),
                      //                 // Another Container for additional information
                      //                 Container(
                      //                   margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                     children: [
                      //                       // AlvaText based on the selected option
                      //                       prodOptState.stepFiveGroupValueRadio == ""
                      //                           ? Expanded(
                      //                               child: AlvaTextMaxLinesOverflow(
                      //                                 title:
                      //                                     "ตัวเลือก${widget.arguments!.product.productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!].level3[prodOptState.stepTreeIndexSelect!].level4[prodOptState.stepFourIndexSelect!].level5[0].levelName}",
                      //                                 maxLines: 1,
                      //                                 textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite),
                      //                               ),
                      //                             )
                      //                           : Expanded(
                      //                               child: AlvaTextMaxLinesOverflow(
                      //                                   title: prodOptState.stepFiveGroupValueRadio,
                      //                                   maxLines: 1,
                      //                                   textStyle: AlvaStyles().bodySize16W600(blackGoMunTo))),
                      //
                      //                       // AlvaText for price
                      //                       SizedBox(width: 16),
                      //                       prodOptState.stepFivePrice == 0 && prodOptState.selectCurrentOption != 5
                      //                           ? AlvaText(
                      //                               title: ProductSelectOptionsConst().priceProdDefaultText,
                      //                               textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite),
                      //                             )
                      //                           : AlvaText(
                      //                               title: "${prodOptState.stepFivePrice!.toDecimalFormat()} บาท",
                      //                               textStyle: AlvaStyles().bodySize16W600(blackGoMunTo),
                      //                             ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      SizedBox(
                        height: 96,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
