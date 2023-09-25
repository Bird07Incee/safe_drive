class ProductDetailAboutSellerModel {
  String? merchantName;
  String? merchantAddress;
  String? merchantMobile;

  ProductDetailAboutSellerModel(
      {this.merchantName = "",
      this.merchantAddress = "",
      this.merchantMobile = ""});

  factory ProductDetailAboutSellerModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailAboutSellerModel(
        merchantName: json['merchantName'],
        merchantAddress: json['merchantAddress'],
        merchantMobile: json['merchantMobile']);
  }
}
