import 'package:equatable/equatable.dart';

class OrderResponseModel extends Equatable {
  const OrderResponseModel({this.orderNo, this.paymentURL});
  final String? orderNo;
  final String? paymentURL;

  static const empty = OrderResponseModel(orderNo: "", paymentURL: "");

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(orderNo: json['orderNo'] ?? '', paymentURL: json['paymentURL'] ?? '');
  }

  @override
  List<Object?> get props => [orderNo, paymentURL];
}
