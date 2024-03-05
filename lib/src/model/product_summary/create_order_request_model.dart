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
//  final String? staffCode;

//  const PaymentInfo({required this.channel, required this.staffCode});
  const PaymentInfo({required this.channel});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
  //  data['staffCode'] = staffCode;
    return data;
  }

//  static const empty = PaymentInfo(channel: "", staffCode: "");
  static const empty = PaymentInfo(channel: "");
}

class ShippingInfo {
  final String? fullName;
  final String? address;
  final String? firstName;
  final String? lastName;
  final String? mobileNo;
  final String? houseNo;
  final String? lane;
  final String? street;
  final String? subDistrict;
  final String? district;
  final String? province;
  final String? postalCode;
  final String? email;

  // var address = {
  //   "first_name": "คุณ สมหมาย",
  //   "last_name": "ประกายดาว",
  //   "mobile_no": "0842215679",
  //   "address": "หมู่บ้านxxxxxxxxxxx",
  //   "house_no": "บ้านเลขที่ 2",
  //   "lane": "3",
  //   "street": "ถนน สุขุมวิท",
  //   "sub_district": "แขวงคลองเตย ",
  //   "district": "เขตคลองเตย",
  //   "province": "กรุงเทพมหานคร ",
  //   "postal_code": "10110",
  //   "email: "ka@ka.com"
  // };

  const ShippingInfo(
      {required this.fullName,
      required this.address,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.houseNo,
      this.lane,
      this.street,
      this.subDistrict,
      this.district,
      this.province,
      this.postalCode,
      this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['address'] = address;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobileNo'] = mobileNo;
    data['houseNo'] = houseNo;
    data['lane'] = lane;
    data['street'] = street;
    data['subDistrict'] = subDistrict;
    data['district'] = district;
    data['province'] = province;
    data['postalCode'] = postalCode;
    data['email'] = email;
    return data;
  }

  static const empty = ShippingInfo(
      fullName: "",
      address: "",
      firstName: "",
      lastName: "",
      mobileNo: "",
      houseNo: "",
      lane: "",
      street: "",
      subDistrict: "",
      district: "",
      province: "",
      postalCode: "",
      email: "");
}
