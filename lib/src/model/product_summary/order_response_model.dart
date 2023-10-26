class OrderResponseModel {
  const OrderResponseModel({this.orderNo, this.paymentURL});
  final String? orderNo;
  final String? paymentURL;

  static const empty = OrderResponseModel(orderNo: "", paymentURL: "");

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(orderNo: json['orderNo'] ?? '', paymentURL: json['paymentURL'] ?? '');
  }
}
