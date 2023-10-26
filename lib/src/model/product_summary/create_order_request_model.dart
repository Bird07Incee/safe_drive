class CreateOrderRequestModel {
  String? uid;
  List<OrderProduct>? products;
  PaymentInfo? paymentInfo;
  ShippingInfo? shippingInfo;
  String? email;
  String? mobilePhone;

  CreateOrderRequestModel(
      {required this.uid,
      required this.products,
      required this.paymentInfo,
      required this.shippingInfo,
      required this.email,
      required this.mobilePhone});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (paymentInfo != null) {
      data['paymentInfo'] = paymentInfo!.toJson();
    }
    if (shippingInfo != null) {
      data['shippingInfo'] = shippingInfo!.toJson();
    }
    data['email'] = email;
    data['mobilePhone'] = mobilePhone;
    return data;
  }
}

class OrderProduct {
  String? productId;
  int? qty;
  int? unitPrice;
  Optional? optional;

  OrderProduct({required this.productId, required this.qty, required this.unitPrice, required this.optional});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['qty'] = qty;
    data['unitPrice'] = unitPrice;
    if (optional != null) {
      data['optional'] = optional!.toJson();
    }
    return data;
  }
}

class Optional {
  String? productId;
  int? qty;
  int? unitPrice;
  SubOptional? subOptional;

  Optional({required this.productId, required this.qty, required this.unitPrice, required this.subOptional});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['qty'] = qty;
    data['unitPrice'] = unitPrice;
    if (subOptional != null) {
      data['subOptional'] = subOptional!.toJson();
    }
    return data;
  }
}

class SubOptional {
  String? productId;
  int? qty;
  int? unitPrice;

  SubOptional({required this.productId, required this.qty, required this.unitPrice});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['qty'] = qty;
    data['unitPrice'] = unitPrice;
    return data;
  }
}

class PaymentInfo {
  String? channel;
  String? staffCode;

  PaymentInfo({required this.channel, required this.staffCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
    data['staffCode'] = staffCode;
    return data;
  }
}

class ShippingInfo {
  String? name;
  String? address;

  ShippingInfo({required this.name, required this.address});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}
