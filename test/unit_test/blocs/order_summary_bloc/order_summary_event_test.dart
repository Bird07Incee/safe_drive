import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/model/product_summary/create_order_request_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/order_summary_bloc.dart';

void main() {
  group("OrderSummaryEvent state", (){
    test("OrderSummaryEvent supports comparisons", (){
      expect(const OrderSummaryEvent().props, const OrderSummaryEvent().props);
    });

    test("SelectPaymentType supports comparisons", (){
      expect(SelectPaymentType(paymentType: PaymentType.installment).props, const SelectPaymentType(paymentType: PaymentType.installment).props);
    });

    test("CreateOrder supports comparisons", (){
      expect(CreateOrder(requestModel: CreateOrderRequestModel.empty).props, CreateOrder(requestModel: CreateOrderRequestModel.empty).props);
    });
  });
}