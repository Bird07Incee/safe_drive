class ProductList {
  const ProductList({
    required this.productAllItems,
    required this.productPage,
    required this.productCountItems,
    required this.banner,
    required this.category,
    required this.products,
  });
  final int? productAllItems;
  final int? productPage;
  final int? productCountItems;
  final List<Banner>? banner;
  final List<String>? category;
  final List<Products>? products;

  ProductList.fromJson(Map<String, dynamic> json)
      : banner = List.from(json['banner']).map((e) => Banner.fromJson(e)).toList(),
        category = List.from(json['category']).map((e) => e as String).toList(),
        products = List.from(json['products']).map((e) => Products.fromJson(e)).toList(),
        productAllItems = json['productAllItems'] as int?,
        productPage = json['productPage'] as int?,
        productCountItems = json['productCountItems'] as int?;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productAllItems'] = productAllItems;
    _data['productPage'] = productPage;
    _data['productCountItems'] = productCountItems;
    _data['banner'] = banner?.map((e) => e.toJson()).toList();
    _data['category'] = category;
    _data['products'] = products?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Banner {
  Banner({
    required this.image,
    required this.route,
    required this.url,
  });
  late final String image;
  late final String route;
  late final String url;

  Banner.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    route = json['route'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['route'] = route;
    _data['url'] = url;
    return _data;
  }
}

class Products {
  Products({
    required this.appId,
    required this.channelId,
    required this.merchantId,
    required this.paymentChannelCode,
    required this.refundDay,
    required this.postDate,
    required this.lastUpdateDate,
    required this.categoryId,
    required this.category,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.productStatus,
    required this.commissionAmount,
    required this.serviceFee,
    required this.shippingFee,
    required this.tagline,
    required this.promotionTag,
    required this.description,
    required this.technicalSpec,
    required this.remark,
    required this.currency,
    required this.price,
    required this.discountPrice,
    required this.percentDiscountPrice,
    required this.productionAssets,
    required this.merchantFullName,
    required this.merchantAddress,
    required this.merchantLogo,
    required this.merchantMobile,
    required this.merchantEmail,
    required this.productionOptionals,
  });
  late final String appId;
  late final String channelId;
  late final String merchantId;
  late final String paymentChannelCode;
  late final int refundDay;
  late final String postDate;
  late final String lastUpdateDate;
  late final String categoryId;
  late final String category;
  late final String productId;
  late final int quantity;
  late final String productName;
  late final String productStatus;
  late final int commissionAmount;
  late final int serviceFee;
  late final int shippingFee;
  late final String tagline;
  late final List<String> promotionTag;
  late final String description;
  late final String technicalSpec;
  late final String remark;
  late final String currency;
  late final int price;
  late final int discountPrice;
  late final int percentDiscountPrice;
  late final List<String> productionAssets;
  late final String merchantFullName;
  late final String merchantAddress;
  late final String merchantLogo;
  late final String merchantMobile;
  late final String merchantEmail;
  late final List<ProductionOptionals> productionOptionals;

  Products.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    channelId = json['channelId'];
    merchantId = json['merchantId'];
    paymentChannelCode = json['paymentChannelCode'];
    refundDay = json['refundDay'];
    postDate = json['postDate'];
    lastUpdateDate = json['lastUpdateDate'];
    categoryId = json['categoryId'];
    category = json['category'];
    productId = json['productId'];
    quantity = json['quantity'];
    productName = json['productName'];
    productStatus = json['productStatus'];
    commissionAmount = json['commissionAmount'];
    serviceFee = json['serviceFee'];
    shippingFee = json['shippingFee'];
    tagline = json['tagline'];
    promotionTag = List.castFrom<dynamic, String>(json['promotionTag']);
    description = json['description'];
    technicalSpec = json['technicalSpec'];
    remark = json['remark'];
    currency = json['currency'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    percentDiscountPrice = json['percentDiscountPrice'];
    productionAssets = List.castFrom<dynamic, String>(json['productionAssets']);
    merchantFullName = json['merchantFullName'];
    merchantAddress = json['merchantAddress'];
    merchantLogo = json['merchantLogo'];
    merchantMobile = json['merchantMobile'];
    merchantEmail = json['merchantEmail'];
    productionOptionals = List.from(json['productionOptionals']).map((e) => ProductionOptionals.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['appId'] = appId;
    _data['channelId'] = channelId;
    _data['merchantId'] = merchantId;
    _data['paymentChannelCode'] = paymentChannelCode;
    _data['refundDay'] = refundDay;
    _data['postDate'] = postDate;
    _data['lastUpdateDate'] = lastUpdateDate;
    _data['categoryId'] = categoryId;
    _data['category'] = category;
    _data['productId'] = productId;
    _data['quantity'] = quantity;
    _data['productName'] = productName;
    _data['productStatus'] = productStatus;
    _data['commissionAmount'] = commissionAmount;
    _data['serviceFee'] = serviceFee;
    _data['shippingFee'] = shippingFee;
    _data['tagline'] = tagline;
    _data['promotionTag'] = promotionTag;
    _data['description'] = description;
    _data['technicalSpec'] = technicalSpec;
    _data['remark'] = remark;
    _data['currency'] = currency;
    _data['price'] = price;
    _data['discountPrice'] = discountPrice;
    _data['percentDiscountPrice'] = percentDiscountPrice;
    _data['productionAssets'] = productionAssets;
    _data['merchantFullName'] = merchantFullName;
    _data['merchantAddress'] = merchantAddress;
    _data['merchantLogo'] = merchantLogo;
    _data['merchantMobile'] = merchantMobile;
    _data['merchantEmail'] = merchantEmail;
    _data['productionOptionals'] = productionOptionals.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductionOptionals {
  ProductionOptionals({
    required this.label,
    required this.levelName,
    required this.image,
    required this.price,
    required this.subProductId,
    required this.quantity,
    required this.level2,
  });
  late final String label;
  late final String levelName;
  late final String image;
  late final int price;
  late final String subProductId;
  late final int quantity;
  late final List<Level2> level2;

  ProductionOptionals.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    levelName = json['levelName'];
    image = json['image'];
    price = json['price'];
    subProductId = json['subProductId'];
    quantity = json['quantity'];
    level2 = List.from(json['level2']).map((e) => Level2.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['label'] = label;
    _data['levelName'] = levelName;
    _data['image'] = image;
    _data['price'] = price;
    _data['subProductId'] = subProductId;
    _data['quantity'] = quantity;
    _data['level2'] = level2.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Level2 {
  Level2({
    required this.label,
    required this.levelName,
    required this.image,
    required this.price,
    required this.subProductId,
    required this.quantity,
  });
  late final String label;
  late final String levelName;
  late final String image;
  late final int price;
  late final String subProductId;
  late final int quantity;

  Level2.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    levelName = json['levelName'];
    image = json['image'];
    price = json['price'];
    subProductId = json['subProductId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['label'] = label;
    _data['levelName'] = levelName;
    _data['image'] = image;
    _data['price'] = price;
    _data['subProductId'] = subProductId;
    _data['quantity'] = quantity;
    return _data;
  }
}
