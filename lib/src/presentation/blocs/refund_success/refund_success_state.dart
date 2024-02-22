import 'package:equatable/equatable.dart';
import 'package:marketplace_line_oa/src/model/refund_success_data_model.dart';

enum GetRefundSuccessDataStatus { initial, loading, success, cancel, error }

class RefundSuccessState extends Equatable {
  const RefundSuccessState(
      {this.refundSuccessStatus = GetRefundSuccessDataStatus.initial,
      this.refundSuccessData = const RefundSuccessDataModel(
          status: "",
          refundNo: "",
          refundDate: "",
          refundTime: "",
          reason: "",
          remark: "",
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

  final GetRefundSuccessDataStatus refundSuccessStatus;
  final RefundSuccessDataModel refundSuccessData;

  @override
  List<Object> get props => [refundSuccessStatus, refundSuccessData];

  RefundSuccessState copyWith({GetRefundSuccessDataStatus? refundSuccessStatus, RefundSuccessDataModel? refundSuccessData}) {
    return RefundSuccessState(
        refundSuccessData: refundSuccessData ?? this.refundSuccessData, refundSuccessStatus: refundSuccessStatus ?? this.refundSuccessStatus);
  }
}
