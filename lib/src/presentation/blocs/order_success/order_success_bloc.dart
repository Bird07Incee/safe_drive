import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';
import 'package:marketplace_line_oa/src/presentation/widget/snackbar/mkp_toast.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

part 'order_success_event.dart';
part 'order_success_state.dart';

class OrderSuccessBloc extends Bloc<OrderSuccessEvent, OrderSuccessState> {
  OrderSuccessBloc() : super(OrderSuccessState()) {
    on<GetOrderSuccess>(_onGetOrderSuccess);
    on<GetOrderSuccessMock>(_onGetOrderSuccessMock);
  }

  _onGetOrderSuccess(GetOrderSuccess event, Emitter<OrderSuccessState> emit) async {
    DioUtilityRepository dioUtilityRepository = DioUtilityRepository(service: DioUtilityService());
    LineDataHelper lineDataHelper = LineDataHelper();
    // final baseUrl = Environment().getValue("BFF_BASE_URL");
    // final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();

    var payload = {"caller": "mkp", "invoiceNo": event.invoiceNo};

    emit(state.copyWith(orderSuccessStatus: GetOrderSuccessDataStatus.loading));

    try {
      Response response = await dioUtilityRepository.postByURL(
          "https://api.marketplace.ksauto.net/mercury-mocker-dev/query/inquiry-success", payload,
          headers: {"Authorization": "Bearer $accessToken"});

      final InquiryData inquiryData = InquiryData.fromJson(response.data["rawData"]);

      emit(state.copyWith(orderSuccessData: inquiryData, orderSuccessStatus: GetOrderSuccessDataStatus.success));
      ScaffoldMessenger.of(event.context).showSnackBar(getMkpToast("จัดส่งให้ทางอีเมลของคุณ เรียบร้อยแล้ว"));
    } catch (e) {
      emit(state.copyWith(orderSuccessStatus: GetOrderSuccessDataStatus.error));
    }
  }

  _onGetOrderSuccessMock(GetOrderSuccessMock event, Emitter<OrderSuccessState> emit) async {
    final mockJson = {
      "refId": "REF00005678",
      "payment_card": "987654******1234",
      "payment_date": "1 กันยายน 2566",
      "payment_time": "09:54:22",
      "payment_medthod": "บัตรเครดิต/เดบิต(ผ่าน 2C2P)",
      "payment_period": "ผ่อนชำระ 6 เดือน",
      "payment_merchant": "บริษัท อินโนพาวเวอร์ จำกัด",
      "product_asset": "image url",
      "product_id": "PM12345678",
      "product_name": "Pulsar Max",
      "product_attr": [
        "สีดำ",
        "ความยาวสาย 3 เมตร",
        "ทดสอบ1",
        "ทดสอบ2",
        "qwijdoiqjwdwefopkwepofjmoweinfoweinfoiwenfionwe"
      ],
      "product_price": "56,640",
      "customer_name": "กรุงศรี ออโต้",
      "customer_tel": "081-234-5678",
      "customer_email": "k_auto@krungsri.com",
      "customer_address": "898 อาคารเพลินจิตทาวเวอร์ ถนนเพลินจิต แขวงลุมพินี เขตปทุมวัน กรุงเทพมหานคร 10330",
      "seller_address":
          "บริษัท อินโนพาวเวอร์ จำกัด\nชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 \nแขวงพญาไท เขตพญาไท กทม 10400",
      "seller_tel": "091-862-0511"
    };

    final InquiryData mock = InquiryData.fromJson(mockJson);

    emit(state.copyWith(orderSuccessStatus: GetOrderSuccessDataStatus.loading));

    await Future.delayed(Duration(seconds: 2));

    emit(state.copyWith(orderSuccessData: mock, orderSuccessStatus: GetOrderSuccessDataStatus.success));

    ScaffoldMessenger.of(event.context).showSnackBar(getMkpToast("จัดส่งให้ทางอีเมลของคุณ เรียบร้อยแล้ว"));
  }
}
