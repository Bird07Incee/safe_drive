part of 'refund_request_bloc.dart';

enum GetRefundRequestStatus { initial, loading, success, empty, error, submitSuccess, submitFail }

class RefundRequestState extends Equatable {
  const RefundRequestState(
      {this.refundRequestStatus = GetRefundRequestStatus.initial,
      this.inquiryData = const InquiryData(
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
          paymentChannelText: ""),
      this.reasonList = const <DropdownAddressModel>[],
      this.getTextReason = "",
      this.getTextRemark = "",
      required this.orderNo,
      required this.refundResponse});

  final GetRefundRequestStatus refundRequestStatus;
  final InquiryData inquiryData;
  final List<DropdownAddressModel> reasonList;
  final String getTextReason;
  final String getTextRemark;
  final String orderNo;
  final Map<String, dynamic> refundResponse;

  @override
  List<Object> get props => [refundRequestStatus, inquiryData, reasonList, getTextReason, getTextRemark, orderNo, refundResponse];

  RefundRequestState copyWith(
      {GetRefundRequestStatus? refundRequestStatus,
      InquiryData? inquiryData,
      List<DropdownAddressModel>? reasonList,
      String? getTextReason,
      String? getTextRemark,
      String? orderNo,
      Map<String, dynamic>? refundResponse}) {
    return RefundRequestState(
        refundRequestStatus: refundRequestStatus ?? this.refundRequestStatus,
        inquiryData: inquiryData ?? this.inquiryData,
        reasonList: reasonList ?? this.reasonList,
        getTextReason: getTextReason ?? this.getTextReason,
        getTextRemark: getTextRemark ?? this.getTextRemark,
        orderNo: orderNo ?? this.orderNo,
        refundResponse: refundResponse ?? this.refundResponse);
  }
}
