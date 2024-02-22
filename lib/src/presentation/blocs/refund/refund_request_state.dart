part of 'refund_request_bloc.dart';

enum GetRefundRequestStatus { initial, loading, success, empty, error }

class RefundRequestState extends Equatable {
  const RefundRequestState(
      {this.refundRequestStatus = GetRefundRequestStatus.initial,
      this.refundRequestData = const RefundRequestModel(
        status: '',
        refundInfo: RefundInfoModel.empty,
        product: Product.empty,
      ),
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
      required this.getTextReason,
      required this.getTextRemark,
      required this.orderNo});

  final GetRefundRequestStatus refundRequestStatus;
  final RefundRequestModel refundRequestData;
  final InquiryData inquiryData;
  final List<DropdownAddressModel> reasonList;
  final TextEditingController getTextReason;
  final TextEditingController getTextRemark;
  final String orderNo;

  @override
  List<Object> get props => [
        refundRequestStatus,
        refundRequestData,
        inquiryData,
        reasonList,
        getTextReason,
        getTextRemark,
        orderNo
      ];

  RefundRequestState copyWith(
      {GetRefundRequestStatus? refundRequestStatus,
      RefundRequestModel? refundRequestData,
      InquiryData? inquiryData,
      List<DropdownAddressModel>? reasonList,
      TextEditingController? getTextReason,
      TextEditingController? getTextRemark,
      String? orderNo}) {
    return RefundRequestState(
        refundRequestStatus: refundRequestStatus ?? this.refundRequestStatus,
        refundRequestData: refundRequestData ?? this.refundRequestData,
        inquiryData: inquiryData ?? this.inquiryData,
        reasonList: reasonList ?? this.reasonList,
        getTextReason: getTextReason ?? this.getTextReason,
        getTextRemark: getTextRemark ?? this.getTextRemark,
        orderNo: orderNo ?? this.orderNo);
  }
}
