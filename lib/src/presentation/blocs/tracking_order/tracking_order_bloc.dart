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

    on<GetTrackingOrderListFromJson>(_onGetTrackingOrderListFromJson);
    on<GetTrackingOrderListByPage>(_onGetTrackingOrderListByPage);
  }

  _onGetTrackingOrderListFromJson(GetTrackingOrderListFromJson event, Emitter<TrackingOrderState> emit) {
    Order mockOrder = Order.fromJson({
      "orderNo": "1234",
      "shippingStatus": "pending",
      "shippingStatusMessage": "จัดส่งแล้วครับ",
      "products": [
        {
          "productId": "PV_EGYJW5CE8Y8G",
          "productNameTh": "Pulsa Max Kook EV 2 Opt 1 Mer1",
          "productNameEn": "Pulsa Max Kook EV 2 Opt 1 Mer1",
          "productDescription": "ทดสอบ",
          "productImageUrl":
              "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PPMAX_GREY_MONOCHROME_PHONE.png",
          "productQty": 1,
          "price": 59000.0,
          "discountPrice": 40000.0,
          "currency": "Bath",
          "channel": "LINE / GOAPP",
          "createDate": "",
          "lastUpdateDate": "วันที่ update status ของ shipping"
        }
      ],
      "totalPrice": 59000.0,
      "totalQty": 1
    });

    List<Order> mock = [mockOrder, mockOrder];

    if (mock.isNotEmpty) {
      emit(state.copyWith(trackingOrderListStatus: GetTrackingOrderListStatus.success, trackingListData: mock));
    } else {
      emit(state.copyWith(trackingOrderListStatus: GetTrackingOrderListStatus.empty, trackingListData: mock));
    }
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
    String accessToken = await lineDataHelper.getLineAccessToken();
    String uid = await lineDataHelper.getLineUid();

    var params = {"itemsPerPage": 10, "page": event.page, "customerRef": uid};

    try {
      Response response =
          await utilityRepository.getByURL("$baseUrl$transactionApiPath$trackingListPath", params, headers: {"Authorization": "Bearer $accessToken"});

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
    } catch (e) {
      emit(state.copyWith(trackingOrderListStatus: GetTrackingOrderListStatus.error));
    }
  }
}
