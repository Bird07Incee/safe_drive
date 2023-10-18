import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';
import 'package:marketplace_line_oa/src/presentation/widget/snackbar/mkp_toast.dart';

part 'order_success_event.dart';
part 'order_success_state.dart';

class OrderSuccessBloc extends Bloc<OrderSuccessEvent, OrderSuccessState> {
  OrderSuccessBloc() : super(OrderSuccessState()) {
    on<GetOrderSuccessMock>(_onGetOrderSuccessMock);
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
      "product_attr": ["สีดำ", "ความยาวสาย 3 เมตร", "ทดสอบ1", "ทดสอบ2"],
      "product_price": "56640",
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
