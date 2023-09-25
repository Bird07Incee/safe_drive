class ProductDetailPromotionDetailModel {
  List<String>? promotionTags = [];

  ProductDetailPromotionDetailModel({
    this.promotionTags,
  });

  factory ProductDetailPromotionDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailPromotionDetailModel(
      promotionTags: json['promotionTags'],
    );
  }
}
