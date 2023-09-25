class ProductDetailProductDescriptionModel {
  String? tabGeneralDetailHtmlData;
  String? tabEtcDetailHtmlData;

  ProductDetailProductDescriptionModel({
    this.tabGeneralDetailHtmlData = "",
    this.tabEtcDetailHtmlData = "",
  });

  factory ProductDetailProductDescriptionModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailProductDescriptionModel(
      tabGeneralDetailHtmlData: json['tabGeneralDetailHtmlData'],
      tabEtcDetailHtmlData: json['tabEtcDetailHtmlData'],
    );
  }
}
