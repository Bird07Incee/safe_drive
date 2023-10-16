class InquiryData {
  String? refId;
  String? paymentCard;
  String? paymentDate;
  String? paymentTime;
  String? paymentMedthod;
  String? paymentPeriod;
  String? paymentMerchant;
  String? productAsset;
  String? productId;
  String? productName;
  List<String>? productAttr;
  String? productPrice;
  String? customerName;
  String? customerTel;
  String? customerEmail;
  String? customerAddress;
  String? sellerAddress;
  String? sellerTel;

  InquiryData(
      {this.refId,
      this.paymentCard,
      this.paymentDate,
      this.paymentTime,
      this.paymentMedthod,
      this.paymentPeriod,
      this.paymentMerchant,
      this.productAsset,
      this.productId,
      this.productName,
      this.productAttr,
      this.productPrice,
      this.customerName,
      this.customerTel,
      this.customerEmail,
      this.customerAddress,
      this.sellerAddress,
      this.sellerTel});

  InquiryData.fromJson(Map<String, dynamic> json) {
    refId = json['refId'];
    paymentCard = json['payment_card'];
    paymentDate = json['payment_date'];
    paymentTime = json['payment_time'];
    paymentMedthod = json['payment_medthod'];
    paymentPeriod = json['payment_period'];
    paymentMerchant = json['payment_merchant'];
    productAsset = json['product_asset'];
    productId = json['product_id'];
    productName = json['product_name'];
    productAttr = json['product_attr'].cast<String>();
    productPrice = json['product_price'];
    customerName = json['customer_name'];
    customerTel = json['customer_tel'];
    customerEmail = json['customer_email'];
    customerAddress = json['customer_address'];
    sellerAddress = json['seller_address'];
    sellerTel = json['seller_tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refId'] = this.refId;
    data['payment_card'] = this.paymentCard;
    data['payment_date'] = this.paymentDate;
    data['payment_time'] = this.paymentTime;
    data['payment_medthod'] = this.paymentMedthod;
    data['payment_period'] = this.paymentPeriod;
    data['payment_merchant'] = this.paymentMerchant;
    data['product_asset'] = this.productAsset;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_attr'] = this.productAttr;
    data['product_price'] = this.productPrice;
    data['customer_name'] = this.customerName;
    data['customer_tel'] = this.customerTel;
    data['customer_email'] = this.customerEmail;
    data['customer_address'] = this.customerAddress;
    data['seller_address'] = this.sellerAddress;
    data['seller_tel'] = this.sellerTel;
    return data;
  }
}
