import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

part 'refund_request_event.dart';
part 'refund_request_state.dart';

class RefundRequestBloc extends Bloc<RefundRequestEvent, RefundRequestState> {
  final DioUtilityRepository utilityRepository;
  final TextEditingController? textEditingControllerReason = TextEditingController();
  final TextEditingController? textEditingControllerRemark = TextEditingController();
  final FocusNode? focusRemark = FocusNode();

  RefundRequestBloc({required this.utilityRepository})
      : super(RefundRequestState(getTextReason: "", getTextRemark: "", orderNo: "", refundResponse: const {})) {
    on<RefundRequestEvent>((event, emit) {
// TODO: implement event handler
    });

    on<SetRefundData>(_onSetRefundData);
    on<OnSelectReason>(_onSelectReason);
    on<OnEditRemark>(_onEditRemark);
    on<OnSubmitRefundData>(_onSubmit);
  }

  _onSetRefundData(SetRefundData event, Emitter<RefundRequestState> emit) async {
    emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.loading));

    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_REFUND_BASE_URL");
    final inquiryRefundPath = Environment().getValue("INQUIRY_REFUND_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();
    String uid = await lineDataHelper.getLineUid();

    var payload = {"invoiceNo": event.orderNo, "uid": uid};

    try {
      Response response = await utilityRepository
          .postByURL("$baseUrl$transactionApiPath$inquiryRefundPath", payload, headers: {"Authorization": "Bearer $accessToken"});

      final InquiryData inquiryData = InquiryData.fromJson(response.data["rawData"]);
      String status = response.data["status"] ?? "";

      if (status == "Complete") {
        if (event.reasonList!.isNotEmpty) {
          emit(state.copyWith(
              inquiryData: inquiryData,
              reasonList: event.reasonList,
              getTextReason: "",
              getTextRemark: "",
              refundRequestStatus: GetRefundRequestStatus.success));
        }
      }
    } catch (e) {
      emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.error));
    }
  }

  _onSelectReason(OnSelectReason event, Emitter<RefundRequestState> emit) async {
    emit(state.copyWith(
        getTextReason: event.getTextReason,
        getTextRemark: event.getTextRemark,
        orderNo: state.orderNo,
        refundRequestStatus: GetRefundRequestStatus.success));
  }

  _onEditRemark(OnEditRemark event, Emitter<RefundRequestState> emit) async {
    emit(state.copyWith(
        getTextReason: event.getTextReason,
        getTextRemark: event.getTextRemark,
        orderNo: state.orderNo,
        refundRequestStatus: GetRefundRequestStatus.success));
  }

  _onSubmit(OnSubmitRefundData event, Emitter<RefundRequestState> emit) async {
    emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.loading));
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_REFUND_BASE_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();
    String path = Environment().getValue("REFUND_URL");
    try {
      var data = {"orderNo": state.inquiryData.invoiceNo!, "reason": state.getTextReason, "remark": state.getTextRemark};
      Response response = await utilityRepository.postByURL("$baseUrl$transactionApiPath$path", data, headers: {
        "Authorization": "Bearer $accessToken",
      });

      if (response.statusCode == 200) {
        var refundResponse = response.data as Map<String, dynamic>;
        emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.submitSuccess, refundResponse: refundResponse));
      }
    } catch (e) {
      emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.submitFail));
    }
  }
}
