import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:marketplace_line_oa/src/model/refund/refund_request_model.dart';

part 'refund_request_event.dart';

part 'refund_request_state.dart';

class RefundRequestBloc extends Bloc<RefundRequestEvent, RefundRequestState> {
  final DioUtilityRepository utilityRepository;

  RefundRequestBloc({required this.utilityRepository})
      : super(RefundRequestState(
            getTextReason: TextEditingController(),
            getTextRemark: TextEditingController(),
            orderNo: "")) {
    on<RefundRequestEvent>((event, emit) {
// TODO: implement event handler
    });

    on<SetRefundData>(_onSetRefundData);
    on<OnSelectReason>(_onSelectReason);
    on<OnEditRemark>(_onEditRemark);
    on<OnSubmitRefundData>(_onSubmit);
  }

  _onSetRefundData(
      SetRefundData event, Emitter<RefundRequestState> emit) async {
    emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.loading));

    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath =
        Environment().getValue("BFF_TRANSACTION_BASE_URL");
    final inquriyPath = Environment().getValue("INQUIRY_URL");
    // final ctx = ScaffoldMessenger.of(event.context);
    String accessToken = await lineDataHelper.getLineAccessToken();
    String uid = await lineDataHelper.getLineUid();

    var payload = {"invoiceNo": event.orderNo, "uid": uid};

    try {
      Response response = await utilityRepository.postByURL(
          "$baseUrl$transactionApiPath$inquriyPath", payload,
          headers: {"Authorization": "Bearer $accessToken"});

      final InquiryData inquiryData =
          InquiryData.fromJson(response.data["rawData"]);
      String status = response.data["status"] ?? "";

      if (status == "Complete") {
        List<DropdownAddressModel> mockReasonList = [
          DropdownAddressModel(id: "1", nameTh: "เปลื่ยนใจ"),
          DropdownAddressModel(id: "2", nameTh: "ได้รับสินค้าไม่ตรงตามที่สั่ง"),
          DropdownAddressModel(
              id: "3", nameTh: "สินค้าสภาพไม่ดี หรือมีความเสียหาย"),
          DropdownAddressModel(
              id: "4", nameTh: "ฉันไม่ได้รับพัสดุของคำสั่งซื้อนี้"),
          DropdownAddressModel(
              id: "5", nameTh: "ได้รับสินค้าไม่ครบ หรือชิ้นส่วนไม่สมบูรณ์"),
          DropdownAddressModel(id: "6", nameTh: "การทำงานของสินค้าไม่สมบูรณ์")
        ];
        event.reasonList!.addAll(mockReasonList);

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
    } catch (e) {
      emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.error));
    }
  }

  _onSelectReason(
      OnSelectReason event, Emitter<RefundRequestState> emit) async {
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
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath =
        Environment().getValue("BFF_TRANSACTION_BASE_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();
    emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.loading));

    try {
      String path = "/v1/refund";
      print("Button send Order " + state.inquiryData.invoiceNo!);
      print("Button send Reason " + state.getTextReason.text);
      print("Button send Remark " + state.getTextRemark.text);
      var data = {
        "orderNo": state.inquiryData.invoiceNo!,
        "reason": state.getTextReason.text,
        "remark": state.getTextRemark.text
      };
      Response response = await utilityRepository
          .postByURL("$baseUrl$transactionApiPath$path", data, headers: {
        "Authorization": "Bearer $accessToken",
      });

      if (response.statusCode == 200) {
        //  final o = OrderResponseModel.fromJson(response.data);
        emit(state.copyWith(
            refundRequestStatus: GetRefundRequestStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.error));
    }
  }
}
