part of 'order_summary_bloc.dart';

class OrderSummaryEvent extends Equatable {
  const OrderSummaryEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SelectPaymentType extends OrderSummaryEvent {
  const SelectPaymentType({this.paymentType = PaymentType.fullPayment});
  final PaymentType paymentType;

  @override
  List<Object?> get props => [paymentType];
}
