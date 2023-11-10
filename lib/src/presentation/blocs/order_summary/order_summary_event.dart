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

class CreateOrder extends OrderSummaryEvent {
  const CreateOrder({required this.requestModel});
  final CreateOrderRequestModel requestModel;

  @override
  List<Object?> get props => [requestModel];
}

class InitialOrderState extends OrderSummaryEvent {
  const InitialOrderState();
}
