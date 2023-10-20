part of 'order_summary_bloc.dart';

enum PaymentType { fullPayment, installment }

extension PaymentTypeX on PaymentType {
  bool get isFullPayment => this == PaymentType.fullPayment;
  bool get isInstallment => this == PaymentType.installment;
}

class OrderSummaryState extends Equatable {
  const OrderSummaryState({this.paymentType = PaymentType.fullPayment});
  final PaymentType paymentType;

  OrderSummaryState copyWith({PaymentType? paymentType}) {
    return OrderSummaryState(paymentType: paymentType ?? this.paymentType);
  }

  @override
  List<Object> get props => [paymentType];
}
