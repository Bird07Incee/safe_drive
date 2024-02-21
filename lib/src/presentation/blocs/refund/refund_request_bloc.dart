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
      : super(RefundRequestState()) {

    on<RefundRequestEvent>((event, emit) {
// TODO: implement event handler
    });

    on<SetRefundData>(_onSetRefundData);
    on<OnSelectReason>(_onSelectReason);
  }

  _onSetRefundData(SetRefundData event, Emitter<RefundRequestState> emit) async {
    emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.loading));

    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue(
        "BFF_TRANSACTION_BASE_URL");
    final inquriyPath = Environment().getValue("INQUIRY_URL");
    // final ctx = ScaffoldMessenger.of(event.context);
    String accessToken = await lineDataHelper.getLineAccessToken();
    String uid = await lineDataHelper.getLineUid();

    var payload = {"invoiceNo": event.orderNo, "uid": uid};

    try {
      Response response =
      await utilityRepository.postByURL(
          "$baseUrl$transactionApiPath$inquriyPath", payload,
          headers: {"Authorization": "Bearer $accessToken"});

      final InquiryData inquiryData = InquiryData.fromJson(
          response.data["rawData"]);
      String status = response.data["status"] ?? "";

      if (status == "Complete") {
        List<DropdownAddressModel> mockReasonList = [
          DropdownAddressModel(id: "1", nameTh: "เปลื่ยนใจ"),
          DropdownAddressModel(id: "2", nameTh: "ได้รับสินค้าไม่ตรงตามที่สั่ง"),
          DropdownAddressModel(id: "3", nameTh: "สินค้าสภาพไม่ดี หรือมีความเสียหาย"),
          DropdownAddressModel(id: "4", nameTh: "ฉันไม่ได้รับพัสดุของคำสั่งซื้อนี้"),
          DropdownAddressModel(id: "5", nameTh: "ได้รับสินค้าไม่ครบ หรือชิ้นส่วนไม่สมบูรณ์"),
          DropdownAddressModel(id: "6", nameTh: "การทำงานของสินค้าไม่สมบูรณ์")
        ];
        event.reasonList!.addAll(mockReasonList);

        emit(state.copyWith(inquiryData: inquiryData, reasonList: event.reasonList,
            refundRequestStatus: GetRefundRequestStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.error));
    }
  }

  _onSelectReason(OnSelectReason event, Emitter<RefundRequestState> emit) async {
  //   emit(state.copyWith(refundRequestData: RefundRequestModel(refundInfo: RefundInfoModel(reason: reason, refundNo: '', refundDate: '', refundTime: '', remark: ''), status: '', product: null),
  //       refundRequestStatus: GetRefundRequestStatus.success));
    emit(state.copyWith(refundRequestStatus: GetRefundRequestStatus.success));

   }
}

