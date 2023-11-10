class CreateOrderRequestModel {
  final String? uid;
  final List<OrderProduct>? products;
  final PaymentInfo? paymentInfo;
  final ShippingInfo? shippingInfo;
  final String? email;
  final String? mobilePhone;

  const CreateOrderRequestModel(
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

  static const empty = CreateOrderRequestModel(
      uid: '', products: [OrderProduct.empty], paymentInfo: PaymentInfo.empty, shippingInfo: ShippingInfo.empty, email: "", mobilePhone: "");
}

class OrderProduct {
  final String? productId;
  final int? qty;
  final int? unitPrice;
  final Optional? optional;

  const OrderProduct({required this.productId, required this.qty, required this.unitPrice, this.optional});

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

  static const empty = OrderProduct(productId: "", qty: 0, unitPrice: 0, optional: Optional.empty);
}

class Optional {
  final String? productId;
  final int? qty;
  final int? unitPrice;
  final SubOptional? subOptional;

  const Optional({required this.productId, required this.qty, required this.unitPrice, this.subOptional});

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

  static const empty = Optional(productId: "", qty: 0, unitPrice: 0, subOptional: SubOptional.empty);
}

class SubOptional {
  final String? productId;
  final int? qty;
  final int? unitPrice;

  const SubOptional({required this.productId, required this.qty, required this.unitPrice});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['qty'] = qty;
    data['unitPrice'] = unitPrice;
    return data;
  }

  static const empty = SubOptional(productId: "", qty: 0, unitPrice: 0);
}

class PaymentInfo {
  final String? channel;
  final String? staffCode;

  const PaymentInfo({required this.channel, required this.staffCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
    data['staffCode'] = staffCode;
    return data;
  }

  static const empty = PaymentInfo(channel: "", staffCode: "");
}

class ShippingInfo {
  final String? name;
  final String? address;

  const ShippingInfo({required this.name, required this.address});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    return data;
  }

  static const empty = ShippingInfo(name: "", address: "");
}
