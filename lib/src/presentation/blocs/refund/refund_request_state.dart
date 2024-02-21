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
      this.isShowEditIconReason = false,
      this.isShowEditIconRemark = false,
      required this.getTextReason,
      required this.getTextRemark});

  final GetRefundRequestStatus refundRequestStatus;
  final RefundRequestModel refundRequestData;
  final InquiryData inquiryData;
  final List<DropdownAddressModel> reasonList;
  final bool isShowEditIconReason;
  final bool isShowEditIconRemark;
  final TextEditingController getTextReason;
  final TextEditingController getTextRemark;

  @override
  List<Object> get props => [
        refundRequestStatus,
        refundRequestData,
        inquiryData,
        reasonList,
        isShowEditIconReason,
        isShowEditIconRemark,
        getTextReason,
        getTextRemark
      ];

  RefundRequestState copyWith(
      {GetRefundRequestStatus? refundRequestStatus,
      RefundRequestModel? refundRequestData,
      InquiryData? inquiryData,
      List<DropdownAddressModel>? reasonList,
      bool? isShowEditIconReason,
      bool? isShowEditIconRemark,
      TextEditingController? getTextReason,
      TextEditingController? getTextRemark}) {
    return RefundRequestState(
        refundRequestStatus: refundRequestStatus ?? this.refundRequestStatus,
        refundRequestData: refundRequestData ?? this.refundRequestData,
        inquiryData: inquiryData ?? this.inquiryData,
        reasonList: reasonList ?? this.reasonList,
        isShowEditIconReason: isShowEditIconReason ?? this.isShowEditIconReason,
        isShowEditIconRemark: isShowEditIconRemark ?? this.isShowEditIconRemark,
        getTextReason: getTextReason ?? this.getTextReason,
        getTextRemark: getTextRemark ?? this.getTextRemark);
  }
}
