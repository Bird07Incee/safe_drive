part of 'order_success_bloc.dart';

class OrderSuccessEvent extends Equatable {
  const OrderSuccessEvent();

  @override
  List<Object> get props => [];
}

// class GetOrderSuccessMock extends OrderSuccessEvent {
//   const GetOrderSuccessMock(this.context);

//   final BuildContext context;
// }

class GetOrderSuccess extends OrderSuccessEvent {
  const GetOrderSuccess(this.context, this.invoiceNo, {this.bypassContext = false});

  final BuildContext context;
  final String invoiceNo;
  final bool bypassContext;
}

class SetOrderStatus extends OrderSuccessEvent {
  const SetOrderStatus(this.status);

  final GetOrderSuccessDataStatus status;
}

class SetIsFromOrderSuccess extends OrderSuccessEvent {
  const SetIsFromOrderSuccess(this.isFrom);

  final bool isFrom;
}
