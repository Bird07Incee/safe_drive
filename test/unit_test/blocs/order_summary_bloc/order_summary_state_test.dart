import 'package:flutter_test/flutter_test.dart';
import 'package:autoStation_promptBuy/src/presentation/blocs/order_summary/order_summary_bloc.dart';

void main() {
  group('PaymentTypeX ', () {
    test('returns correct values for PaymentType.fullPayment', () {
      const pt = PaymentType.fullPayment;
      expect(pt.isFullPayment, isTrue);
      expect(pt.isInstallment, isFalse);
      expect(pt.isNone, isFalse);
    });

    test('returns correct values for PaymentType.installment', () {
      const pt = PaymentType.installment;
      expect(pt.isFullPayment, isFalse);
      expect(pt.isInstallment, isTrue);
      expect(pt.isNone, isFalse);
    });

    test('returns correct values for PaymentType.none', () {
      const pt = PaymentType.none;
      expect(pt.isFullPayment, isFalse);
      expect(pt.isInstallment, isFalse);
      expect(pt.isNone, isTrue);
    });
  });

  group('OrderStatusX ', () {
    test('returns correct values for OrderStatus.initial', () {
      const status = OrderStatus.initial;
      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
    });

    test('returns correct values for OrderStatus.success', () {
      const status = OrderStatus.success;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isError, isFalse);
    });

    test('returns correct values for OrderStatus.loading', () {
      const status = OrderStatus.loading;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isFalse);
    });

    test('returns correct values for OrderStatus.error', () {
      const status = OrderStatus.error;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isError, isTrue);
    });
  });

  group("OrderSummaryState", (){
    test('supports comparisons', () {
      expect(const OrderSummaryState(), const OrderSummaryState().copyWith());
    });
  });
}