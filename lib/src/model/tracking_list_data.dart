class Order {
  String? orderNo;
  String? shippingStatus;
  List<Products>? products;
  int? totalPrice;
  int? totalQty;

  Order({this.orderNo, this.shippingStatus, this.products, this.totalPrice, this.totalQty});

  Order.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    shippingStatus = json['shippingStatus'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'];
    totalQty = json['totalQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderNo'] = orderNo;
    data['shippingStatus'] = shippingStatus;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = totalPrice;
    data['totalQty'] = totalQty;
    return data;
  }
}

class Products {
  String? productId;
  String? productNameTh;
  String? productNameEn;
  String? productDescription;
  String? productImageUrl;
  int? productQty;
  int? price;
  int? discountPrice;
  String? currency;
  String? channel;
  String? createDate;
  String? lastUpdateDate;

  Products(
      {this.productId,
      this.productNameTh,
      this.productNameEn,
      this.productDescription,
      this.productImageUrl,
      this.productQty,
      this.price,
      this.discountPrice,
      this.currency,
      this.channel,
      this.createDate,
      this.lastUpdateDate});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productNameTh = json['productNameTh'];
    productNameEn = json['productNameEn'];
    productDescription = json['productDescription'];
    productImageUrl = json['productImageUrl'];
    productQty = json['productQty'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    currency = json['currency'];
    channel = json['channel'];
    createDate = json['createDate'];
    lastUpdateDate = json['lastUpdateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productNameTh'] = productNameTh;
    data['productNameEn'] = productNameEn;
    data['productDescription'] = productDescription;
    data['productImageUrl'] = productImageUrl;
    data['productQty'] = productQty;
    data['price'] = price;
    data['discountPrice'] = discountPrice;
    data['currency'] = currency;
    data['channel'] = channel;
    data['createDate'] = createDate;
    data['lastUpdateDate'] = lastUpdateDate;
    return data;
  }
}
