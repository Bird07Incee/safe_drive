import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/helpers/amplitude_web_helper.dart';
import 'package:marketplace_line_oa/src/js/js_manager.dart';
import 'package:marketplace_line_oa/src/model/tracking_list_data.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_success/order_success_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/tracking_order/tracking_order_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/disclaimer_bottom_section.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/tracking/tracking_order_card.dart';
import 'package:marketplace_line_oa/src/routes/change_history_url_strategy.dart';
import 'package:marketplace_line_oa/src/routes/navigator_helper.dart';
import 'package:marketplace_line_oa/src/routes/routes.dart';

import 'tracking_list_no_product.dart';

class TrackingListScreen extends StatefulWidget {
  const TrackingListScreen({super.key});

  @override
  State<TrackingListScreen> createState() => _TrackingListScreenState();
}

class _TrackingListScreenState extends State<TrackingListScreen> {
  @override
  void initState() {
    super.initState();
    AmplitudeWebHelper.getInstance().logEnterOrderTrackingPage();
    context.read<TrackingOrderBloc>().add(GetTrackingOrderListByPage(1, context));
  }

  bool isMorePageToLoad(TrackingListPage trackingListPage) {
    bool isMore = false;

    if (trackingListPage.currentPage! < trackingListPage.totalPage!) {
      isMore = true;
    }

    return isMore;
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: AlvaText(title: "ตรวจสอบสถานะสินค้า", textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
      titleSpacing: 0,
      leadingWidth: 60,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: IconButton(
          key: const Key("pop_navigator_to_home_page"),
          onPressed: () {
            showOneTrustCookieScript();
            setUrlStrategyListener(ChangeHistoryUrlStrategy(title: Routes.initial.name, urlPromptBuy: Routes.initial.toStringPath()));
            Navigator.pushNamedAndRemoveUntil(context, Routes.initial.toStringPath(), (route) => false);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
    return RootPageCondition(
      child: WillPopScope(
        onWillPop: () async {
          showOneTrustCookieScript();
          setUrlStrategyListener(ChangeHistoryUrlStrategy(title: Routes.initial.name, urlPromptBuy: Routes.initial.toStringPath()));
          Navigator.pushNamedAndRemoveUntil(context, Routes.initial.toStringPath(), (route) => false);
          return false;
        },
        child: BlocBuilder<TrackingOrderBloc, TrackingOrderState>(
          builder: (context, state) {
            if (state.trackingOrderListStatus == GetTrackingOrderListStatus.success) {
              return AlvaRootWidget(
                  titlePage: titleWebPage,
                  appBar: appBar,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 16,
                          color: Colors.white,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.trackingListData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TrackingOrderCard(
                              order: state.trackingListData[index],
                            );
                          },
                        ),
                        Visibility(
                          visible: isMorePageToLoad(state.trackingListPage),
                          child: GestureDetector(
                            onTap: () {
                              context.read<TrackingOrderBloc>().add(GetTrackingOrderListByPage(state.trackingListPage.currentPage! + 1, context));
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  width: 100,
                                  height: 32,
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  decoration:
                                      BoxDecoration(color: Color(0xffe8e7e7), borderRadius: BorderRadius.all(Radius.circular(16)), boxShadow: [
                                    BoxShadow(
                                      color: whitePure.withOpacity(0.4),
                                      spreadRadius: 0,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        'โหลดเพิ่มเติม',
                                        style: AlvaStyles().bodySize12W600(blackGoMunTo),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                        ),
                        DisclaimerSection()
                      ],
                    ),
                  ));
            } else if (state.trackingOrderListStatus == GetTrackingOrderListStatus.initial ||
                state.trackingOrderListStatus == GetTrackingOrderListStatus.loading) {
              return AlvaRootWidget(titlePage: titleWebPage, child: const LoadingScreen());
            } else if (state.trackingOrderListStatus == GetTrackingOrderListStatus.empty) {
              return AlvaRootWidget(titlePage: titleWebPage, appBar: appBar, child: const TrackingListNoProduct());
            } else if (state.trackingOrderListStatus == GetTrackingOrderListStatus.maintenance) {
              return ErrorScreen(
                title: ErrorConst().titleMaintenance,
                subTitle: ErrorConst().subtitleMaintenance,
                titleBtn: ErrorConst().titleBtnMaintenance,
                onTap: () {
                  bool isFromOrderSuccess = context.read<OrderSuccessBloc>().state.isFromOrderSuccess;

                  if (isFromOrderSuccess) {
                    context.read<OrderSuccessBloc>().add(SetIsFromOrderSuccess(false));
                    String env = Environment().getValue("ENVIRONMENT_NAME");
                    loadOneTrustCookieScript(env);
                    showOneTrustCookieScript();
                    Navigator.pushNamedAndRemoveUntil(context, Routes.initial.toStringPath(), (route) => false);
                  } else {
                    showOneTrustCookieScript();
                    Navigator.pop(context);
                  }
                },
              );
            } else {
              return ErrorScreen(
                title: ErrorConst().titleNS,
                subTitle: ErrorConst().subTitleNS,
                titleBtn: ErrorConst().titleBtnNS,
                onTap: () {
                  context.read<TrackingOrderBloc>().add(GetTrackingOrderListByPage(1, context));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
