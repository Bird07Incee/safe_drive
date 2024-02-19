import 'package:equatable/equatable.dart';

class InquiryData extends Equatable {
  const InquiryData(
      {required this.invoiceNo,
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

  InquiryData.fromJson(Map<String, dynamic> json)
      : invoiceNo = json['invoiceNo'] ?? "",
        cardNo = json['cardNo'] ?? "",
        paymentDate = json['paymentDate'] ?? "",
        paymentTime = json['paymentTime'] ?? "",
        paymentGateway = json['paymentGateway'] ?? "",
        paymentChannel = json['paymentChannel'] ?? "",
        merchantFullName = json['merchantFullName'] ?? "",
        productImagePath = json['productImagePath'] ?? "",
        productId = json['productId'] ?? "",
        productName = json['productName'] ?? "",
        productOption = json['productOption'] ?? "",
        amount = json['amount'] ?? "",
        customerFullname = json['customerFullname'] ?? "",
        customerMobile = json['customerMobile'] ?? "",
        customerEmail = json['customerEmail'] ?? "",
        customerAddress = json['customerAddress'] ?? "",
        merchantAddress = json['merchantAddress'] ?? "",
        merchantMobile = json['merchantMobile'] ?? "",
        installmentPeriod = json['installmentPeriod'] ?? "",
        paymentChannelText = json['paymentChannelText'] ?? "";

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
  // TODO: implement props
  List<Object?> get props => [
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
}
