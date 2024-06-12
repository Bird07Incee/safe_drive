part of 'order_success_bloc.dart';

enum GetOrderSuccessDataStatus { initial, loading, success, cancel, error }

const defaultInquiryData = {
  "invoiceNo": "",
  "cardNo": "",
  "paymentDate": "",
  "paymentTime": "",
  "paymentGateway": "",
  "paymentChannel": "",
  "merchantFullName": "",
  "productImagePath": "",
  "productId": "",
  "productName": "",
  "productOption": "",
  "amount": "",
  "customerFullname": "",
  "customerMobile": "",
  "customerEmail": "",
  "customerAddress": "",
  "merchantAddress": "",
  "merchantMobile": "",
  "installmentPeriod": "",
  "paymentChannelText": ""
};

class OrderSuccessState extends Equatable {
  const OrderSuccessState(
      {this.orderSuccessStatus = GetOrderSuccessDataStatus.initial,
      this.isFromOrderSuccess = false,
      this.orderSuccessData = const InquiryData(
          invoiceNo: "",
          cardNo: "",
          paymentDate: "",
          paymentTime: "",
          paymentGateway: "",
          paymentChannel: "",
          merchantFullName: "",
          productImagePath: "",
          productId: "",
          productName: "",
          productOption: "",
          amount: "",
          customerFullname: "",
          customerMobile: "",
          customerEmail: "",
          customerAddress: "",
          merchantAddress: "",
          merchantMobile: "",
          installmentPeriod: "",
          paymentChannelText: "")});

  final GetOrderSuccessDataStatus orderSuccessStatus;
  final InquiryData orderSuccessData;
  final bool isFromOrderSuccess;

  @override
  List<Object> get props => [orderSuccessStatus, orderSuccessData, isFromOrderSuccess];

  OrderSuccessState copyWith({GetOrderSuccessDataStatus? orderSuccessStatus, InquiryData? orderSuccessData, bool? isFromOrderSuccess}) {
    return OrderSuccessState(
        orderSuccessData: orderSuccessData ?? this.orderSuccessData,
        orderSuccessStatus: orderSuccessStatus ?? this.orderSuccessStatus,
        isFromOrderSuccess: isFromOrderSuccess ?? this.isFromOrderSuccess);
  }
}
