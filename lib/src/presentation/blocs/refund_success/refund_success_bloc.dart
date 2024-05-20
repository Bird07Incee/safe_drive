import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/model/refund/refund_success_data_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_event.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_state.dart';
import 'package:marketplace_line_oa/src/presentation/widget/snackbar/mkp_toast.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

class RefundSuccessBloc extends Bloc<RefundSuccessEvent, RefundSuccessState> {
  RefundSuccessBloc({required this.utilityRepository})
      : super(RefundSuccessState(refundSuccessData: RefundSuccessDataModel.empty, refundSuccessStatus: GetRefundSuccessDataStatus.initial)) {
    on<OnClearState>(_onClearState);
    on<GetRefundSuccess>(_onGetRefundSuccess);
  }

  final DioUtilityRepository utilityRepository;

  _onClearState(OnClearState event, Emitter<RefundSuccessState> emit) {
    emit(RefundSuccessState(refundSuccessStatus: GetRefundSuccessDataStatus.initial, refundSuccessData: RefundSuccessDataModel.empty));
  }

  _onGetRefundSuccess(GetRefundSuccess event, Emitter<RefundSuccessState> emit) async {
    emit(state.copyWith(refundSuccessStatus: GetRefundSuccessDataStatus.loading));
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_REFUND_BASE_URL");
    final inquiryRefundPath = Environment().getValue("INQUIRY_REFUND_URL");
    ScaffoldMessengerState? stateSc;
    if (!event.bypassContext) {
      stateSc = ScaffoldMessenger.of(event.context);
    }
    Map<String, dynamic> refundJsonData = {};
    try {
      Response response = await utilityRepository.getByURL("$baseUrl$transactionApiPath$inquiryRefundPath", {"invoiceNo": event.invoiceNo});

      if (response.statusCode == 200) {
        refundJsonData = response.data;

        var status = refundJsonData["status"];

        final RefundSuccessDataModel refundData = RefundSuccessDataModel.fromJson(refundJsonData);
        if (status == "Complete") {
          if (!event.bypassContext) {
            stateSc!.showSnackBar(getMkpToast("หลักฐานการขอคืนสินค้า ถูกจัดส่งไปยังอีเมลของคุณแล้ว", horizontalMargin: 30));
          }
          emit(state.copyWith(refundSuccessData: refundData, refundSuccessStatus: GetRefundSuccessDataStatus.success));
        } else {
          emit(state.copyWith(refundSuccessStatus: GetRefundSuccessDataStatus.error));
        }
      } else {
        emit(state.copyWith(refundSuccessStatus: GetRefundSuccessDataStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(refundSuccessStatus: GetRefundSuccessDataStatus.error));
    }
  }
}
