import 'package:equatable/equatable.dart';

extension AddressX on ShippingAddressModel {
  bool get isEmpty => this == ShippingAddressModel.empty;
}

class ShippingAddressModel extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props =>
      [fullName, mobileNumber, emailAddress, fullAddress, province, district, subDistrict, zipCode];
}
