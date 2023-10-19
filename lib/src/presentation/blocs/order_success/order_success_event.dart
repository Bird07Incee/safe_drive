part of 'order_success_bloc.dart';

class OrderSuccessEvent extends Equatable {
  const OrderSuccessEvent();

  @override
  List<Object> get props => [];
}

class GetOrderSuccessMock extends OrderSuccessEvent {
  const GetOrderSuccessMock(this.context);

  final BuildContext context;
}
