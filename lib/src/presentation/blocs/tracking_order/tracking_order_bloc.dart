import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/tracking_list_data.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

part 'tracking_order_event.dart';
part 'tracking_order_state.dart';

class TrackingOrderBloc extends Bloc<TrackingOrderEvent, TrackingOrderState> {
  final DioUtilityRepository utilityRepository;

  TrackingOrderBloc({required this.utilityRepository}) : super(TrackingOrderState()) {
    on<TrackingOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetTrackingOrderListByPage>(_onGetTrackingOrderListByPage);
  }

  _onGetTrackingOrderListByPage(GetTrackingOrderListByPage event, Emitter<TrackingOrderState> emit) async {
    if (event.page == 1) {
      emit(state.copyWith(trackingOrderListStatus: GetTrackingOrderListStatus.loading));
    } else {
      GeneralDialog().showLoadingDialog(context: event.context);
    }

    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_TRACKING_BASE_URL");
    final trackingListPath = Environment().getValue("TRACKING_LIST_URL");
    String uid = await lineDataHelper.getLineUid();

    var params = {"itemsPerPage": 10, "page": event.page, "customerRef": uid};

    try {
      Response response = await utilityRepository.getByURL("$baseUrl$transactionApiPath$trackingListPath", params);

      List ordersResponse = response.data["orders"];
      TrackingListPage trackingListPage = TrackingListPage.fromJson(response.data);
      List<Order> orderList = [];

      for (var element in ordersResponse) {
        Order temp = Order.fromJson(element);
        orderList.add(temp);
      }

      if (orderList.isNotEmpty) {
        if (event.page != 1) {
          var oldOrderList = state.trackingListData;
          emit(state.copyWith(
              trackingOrderListStatus: GetTrackingOrderListStatus.success,
              trackingListData: oldOrderList + orderList,
              trackingListPage: trackingListPage));
          // ignore: use_build_context_synchronously
          Navigator.pop(event.context);
        } else {
          emit(state.copyWith(
              trackingOrderListStatus: GetTrackingOrderListStatus.success, trackingListData: orderList, trackingListPage: trackingListPage));
        }
      } else {
        emit(state.copyWith(trackingOrderListStatus: GetTrackingOrderListStatus.empty, trackingListData: orderList));
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 503) {
        emit(state.copyWith(trackingOrderListStatus: GetTrackingOrderListStatus.maintenance));
      } else {
        emit(state.copyWith(trackingOrderListStatus: GetTrackingOrderListStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(trackingOrderListStatus: GetTrackingOrderListStatus.error));
    }
  }
}
