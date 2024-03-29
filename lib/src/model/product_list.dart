import 'package:equatable/equatable.dart';

class ProductList extends Equatable {
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
  final List<Map>? category;
  final List<Product>? products;

  ProductList.fromJson(Map<String, dynamic> json)
      : banner = json['banner'] != null ? List.from(json['banner']).map((e) => Banner.fromJson(e)).toList() : [],
        category = json['category'] != null ? List.from(json['category']).map((e) => e as Map).toList() : [],
        products = json['products'] != null ? List.from(json['products']).map((e) => Product.fromJson(e)).toList() : [],
        productAllItems = json['productAllItems'] != null ? json['productAllItems'] as int? : 0,
        productPage = json['productPage'] != null ? json['productPage'] as int? : 0,
        productCountItems = json['productCountItems'] != null ? json['productCountItems'] as int? : 0;

  @override
  // TODO: implement props
  List<Object?> get props => [productAllItems, productPage, productCountItems, banner, category, products];
}

class Banner extends Equatable {
  const Banner({
    required this.image,
    required this.route,
    required this.url,
    required this.seqNo,
  });

  final String image;
  final String route;
  final String url;
  final int seqNo;

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(image: json['image'] ?? '', route: json['route'] ?? '', url: json['url'] ?? '', seqNo: json['seqNo'] ?? '');
  }

  @override
  // TODO: implement props
  List<Object?> get props => [image, route, url, seqNo];
}

class Product extends Equatable {
  const Product({
    required this.appId,
    required this.merchantId,
    required this.paymentChannelCode,
    required this.refundDay,
    required this.postDate,
    required this.lastUpdateDate,
    required this.categoryId,
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

  final String appId;
  final String merchantId;
  final List<String> paymentChannelCode;
  final int refundDay;
  final String postDate;
  final String lastUpdateDate;
  final List<int> categoryId;
  final String productId;
  final int quantity;
  final String productName;
  final String productStatus;
  final int commissionAmount;
  final int serviceFee;
  final int shippingFee;
  final String tagline;
  final List<String> promotionTag;
  final String description;
  final String technicalSpec;
  final List<String> remark;
  final String currency;
  final int price;
  final int discountPrice;
  final int percentDiscountPrice;
  final List<String> productionAssets;
  final String merchantFullName;
  final String merchantAddress;
  final String merchantLogo;
  final String merchantMobile;
  final String merchantEmail;
  final List<ProductionOptionals> productionOptionals;

  static const empty = Product(
      appId: '',
      merchantId: '',
      paymentChannelCode: [],
      refundDay: 0,
      postDate: '',
      lastUpdateDate: '',
      categoryId: [],
      productId: '',
      quantity: 0,
      productName: '',
      productStatus: '',
      commissionAmount: 0,
      serviceFee: 0,
      shippingFee: 0,
      tagline: '',
      promotionTag: [],
      description: '',
      technicalSpec: '',
      remark: [],
      currency: '',
      price: 0,
      discountPrice: 0,
      percentDiscountPrice: 0,
      productionAssets: [],
      merchantFullName: '',
      merchantAddress: '',
      merchantLogo: '',
      merchantMobile: '',
      merchantEmail: '',
      productionOptionals: []);

  factory Product.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Product.empty;
    List<String> productAssets = json['productionAssets'] != null ? List.castFrom<dynamic, String>(json['productionAssets']) : [];

    return Product(
        appId: json['appId'] ?? '',
        merchantId: json['merchantId'] ?? '',
        paymentChannelCode: json['paymentChannelCode'] != null ? List.castFrom<dynamic, String>(json['paymentChannelCode']) : [],
        refundDay: json['refundDay'] ?? 0,
        postDate: json['postDate'] ?? '',
        lastUpdateDate: json['lastUpdateDate'] ?? '',
        categoryId: json['categoryId'] != null ? List.castFrom<dynamic, int>(json['categoryId']) : [],
        productId: json['productId'] ?? '',
        quantity: json['quantity'] ?? 0,
        productName: json['productName'] ?? '',
        productStatus: json['productStatus'] ?? '',
        commissionAmount: json['commissionAmount'] ?? 0,
        serviceFee: json['serviceFee'] ?? 0,
        shippingFee: json['shippingFee'] ?? 0,
        tagline: json['tagline'] != null ? json['tagline'].toString() : "",
        promotionTag: json['promotionTag'] != null ? List.castFrom<dynamic, String>(json['promotionTag']) : [],
        description: json['description'] != null ? json['description'].toString() : "",
        technicalSpec: json['technicalSpec'] != null ? json['technicalSpec'].toString() : "",
        remark: json['remark'] != null ? List.castFrom<dynamic, String>(json['remark']) : [],
        currency: json['currency'] ?? '',
        price: json['price'] ?? 0,
        discountPrice: json['discountPrice'] ?? 0,
        percentDiscountPrice: json['percentDiscountPrice'] ?? 0,
        productionAssets: json['productionAssets'] != null
            ? productAssets.length > 20
                ? productAssets.sublist(0, 20)
                : productAssets
            : [],
        merchantFullName: json['merchantFullName'] ?? '',
        merchantAddress: json['merchantAddress'] ?? '',
        merchantLogo: json['merchantLogo'] ?? '',
        merchantMobile: json['merchantMobile'] ?? '',
        merchantEmail: json['merchantEmail'] ?? '',
        productionOptionals:
            json['productionOptionals'] != null ? List.from(json['productionOptionals']).map((e) => ProductionOptionals.fromJson(e)).toList() : []);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        appId,
        merchantId,
        paymentChannelCode,
        refundDay,
        postDate,
        lastUpdateDate,
        categoryId,
        productId,
        quantity,
        productName,
        productStatus,
        commissionAmount,
        serviceFee,
        shippingFee,
        tagline,
        promotionTag,
        description,
        technicalSpec,
        remark,
        currency,
        price,
        discountPrice,
        percentDiscountPrice,
        productionAssets,
        merchantFullName,
        merchantAddress,
        merchantLogo,
        merchantMobile,
        merchantEmail,
        productionOptionals,
      ];
}

class ProductionOptionals extends Equatable {
  const ProductionOptionals({
    required this.label,
    required this.levelName,
    required this.image,
    required this.price,
    required this.subProductId,
    required this.quantity,
    required this.level2,
  });

  final String label;
  final String levelName;
  final String image;
  final int price;
  final String subProductId;
  final int quantity;
  final List<Level2> level2;

  factory ProductionOptionals.fromJson(Map<String, dynamic> json) {
    return ProductionOptionals(
        label: json['label'] ?? '',
        levelName: json['levelName'] ?? '',
        image: json['image'] ?? '',
        price: json['price'] ?? 0,
        subProductId: json['subProductId'] ?? '',
        quantity: json['quantity'] ?? 0,
        level2: json['level2'] != null ? List.from(json['level2']).map((e) => Level2.fromJson(e)).toList() : []);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        label,
        levelName,
        image,
        price,
        subProductId,
        quantity,
        level2,
      ];
}

class Level2 extends Equatable {
  const Level2(
      {required this.label,
      required this.levelName,
      required this.image,
      required this.price,
      required this.subProductId,
      required this.quantity,
      required this.level3});

  final String label;
  final String levelName;
  final String image;
  final int price;
  final String subProductId;
  final int quantity;
  final List<Level3> level3;

  factory Level2.fromJson(Map<String, dynamic> json) {
    return Level2(
        label: json['label'] ?? '',
        levelName: json['levelName'] ?? '',
        image: json['image'] ?? '',
        price: json['price'] ?? 0,
        subProductId: json['subProductId'] ?? '',
        quantity: json['quantity'] ?? 0,
        level3: json['level3'] != null ? List.from(json['level3']).map((e) => Level3.fromJson(e)).toList() : []);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [label, levelName, image, price, subProductId, quantity, level3];
}

class Level3 extends Equatable {
  const Level3(
      {required this.label,
      required this.levelName,
      required this.image,
      required this.price,
      required this.subProductId,
      required this.quantity,
      required this.level4});

  final String label;
  final String levelName;
  final String image;
  final int price;
  final String subProductId;
  final int quantity;
  final List<Level4> level4;

  factory Level3.fromJson(Map<String, dynamic> json) {
    return Level3(
        label: json['label'] ?? '',
        levelName: json['levelName'] ?? '',
        image: json['image'] ?? '',
        price: json['price'] ?? 0,
        subProductId: json['subProductId'] ?? '',
        quantity: json['quantity'] ?? 0,
        level4: json['level4'] != null ? List.from(json['level4']).map((e) => Level4.fromJson(e)).toList() : []);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [label, levelName, image, price, subProductId, quantity, level4];
}

class Level4 extends Equatable {
  const Level4(
      {required this.label,
      required this.levelName,
      required this.image,
      required this.price,
      required this.subProductId,
      required this.quantity,
      required this.level5});

  final String label;
  final String levelName;
  final String image;
  final int price;
  final String subProductId;
  final int quantity;
  final List<Level5> level5;

  factory Level4.fromJson(Map<String, dynamic> json) {
    return Level4(
        label: json['label'] ?? '',
        levelName: json['levelName'] ?? '',
        image: json['image'] ?? '',
        price: json['price'] ?? 0,
        subProductId: json['subProductId'] ?? '',
        quantity: json['quantity'] ?? 0,
        level5: json['level5'] != null ? List.from(json['level5']).map((e) => Level5.fromJson(e)).toList() : []);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [label, levelName, image, price, subProductId, quantity, level5];
}

class Level5 extends Equatable {
  const Level5({
    required this.label,
    required this.levelName,
    required this.image,
    required this.price,
    required this.subProductId,
    required this.quantity,
  });

  final String label;
  final String levelName;
  final String image;
  final int price;
  final String subProductId;
  final int quantity;

  factory Level5.fromJson(Map<String, dynamic> json) {
    return Level5(
        label: json['label'] ?? '',
        levelName: json['levelName'] ?? '',
        image: json['image'] ?? '',
        price: json['price'] ?? 0,
        subProductId: json['subProductId'] ?? '',
        quantity: json['quantity'] ?? 0);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [label, levelName, image, price, subProductId, quantity];
}

const mockProductListResponse = {
  "productAllItems": 10,
  "productPage": 1,
  "productCountItems": 1,
  "banner": [
    {
      "bannerId": "BN1",
      "image": "https://dev-app.marketplace.ksauto.net/assets/assets/homepage/HeroBanner.png",
      "route": "HeroBanner",
      "url": "http://",
      "seqNo": 1
    },
    {
      "bannerId": "BN2",
      "image": "https://dev-app.marketplace.ksauto.net/assets/assets/homepage/banner.png",
      "route": "Banner",
      "url": "http://",
      "seqNo": 2
    },
    {
      "bannerId": "BN3",
      "image": "https://dev-app.marketplace.ksauto.net/assets/assets/homepage/banner.png",
      "route": "Banner2",
      "url": "http://",
      "seqNo": 3
    }
  ],
  "category": [
    {
      "categoryId": 1,
      "categoryTh": "วอลล์ชาร์จ",
      "categoryEn": "EV Charger",
      "img_active": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/icon/icon_active_cate_wallcharge.png",
      "img_inactive": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/icon/icon_cate_wallcharge.png",
      "seqNo": 1
    },
    {
      "categoryId": 2,
      "categoryTh": "โซลาร์เซลล์",
      "categoryEn": "Solar",
      "img_active": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/icon/icon_active_cate_solar.png",
      "img_inactive": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/icon/icon_cate_solar.png",
      "seqNo": 2
    },
    {
      "categoryId": 3,
      "categoryTh": "สินค้าอื่นๆ",
      "categoryEn": "Accessory",
      "img_active": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/icon/icon_active_cate_other.png",
      "img_inactive": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/icon/icon_cate_other.png",
      "seqNo": 3
    }
  ],
  "products": [
    {
      "appId": "Marketplace-mini-app",
      "channelId": ["LINE"],
      "merchantId": "",
      "paymentChannelCode": [],
      "categoryId": [22],
      "productId": "PV_XJEKCHS5V84T",
      "productName": "วอลชาร์จ แม็กซ์",
      "tagline": "",
      "promotionTag": [],
      "currency": "Baht",
      "price": 50000,
      "discountPrice": 0,
      "percentDiscountPrice": 0,
      "productionAssets": [
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240312_034218_Privilege_ZTJ0LBR.png?sv=2020-08-04&se=2029-02-14T08%3A42%3A19Z&sr=b&sp=r&sig=nH5LFLJAI0zrZ%2BlHMvstagcDO%2FeUPQCH3LvTHvbXXhI%3D"
      ],
      "merchantLogo":
          "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/BUSDOAIGQZSP_app-bo-cust/merchant/20240315_022123_merchant_IPSO24I.png?sv=2020-08-04&se=2029-02-17T07%3A21%3A25Z&sr=b&sp=r&sig=I95xpxZ9ipI2a4%2BK4%2BwpxSzi0gHRLYnMwMMPHFjNMlw%3D",
      "productionOptionals": []
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": ["LINE"],
      "merchantId": "",
      "paymentChannelCode": [],
      "categoryId": [22],
      "productId": "PV_G7XMPQF1XS31",
      "productName": "วอลชาร์จ พลัส",
      "tagline": "",
      "promotionTag": [],
      "currency": "Baht",
      "price": 100000,
      "discountPrice": 0,
      "percentDiscountPrice": 0,
      "productionAssets": [
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240312_033446_Privilege_4B79A1U.png?sv=2020-08-04&se=2029-02-14T08%3A34%3A46Z&sr=b&sp=r&sig=8yANYIRiTOxJONrcBoPDB8zxz79OoTtifTJBLogO8NI%3D"
      ],
      "merchantLogo":
          "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/BUSDOAIGQZSP_app-bo-cust/merchant/20240315_022123_merchant_IPSO24I.png?sv=2020-08-04&se=2029-02-17T07%3A21%3A25Z&sr=b&sp=r&sig=I95xpxZ9ipI2a4%2BK4%2BwpxSzi0gHRLYnMwMMPHFjNMlw%3D",
      "productionOptionals": []
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": ["LINE"],
      "merchantId": "",
      "paymentChannelCode": [],
      "categoryId": [25],
      "productId": "PV_4DE1P98JVY33",
      "productName": "พอลซ่า แม็ค ยูเอที ออฟชั่น",
      "tagline": "<p>SMART CHARGING SOLUTIONS FOR ELECTRIC VEHICLES<br />วิถีใหม่แห่งการชาร์จรถยนต์ไฟฟ้าอย่างชาญฉลาด</p>",
      "promotionTag": ["รถไฟฟ้า", "สายชาร์จ"],
      "currency": "Baht",
      "price": 40000,
      "discountPrice": 0,
      "percentDiscountPrice": 0,
      "productionAssets": [
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_062827_Privilege_5PO67KE.png?sv=2020-08-04&se=2029-02-15T11%3A28%3A27Z&sr=b&sp=r&sig=7l%2BJw9EnEq6nrmoLG1ALqzqTEpeyzwmmyKoFTNc0H88%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_062810_Privilege_P0QCUOB.jpg?sv=2020-08-04&se=2029-02-15T11%3A28%3A11Z&sr=b&sp=r&sig=S88CkErtVdGE3AxAc0SRxGEPvjGPlEIh0OB8uRYhcNo%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_062811_Privilege_67SG4HM.png?sv=2020-08-04&se=2029-02-15T11%3A28%3A11Z&sr=b&sp=r&sig=6LP3t%2F5o7QdlzTTs4HYbycn2MNz7pu9frJ%2BNi43ItV8%3D"
      ],
      "merchantLogo":
          "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/BUSDOAIGQZSP_app-bo-cust/merchant/20240314_112653_merchant_8GR8VE2.png?sv=2020-08-04&se=2029-02-16T04%3A27%3A01Z&sr=b&sp=r&sig=QDuOiMImYwhQ095zh9FArNa%2BmIEi6BNYOIuCyKgj%2BSU%3D",
      "productionOptionals": []
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": ["LINE"],
      "merchantId": "",
      "paymentChannelCode": [],
      "categoryId": [25],
      "productId": "PV_UVJWMDXFY0WU",
      "productName": "พอลซ่า แม็ค ยูเอที โน ออฟชั่น",
      "tagline": "<p>SMART CHARGING SOLUTIONS FOR ELECTRIC VEHICLES<br />วิถีใหม่แห่งการชาร์จรถยนต์ไฟฟ้าอย่างชาญฉลาด</p>",
      "promotionTag": ["รถไฟฟ้า", "สายชาร์จ"],
      "currency": "Baht",
      "price": 43000,
      "discountPrice": 40000,
      "percentDiscountPrice": 7,
      "productionAssets": [
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_071133_Privilege_LEN4GFO.png?sv=2020-08-04&se=2029-02-15T12%3A11%3A33Z&sr=b&sp=r&sig=2Sm2qhtOdB6TAD5nri2z0DGM0GzDg5GPHt6ocktFlNI%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_071040_Privilege_01ODC5D.png?sv=2020-08-04&se=2029-02-15T12%3A10%3A40Z&sr=b&sp=r&sig=rYMkMhR7vvNIcdptyZyvUmususjJ2vXGfyHFrvb04Aw%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_071128_Privilege_3BMV4N1.jpg?sv=2020-08-04&se=2029-02-15T12%3A11%3A28Z&sr=b&sp=r&sig=BxOnfwywa7e6Sb5dsa7xxvntmeDKeMxqdMtmsB%2FFW30%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_071128_Privilege_9HTGRW2.png?sv=2020-08-04&se=2029-02-15T12%3A11%3A28Z&sr=b&sp=r&sig=4YMSxuJW1Oktoi5680fgYjif3ovWI3jyUHdbDy8HD8g%3D"
      ],
      "merchantLogo":
          "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/BUSDOAIGQZSP_app-bo-cust/merchant/20240314_112653_merchant_8GR8VE2.png?sv=2020-08-04&se=2029-02-16T04%3A27%3A01Z&sr=b&sp=r&sig=QDuOiMImYwhQ095zh9FArNa%2BmIEi6BNYOIuCyKgj%2BSU%3D",
      "productionOptionals": []
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": ["LINE", "GOAPP"],
      "merchantId": "",
      "paymentChannelCode": [],
      "categoryId": [25],
      "productId": "PV_GYMFSRLZUZRD",
      "productName": "ของ Dev มี Opt",
      "tagline":
          "<h2>แกร่งขึ้น ง่ายขึ้น สมาร์ทขึ้น</h2><p>เป็นเครื่องชาร์จรถไฟฟ้าแบบสมาร์ท ได้รับการออกแบบให้ประหยัดทั้งเวลา เงิน และประหยัดพลังงานสำหรับการชาร์จรถยนต์ไฟฟ้าของคุณในทุกๆวันเอนจอยกับรถยนต์ไฟฟ้าของคุณได้แบบเต็มที่</p>",
      "promotionTag": [],
      "currency": "Baht",
      "price": 32000,
      "discountPrice": 0,
      "percentDiscountPrice": 0,
      "productionAssets": [
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_110140_Privilege_S98QFZH.png?sv=2020-08-04&se=2029-02-15T04%3A01%3A40Z&sr=b&sp=r&sig=DPenA4yaRZTT%2F4QArqajBpflmyIFbPvb0EmWScYM%2B7g%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_110133_Privilege_RF5BEMZ.png?sv=2020-08-04&se=2029-02-15T04%3A01%3A34Z&sr=b&sp=r&sig=93zRauM3YR8krTPTqudaPAKPUxu1nUq8Bta4T3eSVc0%3D"
      ],
      "merchantLogo":
          "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/BUSDOAIGQZSP_app-bo-cust/merchant/20240314_112653_merchant_8GR8VE2.png?sv=2020-08-04&se=2029-02-16T04%3A27%3A01Z&sr=b&sp=r&sig=QDuOiMImYwhQ095zh9FArNa%2BmIEi6BNYOIuCyKgj%2BSU%3D",
      "productionOptionals": []
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": ["LINE", "GOAPP"],
      "merchantId": "",
      "paymentChannelCode": [],
      "categoryId": [25],
      "productId": "PV_AM3VVWATP72P",
      "productName": "ของ Dev ไม่มี Option มีDiscount",
      "tagline": "<p>แกร่งขึ้น ง่ายขึ้น สมาร์ทขึ้น</p>",
      "promotionTag": ["Promotion"],
      "currency": "Baht",
      "price": 59000,
      "discountPrice": 55555,
      "percentDiscountPrice": 6,
      "productionAssets": [
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_094212_Privilege_UQA67VG.png?sv=2020-08-04&se=2029-02-15T02%3A42%3A12Z&sr=b&sp=r&sig=2oBC0VgL8%2FA4neTw1WMz2dpIQpq9N%2FhC%2BV4RIRU2pF8%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_094156_Privilege_Y0I5RWU.jpg?sv=2020-08-04&se=2029-02-15T02%3A41%3A56Z&sr=b&sp=r&sig=Oxo3EHaurHW%2FVfu106vS5yB47dFhLRexok2hej7BIv4%3D"
      ],
      "merchantLogo":
          "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/BUSDOAIGQZSP_app-bo-cust/merchant/20240314_112653_merchant_8GR8VE2.png?sv=2020-08-04&se=2029-02-16T04%3A27%3A01Z&sr=b&sp=r&sig=QDuOiMImYwhQ095zh9FArNa%2BmIEi6BNYOIuCyKgj%2BSU%3D",
      "productionOptionals": []
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": ["LINE"],
      "merchantId": "",
      "paymentChannelCode": [],
      "categoryId": [25],
      "productId": "PV_8DZMMA6FKXQN",
      "productName": "Pulsar Max QA Test",
      "tagline": "<p>ไม่มีข้อมูลของออม</p>",
      "promotionTag": ["เงิน", "รับ", "เลย"],
      "currency": "Baht",
      "price": 49000,
      "discountPrice": 45000,
      "percentDiscountPrice": 8,
      "productionAssets": [
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_013333_Privilege_8ZUSFTN.png?sv=2020-08-04&se=2029-02-15T06%3A33%3A34Z&sr=b&sp=r&sig=7gsgHxHT4tkO5%2BnvpS55%2FoxH5FOcHfLdkWkGcTpxZWo%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_013447_Privilege_29LN2Q0.png?sv=2020-08-04&se=2029-02-15T06%3A34%3A47Z&sr=b&sp=r&sig=akl%2F%2BdQViGtfe2IK8pEG2evyyzG7ulc%2FVG744Ti6vkI%3D"
      ],
      "merchantLogo":
          "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/BUSDOAIGQZSP_app-bo-cust/merchant/20240314_112653_merchant_8GR8VE2.png?sv=2020-08-04&se=2029-02-16T04%3A27%3A01Z&sr=b&sp=r&sig=QDuOiMImYwhQ095zh9FArNa%2BmIEi6BNYOIuCyKgj%2BSU%3D",
      "productionOptionals": []
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": ["LINE"],
      "merchantId": "",
      "paymentChannelCode": [],
      "categoryId": [22],
      "productId": "PV_51A12VIHCRMM",
      "productName": "วอลชาร์จ แม็กซ์",
      "tagline": "",
      "promotionTag": ["รถไฟฟ้า", "สายชาจ"],
      "currency": "Baht",
      "price": 250000,
      "discountPrice": 0,
      "percentDiscountPrice": 0,
      "productionAssets": [
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032422_Privilege_12Y18JE.png?sv=2020-08-04&se=2029-02-15T08%3A24%3A22Z&sr=b&sp=r&sig=thn3AK5K2pSbCmwICAo9qyRqZuR5WbkgKA%2FoEQ%2BhCKA%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032242_Privilege_GBZYHEQ.jpg?sv=2020-08-04&se=2029-02-15T08%3A22%3A42Z&sr=b&sp=r&sig=QRBKFI7%2FfbVqgTxE9w35WHp%2FmEpWugdfS6LXvT8gFFo%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032242_Privilege_702MSBU.png?sv=2020-08-04&se=2029-02-15T08%3A22%3A42Z&sr=b&sp=r&sig=HyasCiy8IEsPI3HNd6S0oR%2BGRuY%2BIJsL2b7fuMiLm5U%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032242_Privilege_TVOHR9H.jpg?sv=2020-08-04&se=2029-02-15T08%3A22%3A42Z&sr=b&sp=r&sig=vfpbxm%2BVBvHzfHGZteOWNY3OlQPfqDh6eJS%2B0eNwCns%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032242_Privilege_3JJ7T61.jpg?sv=2020-08-04&se=2029-02-15T08%3A22%3A42Z&sr=b&sp=r&sig=cvIswAYYeTVGN1VebWpu0V2U3g187vZOZOWkeRZDZgI%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032242_Privilege_T7NECLT.jpg?sv=2020-08-04&se=2029-02-15T08%3A22%3A42Z&sr=b&sp=r&sig=xqJe9iKkRL8zCYnIMOZjCJpxsCY1w4Id9KbBN8Bl4Yc%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032242_Privilege_MY2YGC4.jpg?sv=2020-08-04&se=2029-02-15T08%3A22%3A42Z&sr=b&sp=r&sig=9ngCqiMXrFqzxCRjrwStg5HuOvwx2DfS5TZMCVD6bbk%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032242_Privilege_Q4JL6UE.png?sv=2020-08-04&se=2029-02-15T08%3A22%3A42Z&sr=b&sp=r&sig=GCxMspyNP2MBI55tZnAzx61AzfAah9EPCQ%2FKBLPbUqg%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032242_Privilege_P99D490.png?sv=2020-08-04&se=2029-02-15T08%3A22%3A42Z&sr=b&sp=r&sig=2QFk6TdYS26uonU0nXJmR9SvXvOZ3NgddJ8tcKKBB4M%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032242_Privilege_LZ9YO4A.jpg?sv=2020-08-04&se=2029-02-15T08%3A22%3A42Z&sr=b&sp=r&sig=o9gFGNJWZWvyEbVkMyjjTEdcK5yB7I0iwen%2FJ73NTVI%3D",
        "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/AJAYT7XH1HMV_app-bo-cust/Privilege/20240313_032242_Privilege_X4NC3DW.png?sv=2020-08-04&se=2029-02-15T08%3A22%3A42Z&sr=b&sp=r&sig=VkCiWy4vbmMlQ2Rm713vK6JjmjWQoljI9%2BbD76ZBet4%3D"
      ],
      "merchantLogo":
          "https://devbcrmdata.blob.core.windows.net/bcrm-139-busdoaigqzsp/BUSDOAIGQZSP_app-bo-cust/merchant/20240313_031107_merchant_PTN8UN1.png?sv=2020-08-04&se=2029-02-15T08%3A11%3A07Z&sr=b&sp=r&sig=QH%2FueOhmhmWcMKkLkXYWnsOoyP6d7AEbV14XFwi94rw%3D",
      "productionOptionals": []
    }
  ]
};

const mockProductResponse = {
  "appId": "Marketplace-mini-app",
  "merchantId": "0004234232",
  "paymentChannelCode": ["cc", "ipp"],
  "refundDay": 7,
  "postDate": "2023‐09‐01T02:49:06−07:00",
  "lastUpdateDate": "2023‐09‐02T02:49:06−07:00",
  "categoryId": ["CT_371KNH5QXG6O"],
  "productId": "PV_KH73Y1L00NLA03",
  "quantity": 100,
  "productName":
      "Palsar Max version2hkerhckjfshdjkhfgksdjhfgkjshdlkfjghlskdjfhglksjhdfkjghslkdfhglkhsldkfhlgkhsldfhgjsdhfgjhslkdfghlksjhfglkshldfghl",
  "productStatus": "Available",
  "commissionAmount": 2000,
  "serviceFee": 0,
  "shippingFee": 0,
  "tagline":
      "<h2>แกร่งขึ้น ง่ายขึ้น สมาร์ทขึ้น</h2><p>เป็นเครื่องชาร์จรถไฟฟ้าแบบสมาร์ท ได้รับการออกแบบให้ประหยัดทั้งเวลา เงิน และประหยัดพลังงานสำหรับการชาร์จรถยนต์ไฟฟ้าของคุณในทุกๆวันเอนจอยกับรถยนต์ไฟฟ้าของคุณได้แบบเต็มที่</p>",
  "promotionTag": ["ติดตั้งฟรี", "รับประกัน 3 ปี", "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"],
  "description": "<h1>Desc cate 2 Palsar Max version2</h1></h1>",
  "technicalSpec":
      "<table border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:100%\"><tbody><tr><td style=\"width:50%\"><p>รหัสสินค้า</p></td><td style=\"width:50%\"><p>PM12345678</p></td></tr><tr><td style=\"width:50%\"><p>ประเภทของเครื่องชาร์จ</p></td><td style=\"width:50%\"><p>Mode 3</p></td></tr><tr><td style=\"width:50%\"><p>ขนาด</p></td><td style=\"width:50%\"><p>198 x 201 x 99 มิลลิเมตร<br />(ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>น้ำหนัก</p></td><td style=\"width:50%\"><p>1 กิโลกรัม (ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>ความยาวสายชาร์จ</p></td><td style=\"width:50%\"><p>5 เมตร</p></td></tr><tr><td style=\"width:50%\"><p>การเชื่อมต่อ</p></td><td style=\"width:50%\"><p>Wi-Fi / Bluetooth</p></td></tr><tr><td style=\"width:50%\"><p>การเข้าใช้งาน</p></td><td style=\"width:50%\"><p>myWallbox App&amp;Portal</p></td></tr><tr><td style=\"width:50%\"><p>สี</p></td><td style=\"width:50%\"><p>ขาว หรือ ดำ</p></td></tr></tbody></table>",
  "remark": [],
  "currency": "THB",
  "price": 100000,
  "discountPrice": 50000,
  "percentDiscountPrice": 5,
  "productionAssets": [
    "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_1.png",
    "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
    "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PPMAX_BLACK_MONOCHROME_PHONE_1.png",
    "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PPMAX_GREY_MONOCHROME_PHONE.png",
    "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_1.png",
    "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_2.png",
    "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_3.png",
    "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_APP_EURO.png"
  ],
  "merchantFullName": "บริษัท อินโนพาวเวอร์ จำกัด",
  "merchantAddress": "ชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 แขวงพญาไท\nเขตพญาไท กทม 10400",
  "merchantLogo": "Url",
  "merchantMobile": "091-862-5011",
  "merchantEmail": "",
  "productionOptionals": [
    {
      "label": "5เมตร สีดำ",
      "levelName": "ความยาวสายและสี",
      "image": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
      "price": 50000,
      "subProductId": "P003-1",
      "quantity": 200
    },
    {
      "label":
          "5เมตร สีขาวhkerhckjfshdjkhfgksdjhfgkjshdlkfjghlskdjfhglksjhdfkjghslkdfhglkhsldkfhlgkhsldfhgjsdhfgjhslkdfghlksjhfglkshldfghljkshdkfghlsjkdhfjgklhsjlkdfhgjlkshljkdfhglwkercmnwltkenhvtksduhnlkh",
      "levelName": "ความยาวสายและสี",
      "image": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
      "price": 50000,
      "subProductId": "P003-2",
      "quantity": 250
    },
    {
      "label": "10เมตร สีดำ",
      "levelName": "ความยาวสายและสี",
      "image": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
      "price": 55000,
      "subProductId": "P003-3",
      "quantity": 200
    },
    {
      "label": "10เมตร สีขาว",
      "levelName": "ความยาวสายและสี",
      "image": "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
      "price": 55000,
      "subProductId": "P003-4",
      "quantity": 250
    }
  ]
};
