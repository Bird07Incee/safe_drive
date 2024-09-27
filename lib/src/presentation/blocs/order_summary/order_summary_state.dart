part of 'order_summary_bloc.dart';

enum PaymentType { fullPayment, installment, none }

enum OrderStatus { initial, loading, success, error, noStock }

extension PaymentTypeX on PaymentType {
  bool get isFullPayment => this == PaymentType.fullPayment;
  bool get isInstallment => this == PaymentType.installment;
  bool get isNone => this == PaymentType.none;
}

extension OrderStatusX on OrderStatus {
  bool get isInitial => this == OrderStatus.initial;
  bool get isLoading => this == OrderStatus.loading;
  bool get isSuccess => this == OrderStatus.success;
  bool get isError => this == OrderStatus.error;
  bool get isNoStock => this == OrderStatus.noStock;
}

class OrderSummaryState extends Equatable {
  const OrderSummaryState(
      {this.paymentType = PaymentType.none, this.orderStatus = OrderStatus.initial, this.orderResponseModel = OrderResponseModel.empty});
  final PaymentType paymentType;
  final OrderStatus orderStatus;
  final OrderResponseModel orderResponseModel;

  OrderSummaryState copyWith({PaymentType? paymentType, OrderStatus? orderStatus, OrderResponseModel? orderResponseModel}) {
    return OrderSummaryState(
        paymentType: paymentType ?? this.paymentType,
        orderStatus: orderStatus ?? this.orderStatus,
        orderResponseModel: orderResponseModel ?? this.orderResponseModel);
  }

  @override
  List<Object> get props => [paymentType, orderStatus, orderResponseModel];
}
