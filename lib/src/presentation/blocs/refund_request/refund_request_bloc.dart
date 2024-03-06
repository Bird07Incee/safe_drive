import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';
import 'package:marketplace_line_oa/src/model/refund/refund_request_model.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

part 'refund_request_event.dart';
part 'refund_request_state.dart';

class RefundRequestBloc extends Bloc<RefundRequestEvent, RefundRequestState> {
  final DioUtilityRepository utilityRepository;

  RefundRequestBloc({required this.utilityRepository})
      : super(RefundRequestState(
            getTextReason: TextEditingController(),
            getTextRemark: TextEditingController(),
            orderNo: "",
            refundResponse: const {},
            focusRemark: FocusNode())) {
    on<RefundRequestEvent>((event, emit) {
// TODO: implement event handler
    });

    on<SetRefundData>(_onSetRefundData);
    on<OnSelectReason>(_onSelectReason);
    on<OnEditRemark>(_onEditRemark);
    on<OnSubmitRefundData>(_onSubmit);
  }

  _onSetRefundData(SetRefundData event, Emitter<RefundRequestState> emit) async {
    emit(state.copyWith(
        refundRequestStatus: GetRefundRequestStatus.loading, getTextReason: TextEditingController(), getTextRemark: TextEditingController()));

    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_BASE_URL");
    final inquiryPath = Environment().getValue("INQUIRY_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();
    String uid = await lineDataHelper.getLineUid();

    var payload = {"invoiceNo": event.orderNo, "uid": uid};

    try {
      Response response =
          await utilityRepository.postByURL("$baseUrl$transactionApiPath$inquiryPath", payload, headers: {"Authorization": "Bearer $accessToken"});

      final InquiryData inquiryData = InquiryData.fromJson(response.data["rawData"]);
      String status = response.data["status"] ?? "";

      if (status == "Complete") {
        if (event.reasonList!.isNotEmpty) {
          emit(state.copyWith(
              inquiryData: inquiryData,
              reasonList: event.reasonList,
              refundRequestData: RefundRequestModel(
                  status: status,
                  refundInfo: RefundInfoModel(
                    refundNo: event.orderNo,
                    refundDate: '',
                    refundTime: '',
                    reason: '',
                    remark: '',
                  ),
                  product: null),
              refundRequestStatus: GetRefundRequestStatus.success));
        }
      }
    } catch (e) {
      emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.error));
    }
  }

  _onSelectReason(OnSelectReason event, Emitter<RefundRequestState> emit) async {
    //   emit(state.copyWith(refundRequestData: RefundRequestModel(refundInfo: RefundInfoModel(reason: reason, refundNo: '', refundDate: '', refundTime: '', remark: ''), status: '', product: null),
    //       refundRequestStatus: GetRefundRequestStatus.success));
    emit(state.copyWith(
        refundRequestData: event.refundRequestModel,
        getTextReason: event.getTextReason,
        getTextRemark: event.getTextRemark,
        orderNo: state.orderNo,
        refundRequestStatus: GetRefundRequestStatus.success));
  }

  _onEditRemark(OnEditRemark event, Emitter<RefundRequestState> emit) async {
    //   emit(state.copyWith(refundRequestData: RefundRequestModel(refundInfo: RefundInfoModel(reason: reason, refundNo: '', refundDate: '', refundTime: '', remark: ''), status: '', product: null),
    //       refundRequestStatus: GetRefundRequestStatus.success));
    emit(state.copyWith(
        refundRequestData: event.refundRequestModel,
        getTextReason: event.getTextReason,
        getTextRemark: event.getTextRemark,
        orderNo: state.orderNo,
        refundRequestStatus: GetRefundRequestStatus.success));
  }

  _onSubmit(OnSubmitRefundData event, Emitter<RefundRequestState> emit) async {
    emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.loading));
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_BASE_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();

    try {
      String path = Environment().getValue("REFUND_URL");
      var data = {"orderNo": state.inquiryData.invoiceNo!, "reason": state.getTextReason.text, "remark": state.getTextRemark.text};
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
