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
  final List<Map>? category;
  final List<Product>? products;

  ProductList.fromJson(Map<String, dynamic> json)
      : banner = json['banner'] != null ? List.from(json['banner']).map((e) => Banner.fromJson(e)).toList() : [],
        category = json['category'] != null ? List.from(json['category']).map((e) => e as Map).toList() : [],
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
    required this.seqNo,
  });
  final String image;
  final String route;
  final String url;
  final String seqNo;

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
        image: json['image'] ?? '', route: json['route'] ?? '', url: json['url'] ?? '', seqNo: json['seqNo'] ?? '');
  }
}

extension ProductX on Product {
  bool get isEmpty => this != Product.empty;
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
  final List<String> categoryId;
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
      categoryId: [],
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
    List<String> productAssets = List.castFrom<dynamic, String>(json['productionAssets']);
    return Product(
        appId: json['appId'] ?? '',
        channelId: json['channelId'] ?? '',
        merchantId: json['merchantId'] ?? '',
        paymentChannelCode: json['paymentChannelCode'] ?? '',
        refundDay: json['refundDay'] ?? 0,
        postDate: json['postDate'] ?? '',
        lastUpdateDate: json['lastUpdateDate'] ?? '',
        categoryId: json['categoryId'] != null ? List.castFrom<dynamic, String>(json['categoryId']) : [],
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
        productionAssets:
            json['productionAssets'] != null ? productAssets.length > 20 ? productAssets.sublist(0, 19) : productAssets: [],
        merchantFullName: json['merchantFullName'] ?? '',
        merchantAddress: json['merchantAddress'] ?? '',
        merchantLogo: json['merchantLogo'] ?? '',
        merchantMobile: json['merchantMobile'] ?? '',
        merchantEmail: json['merchantEmail'] ?? '',
        productionOptionals: json['productionOptionals'] != null
            ? List.from(json['productionOptionals']).map((e) => ProductionOptionals.fromJson(e)).toList()
            : []);
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
        level2: json['level2'] != null ? List.from(json['level2']).map((e) => Level2.fromJson(e)).toList() : []);
  }
}

class Level2 {
  Level2(
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
}

class Level3 {
  Level3(
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
}

class Level4 {
  Level4(
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
        quantity: json['quantity'] ?? 0);
  }
}

const mockProductResponse = {
  "productAllItems": 10,
  "productPage": 1,
  "productCountItems": 1,
  "banner": [
    {
      "bannerId": "BN1",
      "image": "https://dev-app.marketplace.ksauto.net/assets/assets/homepage/HeroBanner.png",
      "route": "HeroBanner",
      "url": "http://",
      "seqNo": "1"
    },
    {
      "bannerId": "BN2",
      "image": "https://dev-app.marketplace.ksauto.net/assets/assets/homepage/banner.png",
      "route": "Banner",
      "url": "http://",
      "seqNo": "2"
    },
    {
      "bannerId": "BN3",
      "image": "https://dev-app.marketplace.ksauto.net/assets/assets/homepage/banner.png",
      "route": "Banner2",
      "url": "http://",
      "seqNo": "3"
    }
  ],
  "category": [
    {"categoryId": "CT_9P2UW6F426C6", "category": "EV Charger"},
    {"categoryId": "CT_0XSC1E4ELDFV", "category": "Accessory"},
    {"categoryId": "CT_371KNH5QXG6O", "category": "Solar"},
    {"categoryId": "CT_2YP8LLQG95FS", "category": "EV Cate4"}
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
      "categoryId": ["CT_9P2UW6F426C6", "CT_2YP8LLQG95FS"],
      "productId": "PV_QQZ5W1QWKQC8",
      "quantity": 100,
      "productName": "Palsar Max",
      "productStatus": "Available",
      "commissionAmount": 2000,
      "serviceFee": 0,
      "shippingFee": 0,
      "tagline":
          "<h2>แกร่งขึ้น ง่ายขึ้น สมาร์ทขึ้น</h2><p>เป็นเครื่องชาร์จรถไฟฟ้าแบบสมาร์ท ได้รับการออกแบบให้ประหยัดทั้งเวลา เงิน และประหยัดพลังงานสำหรับการชาร์จรถยนต์ไฟฟ้าของคุณในทุกๆวันเอนจอยกับรถยนต์ไฟฟ้าของคุณได้แบบเต็มที่</p>",
      "promotionTag": ["ติดตั้งฟรี", "รับประกัน 3 ปี", "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"],
      "description": "<p>Decription cate1 Innopower 1</p>",
      "technicalSpec":
          "<table border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:100%\"><tbody><tr><td style=\"width:50%\"><p>รหัสสินค้า</p></td><td style=\"width:50%\"><p>PM12345678</p></td></tr><tr><td style=\"width:50%\"><p>ประเภทของเครื่องชาร์จ</p></td><td style=\"width:50%\"><p>Mode 3</p></td></tr><tr><td style=\"width:50%\"><p>ขนาด</p></td><td style=\"width:50%\"><p>198 x 201 x 99 มิลลิเมตร<br />(ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>น้ำหนัก</p></td><td style=\"width:50%\"><p>1 กิโลกรัม (ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>ความยาวสายชาร์จ</p></td><td style=\"width:50%\"><p>5 เมตร</p></td></tr><tr><td style=\"width:50%\"><p>การเชื่อมต่อ</p></td><td style=\"width:50%\"><p>Wi-Fi / Bluetooth</p></td></tr><tr><td style=\"width:50%\"><p>การเข้าใช้งาน</p></td><td style=\"width:50%\"><p>myWallbox App&amp;Portal</p></td></tr><tr><td style=\"width:50%\"><p>สี</p></td><td style=\"width:50%\"><p>ขาว หรือ ดำ</p></td></tr></tbody></table>",
      "remark": "<h1>Remark cate1 Innopower 1</h1>",
      "currency": "THB",
      "price": 56640,
      "discountPrice": 59000,
      "percentDiscountPrice": 5,
      "productionAssets": [
        "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_BLACK_MONOCHROME_2_2.png",
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
          "label":
              "สีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำสีดำ",
          "levelName": "สี",
          "image":
              "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
          "price": 56640,
          "subProductId": "P001-1",
          "quantity": 200,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
              "price": 0,
              "subProductId": "P001-11",
              "quantity": 100
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
              "price": 500,
              "subProductId": "P001-12",
              "quantity": 100
            }
          ]
        },
        {
          "label": "สีขาว",
          "levelName": "สี",
          "image":
              "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
          "price": 57640,
          "subProductId": "P001-2",
          "quantity": 250,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
              "price": 0,
              "subProductId": "P001-21",
              "quantity": 50
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
              "price": 500,
              "subProductId": "P001-22",
              "quantity": 80
            },
            {
              "label": "10 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
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
      "categoryId": ["CT_0XSC1E4ELDFV"],
      "productId": "PV_KH73Y1L00NLA",
      "quantity": 100,
      "productName": "Palsar Max version1",
      "productStatus": "Available",
      "commissionAmount": 2000,
      "serviceFee": 0,
      "shippingFee": 0,
      "tagline":
          "<h2>แกร่งขึ้น ง่ายขึ้น สมาร์ทขึ้น</h2><p>เป็นเครื่องชาร์จรถไฟฟ้าแบบสมาร์ท ได้รับการออกแบบให้ประหยัดทั้งเวลา เงิน และประหยัดพลังงานสำหรับการชาร์จรถยนต์ไฟฟ้าของคุณในทุกๆวันเอนจอยกับรถยนต์ไฟฟ้าของคุณได้แบบเต็มที่</p>",
      "promotionTag": ["ติดตั้งฟรี", "รับประกัน 3 ปี", "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"],
      "description":
          "<article>Wallbox Pulsar Max เป็นเครื่องชาร์จรถไฟฟ้าแบบสมาร์ทได้รับการออกแบบให้ประหยัดทั้งเวลา เงิน และประหยัดพลังงานสำหรับการชาร์จรถยนต์ไฟฟ้าของคุณในทุกๆวัน เอนจอยกับรถยนต์ไฟฟ้าของคุณได้แบบเต็มที่ เพราะ Pulsar Max มีความสามารถในการชาร์จเร็ว และยังสามารถบริหารจัดการพลังงานได้อย่างง่ายดายอีกด้วย <br><br><br><strong> Tough:</strong> สามารถติดตั้งได้ทั้งภายในและภายนอกอาคารด้วยผิวสัมผัสแบบแมท ที่มีความสามารถในการป้องกันรอยขีดข่วน รวมถึงมาตรฐาน IP55 <br><strong>Connected:</strong> ควบคุมเครื่องชาร์จของคุณด้วย myWallbox App ผ่านเชื่อมต่อทั้ง Wifi และ บลูทูธ <br><strong>Compatible with your EV:</strong> Pulsar Max รองรับหัวชาร์จทั้ง Type 1 และ Type 2 </br><strong>Simply Installing:</strong> ออกแบบให้ติดตั้งเครื่องชาร์จได้ง่ายขึ้นเพื่อลดทั้งเวลาและงบประมาณลง<article>",
      "technicalSpec":
          "<table border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:100%\"><tbody><tr><td style=\"width:50%\"><p>รหัสสินค้า</p></td><td style=\"width:50%\"><p>PM12345678</p></td></tr><tr><td style=\"width:50%\"><p>ประเภทของเครื่องชาร์จ</p></td><td style=\"width:50%\"><p>Mode 3</p></td></tr><tr><td style=\"width:50%\"><p>ขนาด</p></td><td style=\"width:50%\"><p>198 x 201 x 99 มิลลิเมตร<br />(ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>น้ำหนัก</p></td><td style=\"width:50%\"><p>1 กิโลกรัม (ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>ความยาวสายชาร์จ</p></td><td style=\"width:50%\"><p>5 เมตร</p></td></tr><tr><td style=\"width:50%\"><p>การเชื่อมต่อ</p></td><td style=\"width:50%\"><p>Wi-Fi / Bluetooth</p></td></tr><tr><td style=\"width:50%\"><p>การเข้าใช้งาน</p></td><td style=\"width:50%\"><p>myWallbox App&amp;Portal</p></td></tr><tr><td style=\"width:50%\"><p>สี</p></td><td style=\"width:50%\"><p>ขาว หรือ ดำ</p></td></tr></tbody></table>",
      "remark":
          "<article>• ข้อมูลนี้เป็นข้อมูลจากผู้ให้บริการ อาจมีการเปลี่ยนแปลงได้ตลอดเวลา<br> • Krungsri Auto เป็นช่องทางการแสดงสินค้าเท่านั้น </br>• สอบถามข้อมูลเพิ่มเติมเกี่ยวกับสินค้า กรุณาติดต่อผู้ขายโดยตรง <strong>เบอร์ติดต่อ 091-862-5011</strong><br> • แจ้งปัญหาสอบถามข้อมูลการสั่งซื้อ กรุณาติดต่อผู้ดูแลระบบ <strong>เบอร์ติดต่อ 081-123-4567</strong></br><article>",
      "currency": "THB",
      "price": 56640,
      "discountPrice": 0,
      "percentDiscountPrice": 0,
      "productionAssets": [
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124652137419.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.JPG",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.mpeg",
        "https://youtube.com/?fdsfdfsdf",
        "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124654629060.avi"
      ],
      "merchantFullName": "บริษัท อินโนพาวเวอร์ จำกัด",
      "merchantAddress": "ชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 แขวงพญาไท\nเขตพญาไท กทม 10400",
      "merchantLogo": "Url",
      "merchantMobile": "091-862-5011",
      "merchantEmail": "",
      "productionOptionals": [
        {
          "label": "สีดำ",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 56640,
          "subProductId": "P002-1",
          "quantity": 200,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P002-11",
              "quantity": 100
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P002-12",
              "quantity": 100
            }
          ]
        },
        {
          "label": "สีขาว",
          "levelName": "สี",
          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
          "price": 57640,
          "subProductId": "P002-2",
          "quantity": 250,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 0,
              "subProductId": "P002-21",
              "quantity": 50
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 500,
              "subProductId": "P002-22",
              "quantity": 80
            },
            {
              "label": "10 เมตร",
              "levelName": "ความยาวสาย",
              "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
              "price": 700,
              "subProductId": "P002-23",
              "quantity": 120,
              "level3": [
                {
                  "label": "สายธรรมดา",
                  "levelName": "รูปแบบสาย",
                  "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                  "price": 100,
                  "subProductId": "P002-231",
                  "quantity": 120,
                  "level4": [
                    {
                      "label": "สายธรรมดา",
                      "levelName": "รูปแบบสาย",
                      "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                      "price": 200,
                      "subProductId": "P002-2311",
                      "quantity": 120,
                      "level5": [
                        {
                          "label": "สายธรรมดา",
                          "levelName": "รูปแบบสาย",
                          "image": "https://app.qa.channel.buk0.com/zm5-files/MARKETPLACE01/1/20230831124649109144.JPG",
                          "price": 300,
                          "subProductId": "P002-23111",
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
      "categoryId": ["CT_371KNH5QXG6O"],
      "productId": "PV_KH73Y1L00NLA",
      "quantity": 100,
      "productName": "Palsar Max version2",
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
      "remark": "<h1>Remark cate 2 Palsar Max version2</h1></h1>",
      "currency": "THB",
      "price": 56640,
      "discountPrice": 59000,
      "percentDiscountPrice": 5,
      "productionAssets": [
        "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_BLACK_MONOCHROME_2_2.png",
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
          "label": "สีดำ",
          "levelName": "สี",
          "image":
              "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
          "price": 56640,
          "subProductId": "P001-1",
          "quantity": 200,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
              "price": 0,
              "subProductId": "P002-11",
              "quantity": 100
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/c2_white_3phase.png",
              "price": 500,
              "subProductId": "P002-12",
              "quantity": 100
            }
          ]
        },
        {
          "label": "สีขาว",
          "levelName": "สี",
          "image":
              "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
          "price": 57640,
          "subProductId": "P002-2",
          "quantity": 250,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
              "price": 0,
              "subProductId": "P001-21",
              "quantity": 50
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
              "price": 500,
              "subProductId": "P002-22",
              "quantity": 80
            },
            {
              "label": "10 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
              "price": 700,
              "subProductId": "P002-23",
              "quantity": 120,
              "level3": [
                {
                  "label": "สายธรรมดา",
                  "levelName": "รูปแบบสาย",
                  "image":
                      "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
                  "price": 100,
                  "subProductId": "P002-231",
                  "quantity": 120,
                  "level4": [
                    {
                      "label": "สายธรรมดา",
                      "levelName": "รูปแบบสาย",
                      "image":
                          "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
                      "price": 200,
                      "subProductId": "P002-2311",
                      "quantity": 120,
                      "level5": [
                        {
                          "label": "สายธรรมดา",
                          "levelName": "รูปแบบสาย",
                          "image":
                              "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_WHITE_MONOCHROME_2_1.png",
                          "price": 300,
                          "subProductId": "P002-23111",
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
      "categoryId": ["CT_2YP8LLQG95FS"],
      "productId": "P003",
      "quantity": 100,
      "productName": "Palsar Max EV3",
      "productStatus": "Available",
      "commissionAmount": 2000,
      "serviceFee": 0,
      "shippingFee": 0,
      "tagline":
          "<h2>แกร่งขึ้น ง่ายขึ้น สมาร์ทขึ้น</h2><p>เป็นเครื่องชาร์จรถไฟฟ้าแบบสมาร์ท ได้รับการออกแบบให้ประหยัดทั้งเวลา เงิน และประหยัดพลังงานสำหรับการชาร์จรถยนต์ไฟฟ้าของคุณในทุกๆวันเอนจอยกับรถยนต์ไฟฟ้าของคุณได้แบบเต็มที่</p>",
      "promotionTag": ["ติดตั้งฟรี", "รับประกัน 3 ปี", "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"],
      "description": "<h1>Desc cate 3 Palsar Max EV3</h1>",
      "technicalSpec":
          "<table border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:100%\"><tbody><tr><td style=\"width:50%\"><p>รหัสสินค้า</p></td><td style=\"width:50%\"><p>PM12345678</p></td></tr><tr><td style=\"width:50%\"><p>ประเภทของเครื่องชาร์จ</p></td><td style=\"width:50%\"><p>Mode 3</p></td></tr><tr><td style=\"width:50%\"><p>ขนาด</p></td><td style=\"width:50%\"><p>198 x 201 x 99 มิลลิเมตร<br />(ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>น้ำหนัก</p></td><td style=\"width:50%\"><p>1 กิโลกรัม (ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>ความยาวสายชาร์จ</p></td><td style=\"width:50%\"><p>5 เมตร</p></td></tr><tr><td style=\"width:50%\"><p>การเชื่อมต่อ</p></td><td style=\"width:50%\"><p>Wi-Fi / Bluetooth</p></td></tr><tr><td style=\"width:50%\"><p>การเข้าใช้งาน</p></td><td style=\"width:50%\"><p>myWallbox App&amp;Portal</p></td></tr><tr><td style=\"width:50%\"><p>สี</p></td><td style=\"width:50%\"><p>ขาว หรือ ดำ</p></td></tr></tbody></table>",
      "remark": "<h1>Remark cate 3 Palsar Max EV3</h1>",
      "currency": "THB",
      "price": 56640,
      "discountPrice": 59000,
      "percentDiscountPrice": 5,
      "productionAssets": [
        "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_1.png",
        "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_2.png",
        "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_ACCESORIES_3.png",
        "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_APP_EURO.png",
        "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/PULSARMAX_INSTALL_2.png"
      ],
      "merchantFullName": "บริษัท อินโนพาวเวอร์ จำกัด",
      "merchantAddress": "ชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 แขวงพญาไท\nเขตพญาไท กทม 10400",
      "merchantLogo": "Url",
      "merchantMobile": "091-862-5011",
      "merchantEmail": "",
      "productionOptionals": [
        {
          "label": "สีดำ",
          "levelName": "สี",
          "image":
              "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/WallBox_Home_Garage_Outoor_Stucco_Pulsar_Max_1889.jpg",
          "price": 56640,
          "subProductId": "P003-1",
          "quantity": 200,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/WallBox_Home_Garage_Outoor_Stucco_Pulsar_Max_1889.jpg",
              "price": 0,
              "subProductId": "P003-11",
              "quantity": 100
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/WallBox_Home_Garage_Outoor_Stucco_Pulsar_Max_1889.jpg",
              "price": 500,
              "subProductId": "P003-12",
              "quantity": 100
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
      "categoryId": ["CT_2YP8LLQG95FS"],
      "productId": "P004",
      "quantity": 100,
      "productName": "Palsar Max EV4",
      "productStatus": "Available",
      "commissionAmount": 2000,
      "serviceFee": 0,
      "shippingFee": 0,
      "tagline":
          "<h2>แกร่งขึ้น ง่ายขึ้น สมาร์ทขึ้น</h2><p>เป็นเครื่องชาร์จรถไฟฟ้าแบบสมาร์ท ได้รับการออกแบบให้ประหยัดทั้งเวลา เงิน และประหยัดพลังงานสำหรับการชาร์จรถยนต์ไฟฟ้าของคุณในทุกๆวันเอนจอยกับรถยนต์ไฟฟ้าของคุณได้แบบเต็มที่</p>",
      "promotionTag": ["ติดตั้งฟรี", "รับประกัน 3 ปี", "สิทธิ์พิเศษเฉพาะ ลูกค้ากรุงศรี ออโต้"],
      "description": "<p>Decription cate4 Palsar Max EV4</p>",
      "technicalSpec":
          "<table border=\"0\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:100%\"><tbody><tr><td style=\"width:50%\"><p>รหัสสินค้า</p></td><td style=\"width:50%\"><p>PM12345678</p></td></tr><tr><td style=\"width:50%\"><p>ประเภทของเครื่องชาร์จ</p></td><td style=\"width:50%\"><p>Mode 3</p></td></tr><tr><td style=\"width:50%\"><p>ขนาด</p></td><td style=\"width:50%\"><p>198 x 201 x 99 มิลลิเมตร<br />(ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>น้ำหนัก</p></td><td style=\"width:50%\"><p>1 กิโลกรัม (ไม่รวมสายชาร์จ)</p></td></tr><tr><td style=\"width:50%\"><p>ความยาวสายชาร์จ</p></td><td style=\"width:50%\"><p>5 เมตร</p></td></tr><tr><td style=\"width:50%\"><p>การเชื่อมต่อ</p></td><td style=\"width:50%\"><p>Wi-Fi / Bluetooth</p></td></tr><tr><td style=\"width:50%\"><p>การเข้าใช้งาน</p></td><td style=\"width:50%\"><p>myWallbox App&amp;Portal</p></td></tr><tr><td style=\"width:50%\"><p>สี</p></td><td style=\"width:50%\"><p>ขาว หรือ ดำ</p></td></tr></tbody></table>",
      "remark": "<h1>Remark cate 4 Palsar Max EV4</h1>",
      "currency": "THB",
      "price": 56640,
      "discountPrice": 1000,
      "percentDiscountPrice": 5,
      "productionAssets": [
        "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/WALLBOX_DAY2_2.jpg",
        "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/WALLBOX_DAY2_4.jpg",
        "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/commander/WALLBOX_DAY2_9.jpg"
      ],
      "merchantFullName": "บริษัท อินโนพาวเวอร์ จำกัด",
      "merchantAddress": "ชั้น19 อาคารทิปโก้ ทาวเวอร์ 2 เลขที่ 118/1 ถนนพระราม 6 แขวงพญาไท\nเขตพญาไท กทม 10400",
      "merchantLogo": "Url",
      "merchantMobile": "091-862-5011",
      "merchantEmail": "",
      "productionOptionals": [
        {
          "label": "สีขาว",
          "levelName": "สี",
          "image":
              "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_BLACK_MONOCHROME_2_2.png",
          "price": 57640,
          "subProductId": "P004-1",
          "quantity": 250,
          "level2": [
            {
              "label": "3 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_BLACK_MONOCHROME_2_2.png",
              "price": 0,
              "subProductId": "P004-2",
              "quantity": 50
            },
            {
              "label": "5 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_BLACK_MONOCHROME_2_2.png",
              "price": 500,
              "subProductId": "P004-3",
              "quantity": 80
            },
            {
              "label": "10 เมตร",
              "levelName": "ความยาวสาย",
              "image":
                  "https://dev-app.marketplace.ksauto.net/assets/assets/mocking/product_innopower/pulsar_max/5_PPMAX_BLACK_MONOCHROME_2_2.png",
              "price": 700,
              "subProductId": "P004-4",
              "quantity": 120
            }
          ]
        }
      ]
    }
  ]
};
