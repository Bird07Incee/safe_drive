import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/model/refund/refund_success_data_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_event.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/refund_success/refund_success_state.dart';
import 'package:marketplace_line_oa/src/presentation/widget/snackbar/mkp_toast.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

class RefundSuccessBloc extends Bloc<RefundSuccessEvent, RefundSuccessState> {
  RefundSuccessBloc({required this.utilityRepository}) : super(RefundSuccessState()) {
    on<GetRefundSuccess>(_onGetRefundSuccess);
  }

  final DioUtilityRepository utilityRepository;

  _onGetRefundSuccess(GetRefundSuccess event, Emitter<RefundSuccessState> emit) async {
    emit(state.copyWith(refundSuccessStatus: GetRefundSuccessDataStatus.loading));
    try {
      Map<String, dynamic> refundJsonData = {"status": event.refundResponse["status"]};
      refundJsonData.addAll(event.refundResponse["refundInfo"] as Map<String, dynamic>);
      refundJsonData.addAll(event.refundResponse["rawData"] as Map<String, dynamic>);

      final RefundSuccessDataModel refundData = RefundSuccessDataModel.fromJson(refundJsonData);
      var status = refundJsonData["status"];
      if (status == "Complete") {
        ScaffoldMessenger.of(event.context).showSnackBar(getMkpToast("หลักฐานการขอคืนสินค้า ถูกจัดส่งไปยังอีเมลของคุณแล้ว"));
        emit(state.copyWith(refundSuccessData: refundData, refundSuccessStatus: GetRefundSuccessDataStatus.success));
      } else {
        emit(state.copyWith(refundSuccessStatus: GetRefundSuccessDataStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(refundSuccessStatus: GetRefundSuccessDataStatus.error));
    }
  }
}
