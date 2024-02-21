part of 'refund_request_bloc.dart';

class RefundRequestEvent extends Equatable {
  const RefundRequestEvent();

  @override
  List<Object> get props => [];
}

class SetRefundData extends RefundRequestEvent {
  const SetRefundData({required this.orderNo, required this.reasonList,
    required this.isShowEditIconReason, required this.isShowEditIconRemark});

  final String? orderNo;
  final List<DropdownAddressModel>? reasonList;
  final bool isShowEditIconReason;
  final bool isShowEditIconRemark;

}

class OnSelectReason extends RefundRequestEvent {
  const OnSelectReason({required this.refundRequestModel});

  final RefundRequestModel refundRequestModel;
}
