import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/tracking_model.dart';
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
      Response response = await utilityRepository.getByURL("$baseUrl$transactionApiPath$path", {
        "orderNo": event.orderNo,
        "productId": event.productId
      }, headers: {
        "Authorization": "Bearer $accessToken",
      });
      final t = TrackingResponseModel.fromJson(response.data);
      var tracking = t.tracking;
      String refundExpireDateTime = t.tracking.refundExpireDateTime;
      Duration diffDay = Duration.zero;
      int refundDay = tracking.refundDay;
      if (refundExpireDateTime.isNotEmpty) {
        DateTime dateTimeExpire = DateTime.parse(refundExpireDateTime);
        diffDay = dateTimeExpire.difference(DateTime.now());
      }
      bool isRefundable = true;
      bool disableRefundButton = false;
      if (diffDay.isNegative || ["RefundSuccess"].contains(t.tracking.status[0].statusName)) {
        isRefundable = false;
      } else if (["RefundRequest"].contains(t.tracking.status[0].statusName)) {
        isRefundable = false;
      }

      TrackingModel modelTracking = TrackingModel(
          orderRef: tracking.orderRef,
          refundExpireDateTime: tracking.refundExpireDateTime,
          refundDay: refundDay,
          refundable: isRefundable,
          disableRefundButton: disableRefundButton,
          orderCreateDate: tracking.orderCreateDate,
          status: tracking.status,
          merchantNumber: tracking.merchantNumber);
      emit(state.copyWith(status: TrackingDetailStatus.success, tracking: modelTracking));
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
    return TrackingResponseModel(trackingNo: json['order_ref'] ?? '', tracking: TrackingModel.fromJson(json));
  }

  @override
  List<Object?> get props => [trackingNo, tracking];
}
