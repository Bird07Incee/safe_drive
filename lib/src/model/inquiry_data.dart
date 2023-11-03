import 'package:equatable/equatable.dart';

class InquiryData extends Equatable {
  const InquiryData(
      {required this.invoiceNo,
      required this.paymentCard,
      required this.paymentDate,
      required this.paymentTime,
      required this.paymentMedthod,
      required this.paymentPeriod,
      required this.paymentMerchant,
      required this.productAsset,
      required this.productId,
      required this.productName,
      required this.productAttr,
      required this.productPrice,
      required this.customerName,
      required this.customerTel,
      required this.customerEmail,
      required this.customerAddress,
      required this.sellerAddress,
      required this.sellerTel});

  final String? invoiceNo;
  final String? paymentCard;
  final String? paymentDate;
  final String? paymentTime;
  final String? paymentMedthod;
  final String? paymentPeriod;
  final String? paymentMerchant;
  final String? productAsset;
  final String? productId;
  final String? productName;
  final List<String>? productAttr;
  final String? productPrice;
  final String? customerName;
  final String? customerTel;
  final String? customerEmail;
  final String? customerAddress;
  final String? sellerAddress;
  final String? sellerTel;

  InquiryData.fromJson(Map<String, dynamic> json)
      : invoiceNo = json['invoiceNo'] ?? "",
        paymentCard = json['payment_card'] ?? "",
        paymentDate = json['payment_date'] ?? "",
        paymentTime = json['payment_time'] ?? "",
        paymentMedthod = json['payment_medthod'] ?? "",
        paymentPeriod = json['payment_period'] ?? "",
        paymentMerchant = json['payment_merchant'] ?? "",
        productAsset = json['product_asset'] ?? "",
        productId = json['product_id'] ?? "",
        productName = json['product_name'] ?? "",
        productAttr = json['product_attr'].cast<String>() ?? [],
        productPrice = json['product_price'] ?? "",
        customerName = json['customer_name'] ?? "",
        customerTel = json['customer_tel'] ?? "",
        customerEmail = json['customer_email'] ?? "",
        customerAddress = json['customer_address'] ?? "",
        sellerAddress = json['seller_address'] ?? "",
        sellerTel = json['seller_tel'] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoiceNo'] = invoiceNo;
    data['payment_card'] = paymentCard;
    data['payment_date'] = paymentDate;
    data['payment_time'] = paymentTime;
    data['payment_medthod'] = paymentMedthod;
    data['payment_period'] = paymentPeriod;
    data['payment_merchant'] = paymentMerchant;
    data['product_asset'] = productAsset;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_attr'] = productAttr;
    data['product_price'] = productPrice;
    data['customer_name'] = customerName;
    data['customer_tel'] = customerTel;
    data['customer_email'] = customerEmail;
    data['customer_address'] = customerAddress;
    data['seller_address'] = sellerAddress;
    data['seller_tel'] = sellerTel;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        invoiceNo,
        paymentCard,
        paymentDate,
        paymentTime,
        paymentMedthod,
        paymentPeriod,
        paymentMerchant,
        productAsset,
        productId,
        productName,
        productAttr,
        productPrice,
        customerName,
        customerTel,
        customerEmail,
        customerAddress,
        sellerAddress,
        sellerTel,
      ];
}
