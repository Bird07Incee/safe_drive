import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';
import 'package:marketplace_line_oa/src/presentation/widget/snackbar/mkp_toast.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

part 'order_success_event.dart';
part 'order_success_state.dart';

class OrderSuccessBloc extends Bloc<OrderSuccessEvent, OrderSuccessState> {
  OrderSuccessBloc({required this.utilityRepository}) : super(OrderSuccessState()) {
    on<GetOrderSuccess>(_onGetOrderSuccess);
    // on<GetOrderSuccessMock>(_onGetOrderSuccessMock);
    on<SetOrderStatus>(_onSetOrderStatus);
  }

  final DioUtilityRepository utilityRepository;

  _onSetOrderStatus(SetOrderStatus event, Emitter<OrderSuccessState> emit) {
    emit(state.copyWith(orderSuccessStatus: event.status));
  }

  _onGetOrderSuccess(GetOrderSuccess event, Emitter<OrderSuccessState> emit) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_BASE_URL");
    final inquriyPath = Environment().getValue("INQUIRY_URL");
    // final ctx = ScaffoldMessenger.of(event.context);
    String accessToken = await lineDataHelper.getLineAccessToken();
    String uid = await lineDataHelper.getLineUid();

    var payload = {"invoiceNo": event.invoiceNo, "uid": uid};
    emit(state.copyWith(orderSuccessStatus: GetOrderSuccessDataStatus.loading));
    try {
      Response response =
          await utilityRepository.postByURL("$baseUrl$transactionApiPath$inquriyPath", payload, headers: {"Authorization": "Bearer $accessToken"});

      final InquiryData inquiryData = InquiryData.fromJson(response.data["rawData"]);
      String status = response.data["status"] ?? "";

      if (status == "Complete") {
        emit(state.copyWith(orderSuccessData: inquiryData, orderSuccessStatus: GetOrderSuccessDataStatus.success));

        if (!event.bypassContext) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(event.context).showSnackBar(getMkpToast("จัดส่งให้ทางอีเมลของคุณ เรียบร้อยแล้ว"));
        }
      } else if (status == "Pending") {
        int tick = 0;
        while (true) {
          if (tick == 90) {
            emit(state.copyWith(orderSuccessStatus: GetOrderSuccessDataStatus.error));
            break;
          }
          await Future.delayed(Duration(seconds: 8));
          Response response = await utilityRepository
              .postByURL("$baseUrl$transactionApiPath$inquriyPath", payload, headers: {"Authorization": "Bearer $accessToken"});
          final InquiryData inquiryData = InquiryData.fromJson(response.data["rawData"]);
          String status = response.data["status"] ?? "";
          if (status == "Complete") {
            emit(state.copyWith(orderSuccessData: inquiryData, orderSuccessStatus: GetOrderSuccessDataStatus.success));
            if (!event.bypassContext) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(event.context).showSnackBar(getMkpToast("จัดส่งให้ทางอีเมลของคุณ เรียบร้อยแล้ว"));
            }
            break;
          } else if (status == "Fail") {
            emit(state.copyWith(orderSuccessStatus: GetOrderSuccessDataStatus.cancel));
          }
          tick++;
        }
      } else if (status == "Fail") {
        emit(state.copyWith(orderSuccessStatus: GetOrderSuccessDataStatus.cancel));
      } else {
        emit(state.copyWith(orderSuccessStatus: GetOrderSuccessDataStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(orderSuccessStatus: GetOrderSuccessDataStatus.error));
    }
  }

  // _onGetOrderSuccessMock(GetOrderSuccessMock event, Emitter<OrderSuccessState> emit) async {
  // final mockJson = {
  //   "invoiceNo": "qweqwe",
  //   "cardNo": "987654******1234",
  //   "paymentDate": "1 ตุลาคม 2566",
  //   "paymentTime": "09:54:22",
  //   "paymentGateway": "บัตรเครดิต/เดบิต(ผ่าน 2C2P)",
  //   "paymentChannel": "ผ่อนชำระ 6 เดือน",
  //   "productImagePath": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_1.png",
  //   "productId": "PM12345678",
  //   "productName": "Pulsar Max from mercury-mocker",
  //   "productOption": "สีดำ ความยาวสาย 3 เมตร",
  //   "amount": "56640",
  //   "customerFullname": "กรุงศรี ออโต้",
  //   "customerMobile": "0812345678",
  //   "customerEmail": "k_auto@krungsri.com",
  //   "customerAddress": "898 อาคารเพลินจิตทาวเวอร์ ถนนเพลินจิต แขวงลุมพินี เขตปทุมวัน กรุงเทพมหานคร 10330",
  //   "merchantFullName": "บริษัท อินโนพาวเวอร์ จำกัด",
  //   "merchantAddress": "บริษัท อินโนพาวเวอร์ จำกัด\nชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 \nแขวงพญาไท เขตพญาไท กทม 10400",
  //   "merchantMobile": "0918620511"
  // };

  //   final InquiryData mock = InquiryData.fromJson(mockJson);

  //   emit(state.copyWith(orderSuccessStatus: GetOrderSuccessDataStatus.loading));

  //   final ctx = ScaffoldMessenger.of(event.context);

  //   await Future.delayed(Duration(seconds: 2));

  //   emit(state.copyWith(orderSuccessData: mock, orderSuccessStatus: GetOrderSuccessDataStatus.success));

  //   ctx.showSnackBar(getMkpToast("จัดส่งให้ทางอีเมลของคุณ เรียบร้อยแล้ว"));
  // }
}
