part of 'refund_request_bloc.dart';

class RefundRequestEvent extends Equatable {
  const RefundRequestEvent();

  @override
  List<Object> get props => [];
}

class SetRefundData extends RefundRequestEvent {
  const SetRefundData({required this.orderNo, required this.reasonList});

  final String? orderNo;
  final List<DropdownAddressModel>? reasonList;
}

class OnSelectReason extends RefundRequestEvent {
  const OnSelectReason({required this.getTextReason, required this.getTextRemark});
  final String getTextReason;
  final String getTextRemark;
}

class OnEditRemark extends RefundRequestEvent {
  const OnEditRemark({required this.getTextReason, required this.getTextRemark});
  final String getTextReason;
  final String getTextRemark;
}

class OnSubmitRefundData extends RefundRequestEvent {
  const OnSubmitRefundData();
}
