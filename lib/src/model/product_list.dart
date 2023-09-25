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
  final List<Product>? products;

  ProductList.fromJson(Map<String, dynamic> json)
      : banner = json['banner'] != null ? List.from(json['banner']).map((e) => Banner.fromJson(e)).toList() : [],
        category = json['category'] != null ? List.from(json['category']).map((e) => e as String).toList() : [],
        products = json['products'] != null ? List.from(json['products']).map((e) => Product.fromJson(e)).toList() : [],
        productAllItems = json['productAllItems'] != null ? json['productAllItems'] as int? : 0,
        productPage = json['productPage'] != null ? json['productPage'] as int? : 0,
        productCountItems = json['productCountItems'] != null ? json['productCountItems'] as int? : 0;
}

class Banner {
  Banner({
    required this.image,
    required this.route,
    required this.url,
  });
  final String image;
  final String route;
  final String url;

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(image: json['image'] ?? '', route: json['route'] ?? '', url: json['url'] ?? '');
  }
}

class Product {
  const Product({
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
  final String appId;
  final String channelId;
  final String merchantId;
  final String paymentChannelCode;
  final int refundDay;
  final String postDate;
  final String lastUpdateDate;
  final String categoryId;
  final String category;
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
  final String remark;
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
      channelId: '',
      merchantId: '',
      paymentChannelCode: '',
      refundDay: 0,
      postDate: '',
      lastUpdateDate: '',
      categoryId: '',
      category: '',
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
      remark: '',
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
    return Product(
        appId: json['appId'] ?? '',
        channelId: json['channelId'] ?? '',
        merchantId: json['merchantId'] ?? '',
        paymentChannelCode: json['paymentChannelCode'] ?? '',
        refundDay: json['refundDay'] ?? 0,
        postDate: json['postDate'] ?? '',
        lastUpdateDate: json['lastUpdateDate'] ?? '',
        categoryId: json['categoryId'] ?? '',
        category: json['category'] ?? '',
        productId: json['productId'] ?? '',
        quantity: json['quantity'] ?? 0,
        productName: json['productName'] ?? '',
        productStatus: json['productStatus'] ?? '',
        commissionAmount: json['commissionAmount'] ?? 0,
        serviceFee: json['serviceFee'] ?? 0,
        shippingFee: json['shippingFee'] ?? 0,
        tagline: json['tagline'] ?? '',
        promotionTag: json['promotionTag'] != null ? List.castFrom<dynamic, String>(json['promotionTag']) : [],
        description: json['description'] ?? '',
        technicalSpec: json['technicalSpec'] ?? '',
        remark: json['remark'] ?? '',
        currency: json['currency'] ?? '',
        price: json['price'] ?? 0,
        discountPrice: json['discountPrice'] ?? 0,
        percentDiscountPrice: json['percentDiscountPrice'] ?? 0,
        productionAssets: json['productionAssets'] != null ? List.castFrom<dynamic, String>(json['productionAssets']) : [],
        merchantFullName: json['merchantFullName'] ?? '',
        merchantAddress: json['merchantAddress'] ?? '',
        merchantLogo: json['merchantLogo'] ?? '',
        merchantMobile: json['merchantMobile'] ?? '',
        merchantEmail: json['merchantEmail'] ?? '',
        productionOptionals: json['productionOptionals'] != null ? List.from(json['productionOptionals']).map((e) => ProductionOptionals.fromJson(e)).toList() : []
    );
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
        level2: json['level2'] != null ? List.from(json['level2']).map((e) => Level2.fromJson(e)).toList() : []
    );
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
    required this.level3
  });
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
       level3: json['level3'] != null ? List.from(json['level3']).map((e) => Level3.fromJson(e)).toList() : []
   );
  }
}

class Level3 {
  Level3({
    required this.label,
    required this.levelName,
    required this.image,
    required this.price,
    required this.subProductId,
    required this.quantity,
    required this.level4
  });
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
        level4: json['level4'] != null ? List.from(json['level4']).map((e) => Level4.fromJson(e)).toList() : []
    );
  }
}

class Level4 {
  Level4({
    required this.label,
    required this.levelName,
    required this.image,
    required this.price,
    required this.subProductId,
    required this.quantity,
    required this.level5
  });
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
        level5: json['level5'] != null ? List.from(json['level5']).map((e) => Level5.fromJson(e)).toList() : []
    );
  }
}

class Level5 {
  Level5({
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
        quantity: json['quantity'] ?? 0
    );
  }
}

const mockProductResponse = {
  "productAllItems": 10,
  "productPage": 1,
  "productCountItems": 1,
  "banner": [
    {
      "image": "",
      "route": "Home",
      "url": "http://"
    }
  ],
  "category": [
    "All",
    "EV Charger",
    "Accessory"
  ],
  "products": [
    {
      "appId": "Marketplace-mini-app",
      "channelId": "LINE",
      "merchantId": "0004234232",
      "paymentChannelCode": "",
      "refundDay": 7,
      "postDate": "2023‐09‐01T02:49:06−07:00",
      "lastUpdateDate": "2023‐09‐02T02:49:06−07:00",
      "categoryId": "1",
      "category": "EV Charger",
      "productId": "P001",
      "quantity": 100,
      "productName": "Palsar Max",
      "productStatus": "Available",
      "commissionAmount": 2000,
      "serviceFee": 0,
      "shippingFee": 0,
      "tagline": "html",
      "promotionTag": [
        "ติดตั้งฟรี",
        "รับประกัน 3 ปี",
        "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"
      ],
      "description": "html",
      "technicalSpec": "html",
      "remark": "html",
      "currency": "THB",
      "price": 56640,
      "discountPrice": 59000,
      "percentDiscountPrice": 5,
      "productionAssets": [
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124652137419.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.mpeg",
        "https://youtube.com/?fdsfdfsdf",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.avi"
      ],
      "merchantFullName": "",
      "merchantAddress": "",
      "merchantLogo": "Url",
      "merchantMobile": "",
      "merchantEmail": "",
      "productionOptionals": [
        {
          "label": "สีดำ",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 56640,
          "subProductId": "P001-1",
          "quantity": 200,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P001-11",
              "quantity": 100
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P001-12",
              "quantity": 100
            }
          ]
        },
        {
          "label": "สีขาว",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 57640,
          "subProductId": "P001-2",
          "quantity": 250,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P001-21",
              "quantity": 50
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P001-22",
              "quantity": 80
            },
            {
              "label": "10 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 700,
              "subProductId": "P001-23",
              "quantity": 120,
              "level3": [
                {
                  "label": "สายธรรมดา",
                  "levelName": "รูปแบบสาย",
                  "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                  "price": 100,
                  "subProductId": "P001-231",
                  "quantity": 120,
                  "level4": [
                    {
                      "label": "สายธรรมดา",
                      "levelName": "รูปแบบสาย",
                      "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                      "price": 200,
                      "subProductId": "P001-2311",
                      "quantity": 120,
                      "level5": [
                        {
                          "label": "สายธรรมดา",
                          "levelName": "รูปแบบสาย",
                          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                          "price": 300,
                          "subProductId": "P001-23111",
                          "quantity": 120
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": "LINE",
      "merchantId": "0004234232",
      "paymentChannelCode": "",
      "refundDay": 7,
      "postDate": "2023‐09‐01T02:49:06−07:00",
      "lastUpdateDate": "2023‐09‐02T02:49:06−07:00",
      "categoryId": "1",
      "category": "EV Charger",
      "productId": "P001",
      "quantity": 100,
      "productName": "Palsar Max",
      "productStatus": "Available",
      "commissionAmount": 2000,
      "serviceFee": 0,
      "shippingFee": 0,
      "tagline": "html",
      "promotionTag": [
        "ติดตั้งฟรี",
        "รับประกัน 3 ปี",
        "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"
      ],
      "description": "html",
      "technicalSpec": "html",
      "remark": "html",
      "currency": "THB",
      "price": 56640,
      "discountPrice": 59000,
      "percentDiscountPrice": 5,
      "productionAssets": [
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124652137419.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.mpeg",
        "https://youtube.com/?fdsfdfsdf",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.avi"
      ],
      "merchantFullName": "",
      "merchantAddress": "",
      "merchantLogo": "Url",
      "merchantMobile": "",
      "merchantEmail": "",
      "productionOptionals": [
        {
          "label": "สีดำ",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 56640,
          "subProductId": "P001-1",
          "quantity": 200,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P001-11",
              "quantity": 100
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P001-12",
              "quantity": 100
            }
          ]
        },
        {
          "label": "สีขาว",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 57640,
          "subProductId": "P001-2",
          "quantity": 250,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P001-21",
              "quantity": 50
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P001-22",
              "quantity": 80
            },
            {
              "label": "10 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 700,
              "subProductId": "P001-23",
              "quantity": 120,
              "level3": [
                {
                  "label": "สายธรรมดา",
                  "levelName": "รูปแบบสาย",
                  "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                  "price": 100,
                  "subProductId": "P001-231",
                  "quantity": 120,
                  "level4": [
                    {
                      "label": "สายธรรมดา",
                      "levelName": "รูปแบบสาย",
                      "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                      "price": 200,
                      "subProductId": "P001-2311",
                      "quantity": 120,
                      "level5": [
                        {
                          "label": "สายธรรมดา",
                          "levelName": "รูปแบบสาย",
                          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                          "price": 300,
                          "subProductId": "P001-23111",
                          "quantity": 120
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": "LINE",
      "merchantId": "0004234232",
      "paymentChannelCode": "",
      "refundDay": 7,
      "postDate": "2023‐09‐01T02:49:06−07:00",
      "lastUpdateDate": "2023‐09‐02T02:49:06−07:00",
      "categoryId": "1",
      "category": "EV Charger",
      "productId": "P001",
      "quantity": 100,
      "productName": "Palsar Max",
      "productStatus": "Available",
      "commissionAmount": 2000,
      "serviceFee": 0,
      "shippingFee": 0,
      "tagline": "html",
      "promotionTag": [
        "ติดตั้งฟรี",
        "รับประกัน 3 ปี",
        "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"
      ],
      "description": "html",
      "technicalSpec": "html",
      "remark": "html",
      "currency": "THB",
      "price": 56640,
      "discountPrice": 59000,
      "percentDiscountPrice": 5,
      "productionAssets": [
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124652137419.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.mpeg",
        "https://youtube.com/?fdsfdfsdf",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.avi"
      ],
      "merchantFullName": "",
      "merchantAddress": "",
      "merchantLogo": "Url",
      "merchantMobile": "",
      "merchantEmail": "",
      "productionOptionals": [
        {
          "label": "สีดำ",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 56640,
          "subProductId": "P001-1",
          "quantity": 200,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P001-11",
              "quantity": 100
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P001-12",
              "quantity": 100
            }
          ]
        },
        {
          "label": "สีขาว",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 57640,
          "subProductId": "P001-2",
          "quantity": 250,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P001-21",
              "quantity": 50
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P001-22",
              "quantity": 80
            },
            {
              "label": "10 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 700,
              "subProductId": "P001-23",
              "quantity": 120,
              "level3": [
                {
                  "label": "สายธรรมดา",
                  "levelName": "รูปแบบสาย",
                  "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                  "price": 100,
                  "subProductId": "P001-231",
                  "quantity": 120,
                  "level4": [
                    {
                      "label": "สายธรรมดา",
                      "levelName": "รูปแบบสาย",
                      "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                      "price": 200,
                      "subProductId": "P001-2311",
                      "quantity": 120,
                      "level5": [
                        {
                          "label": "สายธรรมดา",
                          "levelName": "รูปแบบสาย",
                          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                          "price": 300,
                          "subProductId": "P001-23111",
                          "quantity": 120
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": "LINE",
      "merchantId": "0004234232",
      "paymentChannelCode": "",
      "refundDay": 7,
      "postDate": "2023‐09‐01T02:49:06−07:00",
      "lastUpdateDate": "2023‐09‐02T02:49:06−07:00",
      "categoryId": "1",
      "category": "EV Charger",
      "productId": "P001",
      "quantity": 100,
      "productName": "Palsar Max",
      "productStatus": "Available",
      "commissionAmount": 2000,
      "serviceFee": 0,
      "shippingFee": 0,
      "tagline": "html",
      "promotionTag": [
        "ติดตั้งฟรี",
        "รับประกัน 3 ปี",
        "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"
      ],
      "description": "html",
      "technicalSpec": "html",
      "remark": "html",
      "currency": "THB",
      "price": 56640,
      "discountPrice": 59000,
      "percentDiscountPrice": 5,
      "productionAssets": [
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124652137419.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.mpeg",
        "https://youtube.com/?fdsfdfsdf",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.avi"
      ],
      "merchantFullName": "",
      "merchantAddress": "",
      "merchantLogo": "Url",
      "merchantMobile": "",
      "merchantEmail": "",
      "productionOptionals": [
        {
          "label": "สีดำ",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 56640,
          "subProductId": "P001-1",
          "quantity": 200,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P001-11",
              "quantity": 100
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P001-12",
              "quantity": 100
            }
          ]
        },
        {
          "label": "สีขาว",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 57640,
          "subProductId": "P001-2",
          "quantity": 250,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P001-21",
              "quantity": 50
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P001-22",
              "quantity": 80
            },
            {
              "label": "10 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 700,
              "subProductId": "P001-23",
              "quantity": 120,
              "level3": [
                {
                  "label": "สายธรรมดา",
                  "levelName": "รูปแบบสาย",
                  "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                  "price": 100,
                  "subProductId": "P001-231",
                  "quantity": 120,
                  "level4": [
                    {
                      "label": "สายธรรมดา",
                      "levelName": "รูปแบบสาย",
                      "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                      "price": 200,
                      "subProductId": "P001-2311",
                      "quantity": 120,
                      "level5": [
                        {
                          "label": "สายธรรมดา",
                          "levelName": "รูปแบบสาย",
                          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                          "price": 300,
                          "subProductId": "P001-23111",
                          "quantity": 120
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    },
    {
      "appId": "Marketplace-mini-app",
      "channelId": "LINE",
      "merchantId": "0004234232",
      "paymentChannelCode": "",
      "refundDay": 7,
      "postDate": "2023‐09‐01T02:49:06−07:00",
      "lastUpdateDate": "2023‐09‐02T02:49:06−07:00",
      "categoryId": "1",
      "category": "EV Charger",
      "productId": "P001",
      "quantity": 100,
      "productName": "Palsar Max",
      "productStatus": "Available",
      "commissionAmount": 2000,
      "serviceFee": 0,
      "shippingFee": 0,
      "tagline": "html",
      "promotionTag": [
        "ติดตั้งฟรี",
        "รับประกัน 3 ปี",
        "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"
      ],
      "description": "html",
      "technicalSpec": "html",
      "remark": "html",
      "currency": "THB",
      "price": 56640,
      "discountPrice": 59000,
      "percentDiscountPrice": 5,
      "productionAssets": [
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124652137419.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.mpeg",
        "https://youtube.com/?fdsfdfsdf",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.avi"
      ],
      "merchantFullName": "",
      "merchantAddress": "",
      "merchantLogo": "Url",
      "merchantMobile": "",
      "merchantEmail": "",
      "productionOptionals": [
        {
          "label": "สีดำ",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 56640,
          "subProductId": "P001-1",
          "quantity": 200,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P001-11",
              "quantity": 100
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P001-12",
              "quantity": 100
            }
          ]
        },
        {
          "label": "สีขาว",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 57640,
          "subProductId": "P001-2",
          "quantity": 250,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P001-21",
              "quantity": 50
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P001-22",
              "quantity": 80
            },
            {
              "label": "10 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 700,
              "subProductId": "P001-23",
              "quantity": 120,
              "level3": [
                {
                  "label": "สายธรรมดา",
                  "levelName": "รูปแบบสาย",
                  "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                  "price": 100,
                  "subProductId": "P001-231",
                  "quantity": 120,
                  "level4": [
                    {
                      "label": "สายธรรมดา",
                      "levelName": "รูปแบบสาย",
                      "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                      "price": 200,
                      "subProductId": "P001-2311",
                      "quantity": 120,
                      "level5": [
                        {
                          "label": "สายธรรมดา",
                          "levelName": "รูปแบบสาย",
                          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                          "price": 300,
                          "subProductId": "P001-23111",
                          "quantity": 120
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  ]
};
