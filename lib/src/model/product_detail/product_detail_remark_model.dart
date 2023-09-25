class ProductDetailRemarkModel {
  String? productDetailRemarkHtmlData;

  ProductDetailRemarkModel({
    this.productDetailRemarkHtmlData = "",
  });

  factory ProductDetailRemarkModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailRemarkModel(
      productDetailRemarkHtmlData: json['productDetailRemarkHtmlData'],
    );
  }
}
