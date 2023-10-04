extension AddressX on ShippingAddressModel {
  bool get isEmpty => this != ShippingAddressModel.empty;
}

class ShippingAddressModel {
  final String fullName;
  final String mobileNumber;
  final String emailAddress;
  final String fullAddress;
  final String province;
  final String district;
  final String subDistrict;
  final String zipCode;

  const ShippingAddressModel(
      {required this.fullName,
      required this.mobileNumber,
      required this.emailAddress,
      required this.fullAddress,
      required this.province,
      required this.district,
      required this.subDistrict,
      required this.zipCode});

  static const empty = ShippingAddressModel(
    fullName: '',
    mobileNumber: '',
    emailAddress: '',
    fullAddress: '',
    province: '',
    district: '',
    subDistrict: '',
    zipCode: '',
  );
}
