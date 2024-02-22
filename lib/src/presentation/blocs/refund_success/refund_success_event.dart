import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RefundSuccessEvent extends Equatable {
  const RefundSuccessEvent();

  @override
  List<Object> get props => [];
}

class GetRefundSuccess extends RefundSuccessEvent {
  const GetRefundSuccess(this.context, this.invoiceNo, {this.bypassContext = false});

  final BuildContext context;
  final String invoiceNo;
  final bool bypassContext;
}
