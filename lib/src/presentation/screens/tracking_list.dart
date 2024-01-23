import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/alva_styles.dart';
import 'package:marketplace_line_oa/src/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/tracking_order/tracking_order_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/root_page_condition.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_text.dart';
import 'package:marketplace_line_oa/src/presentation/widget/root_widget.dart';
import 'package:marketplace_line_oa/src/presentation/widget/tracking/tracking_order_card.dart';

class TrackingListScreen extends StatefulWidget {
  const TrackingListScreen({super.key});

  @override
  State<TrackingListScreen> createState() => _TrackingListScreenState();
}

class _TrackingListScreenState extends State<TrackingListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TrackingOrderBloc>().add(const GetTrackingOrderListFromJson());
  }

  @override
  Widget build(BuildContext context) {
    return RootPageCondition(
      child: AlvaRootWidget(
          titlePage: titleWebPage,
          appBar: AppBar(
            title: AlvaText(title: "ตรวจสอบสถานะสินค้า", textStyle: AlvaStyles().headingSize18w700(BTN_SELECTED_TEXT_COLOR_NEW)),
            titleSpacing: 0,
            leadingWidth: 60,
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: IconButton(
                key: const Key("pop_navigator_to_home_page"),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_rounded)),
          ),
          child: BlocBuilder<TrackingOrderBloc, TrackingOrderState>(
            builder: (context, state) {
              if (state.trackingOrderListStatus == GetTrackingOrderListStatus.success) {
                return Container(
                  color: cloudDeepWhite,
                  child: ListView.builder(
                    itemCount: state.trackingListData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TrackingOrderCard(
                        order: state.trackingListData[index],
                      );
                    },
                  ),
                );
              } else {
                return Text("loading....");
              }
            },
          )),
    );
  }
}
