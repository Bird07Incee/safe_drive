import 'package:equatable/equatable.dart';

class RefundSuccessDataModel extends Equatable {
  const RefundSuccessDataModel(
      {required this.status,
      required this.refundNo,
      required this.refundDate,
      required this.refundTime,
      required this.reason,
      required this.remark,
      required this.invoiceNo,
      required this.cardNo,
      required this.paymentDate,
      required this.paymentTime,
      required this.paymentGateway,
      required this.paymentChannel,
      required this.merchantFullName,
      required this.productImagePath,
      required this.productId,
      required this.productName,
      required this.productOption,
      required this.amount,
      required this.customerFullname,
      required this.customerMobile,
      required this.customerEmail,
      required this.customerAddress,
      required this.merchantAddress,
      required this.merchantMobile,
      required this.installmentPeriod,
      required this.paymentChannelText});

  final String? status;
  final String? refundNo;
  final String? refundDate;
  final String? refundTime;
  final String? reason;
  final String? remark;
  final String? invoiceNo;
  final String? cardNo;
  final String? paymentDate;
  final String? paymentTime;
  final String? paymentGateway;
  final String? paymentChannel;
  final String? merchantFullName;
  final String? productImagePath;
  final String? productId;
  final String? productName;
  final String? productOption;
  final String? amount;
  final String? customerFullname;
  final String? customerMobile;
  final String? customerEmail;
  final String? customerAddress;
  final String? merchantAddress;
  final String? merchantMobile;
  final String? installmentPeriod;
  final String? paymentChannelText;

  RefundSuccessDataModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] ?? "",
        refundNo = json['refundInfo']['refundNo'] ?? "",
        refundDate = json['refundInfo']['refundDate'] ?? "",
        refundTime = json['refundInfo']['refundTime'] ?? "",
        reason = json['refundInfo']['reason'] ?? "",
        remark = json['refundInfo']['remark'] ?? "",
        invoiceNo = json['rawData']['invoiceNo'] ?? "",
        cardNo = json['rawData']['cardNo'] ?? "",
        paymentDate = json['rawData']['paymentDate'] ?? "",
        paymentTime = json['rawData']['paymentTime'] ?? "",
        paymentGateway = json['rawData']['paymentGateway'] ?? "",
        paymentChannel = json['rawData']['paymentChannel'] ?? "",
        merchantFullName = json['rawData']['merchantFullName'] ?? "",
        productImagePath = json['rawData']['productImagePath'] ?? "",
        productId = json['rawData']['productId'] ?? "",
        productName = json['rawData']['productName'] ?? "",
        productOption = json['rawData']['productOption'] ?? "",
        amount = json['rawData']['amount'] ?? "",
        customerFullname = json['rawData']['customerFullname'] ?? "",
        customerMobile = json['rawData']['customerMobile'] ?? "",
        customerEmail = json['rawData']['customerEmail'] ?? "",
        customerAddress = json['rawData']['customerAddress'] ?? "",
        merchantAddress = json['rawData']['merchantAddress'] ?? "",
        merchantMobile = json['rawData']['merchantMobile'] ?? "",
        installmentPeriod = json['rawData']['installmentPeriod'] ?? "",
        paymentChannelText = json['rawData']['paymentChannelText'] ?? "";

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['invoiceNo'] = invoiceNo;
  //   data['cardNo'] = cardNo;
  //   data['paymentDate'] = paymentDate;
  //   data['paymentTime'] = paymentTime;
  //   data['paymentGateway'] = paymentGateway;
  //   data['paymentChannel'] = paymentChannel;
  //   data['merchantFullName'] = merchantFullName;
  //   data['productImagePath'] = productImagePath;
  //   data['productId'] = productId;
  //   data['productName'] = productName;
  //   data['productOption'] = productOption;
  //   data['amount'] = amount;
  //   data['customerFullname'] = customerFullname;
  //   data['customerMobile'] = customerMobile;
  //   data['customerEmail'] = customerEmail;
  //   data['customerAddress'] = customerAddress;
  //   data['merchantAddress'] = merchantAddress;
  //   data['merchantMobile'] = merchantMobile;
  //   data['installmentPeriod'] = installmentPeriod;
  //   data['paymentChannelText'] = paymentChannelText;
  //   return data;
  // }

  @override
  List<Object?> get props => [
        status,
        refundNo,
        refundDate,
        refundTime,
        reason,
        remark,
        invoiceNo,
        cardNo,
        paymentDate,
        paymentTime,
        paymentGateway,
        paymentChannel,
        merchantFullName,
        productImagePath,
        productId,
        productName,
        productOption,
        amount,
        customerFullname,
        customerMobile,
        customerEmail,
        customerAddress,
        merchantAddress,
        merchantMobile,
        installmentPeriod,
        paymentChannelText
      ];

  static const empty = RefundSuccessDataModel(
      status: '',
      refundNo: '',
      refundDate: '',
      refundTime: '',
      reason: '',
      remark: '',
      invoiceNo: '',
      cardNo: '',
      paymentDate: '',
      paymentTime: '',
      paymentGateway: '',
      paymentChannel: '',
      merchantFullName: '',
      productImagePath: '',
      productId: '',
      productName: '',
      productOption: '',
      amount: '',
      customerFullname: '',
      customerMobile: '',
      customerEmail: '',
      customerAddress: '',
      merchantAddress: '',
      merchantMobile: '',
      installmentPeriod: '',
      paymentChannelText: '');
}
