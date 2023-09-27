import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/extension/number_converter.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_options/product_options_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';

class ProductSelectOptions extends StatefulWidget {
  const ProductSelectOptions({Key? key}) : super(key: key);

  @override
  State<ProductSelectOptions> createState() => _ProductSelectOptionsState();
}

class _ProductSelectOptionsState extends State<ProductSelectOptions> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ProductListBloc>().add(GetProductListMock(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myBloc = BlocProvider.of<ProductOptionBloc>(context);
    return BlocBuilder<ProductOptionBloc, ProductOptionState>(
      builder: (context, prodOptState) {
        return RootPageCondition(
          child: AlvaRootWidget(
            titlePage: titleWebPage,
            bottomSheet: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 96,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 48,
                      child: prodOptState.selectCurrentOption == prodOptState.lastOption
                          ? OutlinedButton(
                              onPressed: () {},
                              style: AlvaStyles().outlineNoneBorderButtonStyle(YellowKrungsri, Colors.transparent),
                              child: AlvaText(
                                  title: "ดำเนินการต่อ",
                                  textStyle: AlvaStyles().headingSize16w700(BTN_SELECTED_TEXT_COLOR_NEW)),
                            )
                          : OutlinedButton(
                              onPressed: () {},
                              style: AlvaStyles().outlineNoneBorderButtonStyle(cloudSoftDeepWhite, Colors.transparent),
                              child:
                                  AlvaText(title: "ดำเนินการต่อ", textStyle: AlvaStyles().headingSize16w700(smockGrey)),
                            ),
                    ),
                  )
                ],
              ),
            ),
            appBar: AppBar(
              title: AlvaText(
                  title: "ตัวเลือกสินค้า", textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
              titleSpacing: 0,
              leadingWidth: 60,
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  key: const Key("pop_navigator_to_home_page"), onPressed: () {}, icon: const Icon(Icons.arrow_back)),
            ),
            child: Container(
              color: cloudyWhite,
              child: BlocBuilder<ProductListBloc, ProductListState>(
                builder: (context, state) {
                  if (state.productListStatus == GetProductListStatus.success) {
                    return ListView(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 32,
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: AlvaText(
                                title: state.productList.products![0].productionOptionals[0].levelName,
                                textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW),
                              ),
                            ),
                            Container(
                              color: whitePure,
                              child: Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: state.productList.products![0].productionOptionals.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                              // cloudSoftDeepWhite
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 24,
                                                        height: 24,
                                                        child: Radio(
                                                          value: state.productList.products![0]
                                                              .productionOptionals[index].label,
                                                          groupValue: prodOptState.stepOneGroupValueRadio,
                                                          toggleable: true,
                                                          onChanged: (value) {
                                                            if (value == null) {
                                                              myBloc.updateStepOneVariables(
                                                                groupValueRadio: "",
                                                                price: null,
                                                                indexSelect: myBloc.state.stepOneIndexSelect,
                                                              );
                                                              myBloc.updateStepTwoVariables(
                                                                groupValueRadio: "",
                                                                price: null,
                                                                indexSelect: myBloc.state.stepTwoIndexSelect,
                                                              );
                                                              myBloc.updateStepTreeVariables(
                                                                groupValueRadio: "",
                                                                price: null,
                                                                indexSelect: myBloc.state.stepTreeIndexSelect,
                                                              );
                                                              myBloc.updateStepFourVariables(
                                                                groupValueRadio: "",
                                                                price: null,
                                                                indexSelect: myBloc.state.stepFourIndexSelect,
                                                              );
                                                              myBloc.updateStepFiveVariables(
                                                                groupValueRadio: "",
                                                                price: null,
                                                                indexSelect: myBloc.state.stepFiveIndexSelect,
                                                              );
                                                              myBloc.updateSelectCurrentOption(0);
                                                              myBloc.updateLastOption(1);
                                                            } else {
                                                              myBloc.updateStepOneVariables(
                                                                groupValueRadio: value.toString(),
                                                                price: state.productList.products![0]
                                                                    .productionOptionals[index].price,
                                                                indexSelect: index,
                                                              );
                                                              myBloc.updateStepTwoVariables(
                                                                groupValueRadio: "",
                                                                price: myBloc.state.stepTwoPrice,
                                                                indexSelect: myBloc.state.stepTwoIndexSelect,
                                                              );
                                                              myBloc.updateStepTreeVariables(
                                                                groupValueRadio: "",
                                                                price: myBloc.state.stepTreePrice,
                                                                indexSelect: myBloc.state.stepTreeIndexSelect,
                                                              );
                                                              myBloc.updateStepFourVariables(
                                                                groupValueRadio: "",
                                                                price: myBloc.state.stepFourPrice,
                                                                indexSelect: myBloc.state.stepFourIndexSelect,
                                                              );
                                                              myBloc.updateStepFiveVariables(
                                                                groupValueRadio: "",
                                                                price: myBloc.state.stepFivePrice,
                                                                indexSelect: myBloc.state.stepFiveIndexSelect,
                                                              );
                                                              myBloc.updateSelectCurrentOption(1);
                                                              if (state.productList.products![0]
                                                                  .productionOptionals[index].level2.isNotEmpty) {
                                                                myBloc.updateLastOption(2);
                                                              } else {
                                                                myBloc.updateLastOption(1);
                                                              }
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      SizedBox(
                                                        height: 42,
                                                        child: AspectRatio(
                                                          aspectRatio: 16 / 9,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(4),
                                                            child: Image.network(
                                                              state.productList.products![0].productionAssets[index]
                                                                  .substring(46),
                                                              fit: BoxFit.fitWidth,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      AlvaText(
                                                          title: state.productList.products![0]
                                                              .productionOptionals[index].label,
                                                          textStyle:
                                                              AlvaStyles().bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 16,
                                                  ),
                                                  AlvaText(
                                                      title:
                                                          "${state.productList.products![0].productionOptionals[index].price.toDecimalFormat()} บาท",
                                                      textStyle: AlvaStyles().headingSize12w400(spaceGrey)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: cloudSoftDeepWhite,
                                              width: MediaQuery.of(context).size.width - 32,
                                              height: 1,
                                            )
                                          ],
                                        );
                                      }),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                    // cloudSoftDeepWhite
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        prodOptState.stepOneGroupValueRadio == ""
                                            ? AlvaText(
                                                title: "ตัวเลือกสี",
                                                textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                                            : AlvaText(
                                                title: prodOptState.stepOneGroupValueRadio,
                                                textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                                        prodOptState.stepOnePrice == null
                                            ? AlvaText(
                                                title: "0 บาท",
                                                textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                                            : AlvaText(
                                                title: "${prodOptState.stepOnePrice!.toDecimalFormat()} บาท",
                                                textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        prodOptState.stepOneGroupValueRadio == "" ||
                                state.productList.products![0].productionOptionals[prodOptState.stepOneIndexSelect!]
                                    .level2.isEmpty
                            ? Container()
                            : Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 32,
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: AlvaText(
                                      title: state.productList.products![0]
                                          .productionOptionals[prodOptState.stepOneIndexSelect!].level2[0].levelName,
                                      textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW),
                                    ),
                                  ),
                                  Container(
                                    color: whitePure,
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: state.productList.products![0]
                                                .productionOptionals[prodOptState.stepOneIndexSelect!].level2.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                                    // cloudSoftDeepWhite
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 24,
                                                              height: 24,
                                                              child: Radio(
                                                                value: state
                                                                    .productList
                                                                    .products![0]
                                                                    .productionOptionals[
                                                                        prodOptState.stepOneIndexSelect!]
                                                                    .level2[index]
                                                                    .label,
                                                                groupValue: prodOptState.stepTwoGroupValueRadio,
                                                                toggleable: true,
                                                                onChanged: (value) {
                                                                  if (value == null) {
                                                                    myBloc.updateStepTwoVariables(
                                                                      groupValueRadio: "",
                                                                      price: null,
                                                                      indexSelect: myBloc.state.stepTwoIndexSelect,
                                                                    );
                                                                    myBloc.updateStepTreeVariables(
                                                                      groupValueRadio: "",
                                                                      price: null,
                                                                      indexSelect: myBloc.state.stepTreeIndexSelect,
                                                                    );
                                                                    myBloc.updateStepFourVariables(
                                                                      groupValueRadio: "",
                                                                      price: null,
                                                                      indexSelect: myBloc.state.stepFourIndexSelect,
                                                                    );
                                                                    myBloc.updateStepFiveVariables(
                                                                      groupValueRadio: "",
                                                                      price: null,
                                                                      indexSelect: myBloc.state.stepFiveIndexSelect,
                                                                    );
                                                                    // myBloc.updateSelectCurrentOption(1);
                                                                    myBloc.updateLastOption(1);
                                                                  } else {
                                                                    myBloc.updateStepTwoVariables(
                                                                      groupValueRadio: value.toString(),
                                                                      price: state
                                                                          .productList
                                                                          .products![0]
                                                                          .productionOptionals[
                                                                              myBloc.state.stepOneIndexSelect!]
                                                                          .level2[index]
                                                                          .price,
                                                                      indexSelect: index,
                                                                    );
                                                                    myBloc.updateStepTreeVariables(
                                                                      groupValueRadio: "",
                                                                      price: myBloc.state.stepTreePrice,
                                                                      indexSelect: myBloc.state.stepTreeIndexSelect,
                                                                    );
                                                                    myBloc.updateStepFourVariables(
                                                                      groupValueRadio: "",
                                                                      price: myBloc.state.stepFourPrice,
                                                                      indexSelect: myBloc.state.stepFourIndexSelect,
                                                                    );
                                                                    myBloc.updateStepFiveVariables(
                                                                      groupValueRadio: "",
                                                                      price: myBloc.state.stepFivePrice,
                                                                      indexSelect: myBloc.state.stepFiveIndexSelect,
                                                                    );
                                                                    myBloc.updateSelectCurrentOption(2);
                                                                    if (state
                                                                        .productList
                                                                        .products![0]
                                                                        .productionOptionals[
                                                                            myBloc.state.stepOneIndexSelect!]
                                                                        .level2[index]
                                                                        .level3
                                                                        .isNotEmpty) {
                                                                      myBloc.updateLastOption(3);
                                                                    } else {
                                                                      myBloc.updateLastOption(2);
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            AlvaText(
                                                                title: state
                                                                    .productList
                                                                    .products![0]
                                                                    .productionOptionals[
                                                                        prodOptState.stepOneIndexSelect!]
                                                                    .level2[index]
                                                                    .label,
                                                                textStyle: AlvaStyles()
                                                                    .bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW)),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        AlvaText(
                                                            title:
                                                                "${state.productList.products![0].productionOptionals[prodOptState.stepOneIndexSelect!].level2[index].price.toDecimalFormat()} บาท",
                                                            textStyle: AlvaStyles().headingSize12w400(spaceGrey)),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    color: cloudSoftDeepWhite,
                                                    width: MediaQuery.of(context).size.width - 32,
                                                    height: 1,
                                                  )
                                                ],
                                              );
                                            }),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                          // cloudSoftDeepWhite
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              prodOptState.stepTwoGroupValueRadio == ""
                                                  ? AlvaText(
                                                      title: "ตัวเลือกสี",
                                                      textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                                                  : AlvaText(
                                                      title: prodOptState.stepTwoGroupValueRadio,
                                                      textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                                              prodOptState.stepTwoPrice == null
                                                  ? AlvaText(
                                                      title: "0 บาท",
                                                      textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                                                  : AlvaText(
                                                      title: "${prodOptState.stepTwoPrice!.toDecimalFormat()} บาท",
                                                      textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        prodOptState.stepTwoGroupValueRadio == "" ||
                                state.productList.products![0].productionOptionals[prodOptState.stepOneIndexSelect!]
                                    .level2[prodOptState.stepTwoIndexSelect!].level3.isEmpty
                            ? Container()
                            : Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 32,
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: AlvaText(
                                      title: state
                                          .productList
                                          .products![0]
                                          .productionOptionals[prodOptState.stepOneIndexSelect!]
                                          .level2[prodOptState.stepTwoIndexSelect!]
                                          .level3[0]
                                          .levelName,
                                      textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW),
                                    ),
                                  ),
                                  Container(
                                    color: whitePure,
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                .productList
                                                .products![0]
                                                .productionOptionals[prodOptState.stepOneIndexSelect!]
                                                .level2[prodOptState.stepTwoIndexSelect!]
                                                .level3
                                                .length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                                    // cloudSoftDeepWhite
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 24,
                                                              height: 24,
                                                              child: Radio(
                                                                value: state
                                                                    .productList
                                                                    .products![0]
                                                                    .productionOptionals[
                                                                        prodOptState.stepOneIndexSelect!]
                                                                    .level2[prodOptState.stepTwoIndexSelect!]
                                                                    .level3[index]
                                                                    .label,
                                                                groupValue: prodOptState.stepTreeGroupValueRadio,
                                                                toggleable: true,
                                                                onChanged: (value) {
                                                                  if (value == null) {
                                                                    myBloc.updateStepTreeVariables(
                                                                      groupValueRadio: "",
                                                                      price: null,
                                                                      indexSelect: myBloc.state.stepTreeIndexSelect,
                                                                    );
                                                                    myBloc.updateStepFourVariables(
                                                                      groupValueRadio: "",
                                                                      price: null,
                                                                      indexSelect: myBloc.state.stepFourIndexSelect,
                                                                    );
                                                                    myBloc.updateStepFiveVariables(
                                                                      groupValueRadio: "",
                                                                      price: null,
                                                                      indexSelect: myBloc.state.stepFiveIndexSelect,
                                                                    );
                                                                    // myBloc.updateSelectCurrentOption(2);
                                                                    myBloc.updateLastOption(2);
                                                                  } else {
                                                                    myBloc.updateStepTreeVariables(
                                                                      groupValueRadio: value.toString(),
                                                                      price: state
                                                                          .productList
                                                                          .products![0]
                                                                          .productionOptionals[
                                                                              myBloc.state.stepOneIndexSelect!]
                                                                          .level2[myBloc.state.stepTwoIndexSelect!]
                                                                          .level3[index]
                                                                          .price,
                                                                      indexSelect: index,
                                                                    );
                                                                    myBloc.updateStepFourVariables(
                                                                      groupValueRadio: "",
                                                                      price: myBloc.state.stepFourPrice,
                                                                      indexSelect: myBloc.state.stepFourIndexSelect,
                                                                    );
                                                                    myBloc.updateStepFiveVariables(
                                                                      groupValueRadio: "",
                                                                      price: myBloc.state.stepFivePrice,
                                                                      indexSelect: myBloc.state.stepFiveIndexSelect,
                                                                    );
                                                                    myBloc.updateSelectCurrentOption(3);
                                                                    if (state
                                                                        .productList
                                                                        .products![0]
                                                                        .productionOptionals[
                                                                            myBloc.state.stepOneIndexSelect!]
                                                                        .level2[myBloc.state.stepTwoIndexSelect!]
                                                                        .level3[index]
                                                                        .level4
                                                                        .isNotEmpty) {
                                                                      myBloc.updateLastOption(4);
                                                                    } else {
                                                                      myBloc.updateLastOption(3);
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            AlvaText(
                                                                title: state
                                                                    .productList
                                                                    .products![0]
                                                                    .productionOptionals[
                                                                        prodOptState.stepOneIndexSelect!]
                                                                    .level2[prodOptState.stepTwoIndexSelect!]
                                                                    .level3[index]
                                                                    .label,
                                                                textStyle: AlvaStyles()
                                                                    .bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW)),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        AlvaText(
                                                            title:
                                                                "${state.productList.products![0].productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!].level3[index].price.toDecimalFormat()} บาท",
                                                            textStyle: AlvaStyles().headingSize12w400(spaceGrey)),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    color: cloudSoftDeepWhite,
                                                    width: MediaQuery.of(context).size.width - 32,
                                                    height: 1,
                                                  )
                                                ],
                                              );
                                            }),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                          // cloudSoftDeepWhite
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              prodOptState.stepTreeGroupValueRadio == ""
                                                  ? AlvaText(
                                                      title: "ตัวเลือกสี",
                                                      textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                                                  : AlvaText(
                                                      title: prodOptState.stepTreeGroupValueRadio,
                                                      textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                                              prodOptState.stepTreePrice == null
                                                  ? AlvaText(
                                                      title: "0 บาท",
                                                      textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                                                  : AlvaText(
                                                      title: "${prodOptState.stepTreePrice!.toDecimalFormat()} บาท",
                                                      textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        prodOptState.stepTreeGroupValueRadio == "" ||
                                state
                                    .productList
                                    .products![0]
                                    .productionOptionals[prodOptState.stepOneIndexSelect!]
                                    .level2[prodOptState.stepTwoIndexSelect!]
                                    .level3[prodOptState.stepTreeIndexSelect!]
                                    .level4
                                    .isEmpty
                            ? Container()
                            : Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 32,
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: AlvaText(
                                      title: state
                                          .productList
                                          .products![0]
                                          .productionOptionals[prodOptState.stepOneIndexSelect!]
                                          .level2[prodOptState.stepTwoIndexSelect!]
                                          .level3[prodOptState.stepTreeIndexSelect!]
                                          .level4[0]
                                          .levelName,
                                      textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW),
                                    ),
                                  ),
                                  Container(
                                    color: whitePure,
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                .productList
                                                .products![0]
                                                .productionOptionals[prodOptState.stepOneIndexSelect!]
                                                .level2[prodOptState.stepTwoIndexSelect!]
                                                .level3[prodOptState.stepTreeIndexSelect!]
                                                .level4
                                                .length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                                    // cloudSoftDeepWhite
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 24,
                                                              height: 24,
                                                              child: Radio(
                                                                value: state
                                                                    .productList
                                                                    .products![0]
                                                                    .productionOptionals[
                                                                        prodOptState.stepOneIndexSelect!]
                                                                    .level2[prodOptState.stepTwoIndexSelect!]
                                                                    .level3[prodOptState.stepTreeIndexSelect!]
                                                                    .level4[index]
                                                                    .label,
                                                                groupValue: prodOptState.stepFourGroupValueRadio,
                                                                toggleable: true,
                                                                onChanged: (value) {
                                                                  if (value == null) {
                                                                    myBloc.updateStepFourVariables(
                                                                      groupValueRadio: "",
                                                                      price: null,
                                                                      indexSelect: myBloc.state.stepFourIndexSelect,
                                                                    );
                                                                    myBloc.updateStepFiveVariables(
                                                                      groupValueRadio: "",
                                                                      price: null,
                                                                      indexSelect: myBloc.state.stepFiveIndexSelect,
                                                                    );
                                                                    // myBloc.updateSelectCurrentOption(3);
                                                                    myBloc.updateLastOption(3);
                                                                  } else {
                                                                    myBloc.updateStepFourVariables(
                                                                      groupValueRadio: value.toString(),
                                                                      price: state
                                                                          .productList
                                                                          .products![0]
                                                                          .productionOptionals[
                                                                              prodOptState.stepOneIndexSelect!]
                                                                          .level2[prodOptState.stepTwoIndexSelect!]
                                                                          .level3[prodOptState.stepTreeIndexSelect!]
                                                                          .level4[index]
                                                                          .price,
                                                                      indexSelect: index,
                                                                    );
                                                                    myBloc.updateStepFiveVariables(
                                                                      groupValueRadio: "",
                                                                      price: myBloc.state.stepFivePrice,
                                                                      indexSelect: myBloc.state.stepFiveIndexSelect,
                                                                    );
                                                                    myBloc.updateSelectCurrentOption(4);
                                                                    if (state
                                                                        .productList
                                                                        .products![0]
                                                                        .productionOptionals[
                                                                            prodOptState.stepOneIndexSelect!]
                                                                        .level2[prodOptState.stepTwoIndexSelect!]
                                                                        .level3[prodOptState.stepTreeIndexSelect!]
                                                                        .level4[index]
                                                                        .level5
                                                                        .isNotEmpty) {
                                                                      myBloc.updateLastOption(5);
                                                                    } else {
                                                                      myBloc.updateLastOption(4);
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            AlvaText(
                                                                title: state
                                                                    .productList
                                                                    .products![0]
                                                                    .productionOptionals[
                                                                        prodOptState.stepOneIndexSelect!]
                                                                    .level2[prodOptState.stepTwoIndexSelect!]
                                                                    .level3[prodOptState.stepTreeIndexSelect!]
                                                                    .level4[index]
                                                                    .label,
                                                                textStyle: AlvaStyles()
                                                                    .bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW)),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        AlvaText(
                                                            title:
                                                                "${state.productList.products![0].productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!].level3[prodOptState.stepTreeIndexSelect!].level4[index].price.toDecimalFormat()} บาท",
                                                            textStyle: AlvaStyles().headingSize12w400(spaceGrey)),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    color: cloudSoftDeepWhite,
                                                    width: MediaQuery.of(context).size.width - 32,
                                                    height: 1,
                                                  )
                                                ],
                                              );
                                            }),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                          // cloudSoftDeepWhite
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              prodOptState.stepFourGroupValueRadio == ""
                                                  ? AlvaText(
                                                      title: "ตัวเลือกสี",
                                                      textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                                                  : AlvaText(
                                                      title: prodOptState.stepFourGroupValueRadio,
                                                      textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                                              prodOptState.stepFourPrice == null
                                                  ? AlvaText(
                                                      title: "0 บาท",
                                                      textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                                                  : AlvaText(
                                                      title: "${prodOptState.stepFourPrice!.toDecimalFormat()} บาท",
                                                      textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        prodOptState.stepFourGroupValueRadio == "" ||
                                state
                                    .productList
                                    .products![0]
                                    .productionOptionals[prodOptState.stepOneIndexSelect!]
                                    .level2[prodOptState.stepTwoIndexSelect!]
                                    .level3[prodOptState.stepTreeIndexSelect!]
                                    .level4[prodOptState.stepFourIndexSelect!]
                                    .level5
                                    .isEmpty
                            ? Container()
                            : Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 32,
                                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: AlvaText(
                                      title: state
                                          .productList
                                          .products![0]
                                          .productionOptionals[prodOptState.stepOneIndexSelect!]
                                          .level2[prodOptState.stepTwoIndexSelect!]
                                          .level3[prodOptState.stepTreeIndexSelect!]
                                          .level4[prodOptState.stepFourIndexSelect!]
                                          .level5[0]
                                          .levelName,
                                      textStyle: AlvaStyles().headingSize14w700(BTN_SELECTED_TEXT_COLOR_NEW),
                                    ),
                                  ),
                                  Container(
                                    color: whitePure,
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                .productList
                                                .products![0]
                                                .productionOptionals[prodOptState.stepOneIndexSelect!]
                                                .level2[prodOptState.stepTwoIndexSelect!]
                                                .level3[prodOptState.stepTreeIndexSelect!]
                                                .level4[prodOptState.stepFourIndexSelect!]
                                                .level5
                                                .length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                                    // cloudSoftDeepWhite
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 24,
                                                              height: 24,
                                                              child: Radio(
                                                                value: state
                                                                    .productList
                                                                    .products![0]
                                                                    .productionOptionals[
                                                                        prodOptState.stepOneIndexSelect!]
                                                                    .level2[prodOptState.stepTwoIndexSelect!]
                                                                    .level3[prodOptState.stepTreeIndexSelect!]
                                                                    .level4[prodOptState.stepFourIndexSelect!]
                                                                    .level5[index]
                                                                    .label,
                                                                groupValue: prodOptState.stepFiveGroupValueRadio,
                                                                toggleable: true,
                                                                onChanged: (value) {
                                                                  if (value == null) {
                                                                    myBloc.updateStepFiveVariables(
                                                                      groupValueRadio: "",
                                                                      price: null,
                                                                      indexSelect: myBloc.state.stepFiveIndexSelect,
                                                                    );
                                                                    // myBloc.updateSelectCurrentOption(4);
                                                                    myBloc.updateLastOption(4);
                                                                  } else {
                                                                    myBloc.updateStepFiveVariables(
                                                                      groupValueRadio: value.toString(),
                                                                      price: state
                                                                          .productList
                                                                          .products![0]
                                                                          .productionOptionals[
                                                                              prodOptState.stepOneIndexSelect!]
                                                                          .level2[prodOptState.stepTwoIndexSelect!]
                                                                          .level3[prodOptState.stepTreeIndexSelect!]
                                                                          .level4[prodOptState.stepFourIndexSelect!]
                                                                          .level5[index]
                                                                          .price,
                                                                      indexSelect: index,
                                                                    );
                                                                    myBloc.updateSelectCurrentOption(5);
                                                                    myBloc.updateLastOption(5);
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            AlvaText(
                                                                title: state
                                                                    .productList
                                                                    .products![0]
                                                                    .productionOptionals[
                                                                        prodOptState.stepOneIndexSelect!]
                                                                    .level2[prodOptState.stepTwoIndexSelect!]
                                                                    .level3[prodOptState.stepTreeIndexSelect!]
                                                                    .level4[prodOptState.stepFourIndexSelect!]
                                                                    .level5[index]
                                                                    .label,
                                                                textStyle: AlvaStyles()
                                                                    .bodySize14W600(BTN_SELECTED_TEXT_COLOR_NEW)),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        AlvaText(
                                                            title:
                                                                "${state.productList.products![0].productionOptionals[prodOptState.stepOneIndexSelect!].level2[prodOptState.stepTwoIndexSelect!].level3[prodOptState.stepTreeIndexSelect!].level4[prodOptState.stepFourIndexSelect!].level5[index].price.toDecimalFormat()} บาท",
                                                            textStyle: AlvaStyles().headingSize12w400(spaceGrey)),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    color: cloudSoftDeepWhite,
                                                    width: MediaQuery.of(context).size.width - 32,
                                                    height: 1,
                                                  )
                                                ],
                                              );
                                            }),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                          // cloudSoftDeepWhite
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              prodOptState.stepFiveGroupValueRadio == ""
                                                  ? AlvaText(
                                                      title: "ตัวเลือกสี",
                                                      textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                                                  : AlvaText(
                                                      title: prodOptState.stepFiveGroupValueRadio,
                                                      textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                                              prodOptState.stepFivePrice == null
                                                  ? AlvaText(
                                                      title: "0 บาท",
                                                      textStyle: AlvaStyles().bodySize14W600(cloudSoftDeepWhite))
                                                  : AlvaText(
                                                      title: "${prodOptState.stepFivePrice!.toDecimalFormat()} บาท",
                                                      textStyle: AlvaStyles().bodySize16W600(blackGoMunTo)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 96,
                        )
                      ],
                    );
                  } else if (state.productListStatus == GetProductListStatus.success) {
                    return ErrorScreen(
                      title: ErrorConst().titleNS,
                      subTitle: ErrorConst().subTitleNS,
                      titleBtn: ErrorConst().titleBtnNS,
                      onTap: () {
                        // context.read<ProductListBloc>().add(const GetProductList());
                        Navigator.of(context).pop();
                      },
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
