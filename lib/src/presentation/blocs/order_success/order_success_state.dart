part of 'order_success_bloc.dart';

enum GetOrderSuccessDataStatus { initial, loading, success, cancel, error }

const defaultInquiryData = {
  "invoiceNo": "",
  "payment_card": "",
  "payment_date": "",
  "payment_time": "",
  "payment_medthod": "",
  "payment_period": "",
  "payment_merchant": "",
  "product_asset": "",
  "product_id": "",
  "product_name": "",
  "product_attr": [],
  "product_price": "",
  "customer_name": "",
  "customer_tel": "",
  "customer_email": "",
  "customer_address": "",
  "seller_address": "",
  "seller_tel": ""
};

class OrderSuccessState extends Equatable {
  const OrderSuccessState(
      {this.orderSuccessStatus = GetOrderSuccessDataStatus.initial,
      this.orderSuccessData = const InquiryData(
          invoiceNo: "",
          paymentCard: "",
          paymentDate: "",
          paymentTime: "",
          paymentMedthod: "",
          paymentPeriod: "",
          paymentMerchant: "",
          productAsset: "",
          productId: "",
          productName: "",
          productAttr: [],
          productPrice: "",
          customerName: "",
          customerTel: "",
          customerEmail: "",
          customerAddress: "",
          sellerAddress: "",
          sellerTel: "")});

  final GetOrderSuccessDataStatus orderSuccessStatus;
  final InquiryData orderSuccessData;

  @override
  List<Object> get props => [orderSuccessStatus, orderSuccessData];

  OrderSuccessState copyWith({GetOrderSuccessDataStatus? orderSuccessStatus, InquiryData? orderSuccessData}) {
    return OrderSuccessState(
        orderSuccessData: orderSuccessData ?? this.orderSuccessData, orderSuccessStatus: orderSuccessStatus ?? this.orderSuccessStatus);
  }
}
