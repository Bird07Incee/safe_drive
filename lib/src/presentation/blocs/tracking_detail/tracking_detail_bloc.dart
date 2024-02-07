import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/tracking_model.dart';
import 'package:marketplace_line_oa/src/presentation/screens/tracking_detail_screen.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

part 'tracking_detail_event.dart';
part 'tracking_detail_state.dart';

class TrackingDetailBloc extends Bloc<TrackingDetailEvent, TrackingDetailState> {
  TrackingDetailBloc({required this.utilityRepository}) : super(const TrackingDetailState()) {
    on<GetTracking>(_onGetTrackingDetail);
  }
  final DioUtilityRepository utilityRepository;

  _onGetTrackingDetail(GetTracking event, Emitter<TrackingDetailState> emit) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_BASE_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();
    emit(state.copyWith(status: TrackingDetailStatus.loading));

    try {
      String path = "/v1/trackingDetail";
      // Response response = await utilityRepository.getByURL("$baseUrl$transactionApiPath$path", {
      //   "orderNo": event.orderNo,
      //   "productId": event.productId
      // }, headers: {
      //   "Authorization": "Bearer $accessToken",
      // });

      //final t = TrackingResponseModel.fromJson(response.data);
      final t = EX().pendingMock;
      // final t = EX().pendingMock;
      // final t = EX().pendingRefundRequestMock;
      // final t = EX().pendingRefundSuccessMock;
      // final t = EX().pendingRefundRejectedMock;
      // final t = EX().preparedDeliveryMock;
      // final t = EX().preparedSelfSuccessMock;
      // final t = EX().preparedSelfFailedMock;
      // final t = EX().preparedDeliveryRefundRequestMock;
      // final t = EX().preparedDeliveryRefundSuccessMock;
      // final t = EX().preparedDeliveryRefundRejectedMock;
      // final t = EX().preparedSelfSuccessRefundRequestMock;
      // final t = EX().preparedSelfSuccessRefundSuccessMock;
      // final t = EX().preparedSelfSuccessRefundRejectMock;
      // final t = EX().preparedSelfFailedRefundRequestMock;
      // final t = EX().preparedSelfFailedRefundSuccessMock;
      // final t = EX().preparedSelfFailedRefundRejectMock;
      // final t = EX().shippedDeliveryMock;
      // final t = EX().shippedSelfMock;
      // final t = EX().shippedDeliveryRefundRequestMock;
      // final t = EX().shippedDeliveryRefundSuccessMock;
      // final t = EX().shippedDeliveryRefundRejectMock;
      // final t = EX().shippedSelfRefundRequestMock;
      // final t = EX().shippedSelfRefundSuccessMock;
      // final t = EX().shippedSelfRefundRejectMock;
      // final t = EX().shippedDeliveryFailMock;
      // final t = EX().shippedSelfFailedMock;
      // final t = EX().shippedDeliveryFailedRefundRequestMock;
      // final t = EX().shippedDeliveryFailedRefundSuccessMock;
      // final t = EX().shippedDeliveryFailedRefundRejectMock;
      // final t = EX().shippedSelfFailedRefundRequestMock;
      // final t = EX().shippedSelfFailedRefundSuccessMock;
      // final t = EX().shippedSelfFailedRefundRejectMock;
      // final t = EX().receivedDeliveryMock;
      // final t = EX().receivedDeliveryRefundRequestMock;
      // final t = EX().receivedDeliveryRefundSuccessMock;
      // final t = EX().receivedDeliveryRefundRejectMock;
      // final t = EX().receivedSelfMock;
      // final t = EX().receivedSelfRefundRequestMock;
      // final t = EX().receivedSelfRefundSuccessMock;
      // final t = EX().receivedSelfRefundRejectMock;
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(status: TrackingDetailStatus.success, tracking: t));
    } catch (e) {
      emit(state.copyWith(status: TrackingDetailStatus.error));
    }

  }
}

class TrackingResponseModel extends Equatable {
  const TrackingResponseModel({required this.trackingNo, required this.tracking});
  final String trackingNo;
  final TrackingModel tracking;

  static const empty = TrackingResponseModel(trackingNo: "", tracking: TrackingModel.empty);

  factory TrackingResponseModel.fromJson(Map<String, dynamic> json) {
    return TrackingResponseModel(trackingNo: json['trackingNo'] ?? '', tracking: json['tracking'] ?? '');
  }

  @override
  List<Object?> get props => [trackingNo, tracking];
}
