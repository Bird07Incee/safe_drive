import 'package:marketplace_line_oa/src/model/product_list.dart';

extension RefundInfoModelX on RefundInfoModel {
  bool get isEmpty => this != RefundInfoModel.empty;
}

class RefundRequestModel {
  final String? status;
  final RefundInfoModel? refundInfo;
  final Product? product;

  const RefundRequestModel({required this.status, required this.refundInfo, required this.product});

  RefundRequestModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        refundInfo = json['refundInfo'] != null ? RefundInfoModel.fromJson(json['refundInfo']) : null,
        product = json['rawData'] != null ? Product.fromJson(json['rawData']) : null;
}

class RefundInfoModel {
  final String? refundNo;
  final String? refundDate;
  final String? refundTime;
  final String? reason;
  final String? remark;

  const RefundInfoModel({required this.refundNo, required this.refundDate, required this.refundTime, required this.reason, required this.remark});

  RefundInfoModel.fromJson(Map<String, dynamic> json)
      : refundNo = json['refundNo'],
        refundDate = json['refundDate'],
        refundTime = json['refundTime'],
        reason = json['reason'],
        remark = json['remark'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refundNo'] = refundNo;
    data['refundDate'] = refundDate;
    data['refundTime'] = refundTime;
    data['reason'] = reason;
    data['remark'] = remark;
    return data;
  }

  static const empty = RefundInfoModel(
    refundNo: '',
    refundDate: '',
    refundTime: '',
    reason: '',
    remark: '',
  );
}

// class Product {
//   String? invoiceNo;
//   String? cardNo;
//   String? paymentDate;
//   String? paymentTime;
//   String? paymentGateway;
//   String? paymentChannel;
//   String? amount;
//   String? merchantFullName;
//   String? merchantAddress;
//   String? merchantMobile;
//   String? productImagePath;
//   String? productId;
//   String? productOption;
//   String? productName;
//   String? customerFullname;
//   String? customerMobile;
//   String? customerEmail;
//   String? customerAddress;
//   String? installmentPeriod;
//   String? paymentChannelText;
//
//   Product(
//       {this.invoiceNo,
//         this.cardNo,
//         this.paymentDate,
//         this.paymentTime,
//         this.paymentGateway,
//         this.paymentChannel,
//         this.amount,
//         this.merchantFullName,
//         this.merchantAddress,
//         this.merchantMobile,
//         this.productImagePath,
//         this.productId,
//         this.productOption,
//         this.productName,
//         this.customerFullname,
//         this.customerMobile,
//         this.customerEmail,
//         this.customerAddress,
//         this.installmentPeriod,
//         this.paymentChannelText});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     invoiceNo = json['invoiceNo'];
//     cardNo = json['cardNo'];
//     paymentDate = json['paymentDate'];
//     paymentTime = json['paymentTime'];
//     paymentGateway = json['paymentGateway'];
//     paymentChannel = json['paymentChannel'];
//     amount = json['amount'];
//     merchantFullName = json['merchantFullName'];
//     merchantAddress = json['merchantAddress'];
//     merchantMobile = json['merchantMobile'];
//     productImagePath = json['productImagePath'];
//     productId = json['productId'];
//     productOption = json['productOption'];
//     productName = json['productName'];
//     customerFullname = json['customerFullname'];
//     customerMobile = json['customerMobile'];
//     customerEmail = json['customerEmail'];
//     customerAddress = json['customerAddress'];
//     installmentPeriod = json['installmentPeriod'];
//     paymentChannelText = json['paymentChannelText'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['invoiceNo'] = this.invoiceNo;
//     data['cardNo'] = this.cardNo;
//     data['paymentDate'] = this.paymentDate;
//     data['paymentTime'] = this.paymentTime;
//     data['paymentGateway'] = this.paymentGateway;
//     data['paymentChannel'] = this.paymentChannel;
//     data['amount'] = this.amount;
//     data['merchantFullName'] = this.merchantFullName;
//     data['merchantAddress'] = this.merchantAddress;
//     data['merchantMobile'] = this.merchantMobile;
//     data['productImagePath'] = this.productImagePath;
//     data['productId'] = this.productId;
//     data['productOption'] = this.productOption;
//     data['productName'] = this.productName;
//     data['customerFullname'] = this.customerFullname;
//     data['customerMobile'] = this.customerMobile;
//     data['customerEmail'] = this.customerEmail;
//     data['customerAddress'] = this.customerAddress;
//     data['installmentPeriod'] = this.installmentPeriod;
//     data['paymentChannelText'] = this.paymentChannelText;
//     return data;
//   }
// }
