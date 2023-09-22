class ProductDetailHtmlDataModel {
  String? tabGeneralDetailHtmlData;
  String? tabEtcDetailHtmlData;
  String? aboutSellerHtmlData;
  String? promotionDetailHtmlData;
  String? remarkHtmlData;

  ProductDetailHtmlDataModel(
      {this.tabGeneralDetailHtmlData = "",
      this.tabEtcDetailHtmlData = "",
      this.aboutSellerHtmlData = "",
      this.promotionDetailHtmlData = "",
      this.remarkHtmlData = ""});

  factory ProductDetailHtmlDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailHtmlDataModel(
      tabGeneralDetailHtmlData: json['tabGeneralDetailHtmlData'],
      tabEtcDetailHtmlData: json['tabEtcDetailHtmlData'],
      aboutSellerHtmlData: json['aboutSellerHtmlData'],
      promotionDetailHtmlData: json['promotionDetailHtmlData'],
      remarkHtmlData: json['remarkHtmlData'],
    );
  }
}
