class DropdownAddressModel {
  late String id;
  String? nameEn;
  String? version;
  String? nameTh;
  String? createdDatetime;
  String? regionId;
  String? provinceId;
  String? districtId;
  String? zipCode;

  DropdownAddressModel(
      {required this.id,
      this.nameEn,
      this.version,
      this.nameTh,
      this.createdDatetime,
      this.regionId,
      this.provinceId,
      this.districtId,
      this.zipCode});

  DropdownAddressModel.fromJson(Map<String, dynamic> json) {
    id = json['uid'] ?? '';
    nameEn = json['nameEn'] ?? '';
    version = json['version'] ?? '';
    nameTh = json['nameTh'] ?? '';
    createdDatetime = json['createdDatetime'] ?? '';
    regionId = json['regionId'] ?? '';
    provinceId = json['provinceId'] ?? '';
    districtId = json['districtId'] ?? '';
    zipCode = json['zipCode'] ?? '';
  }
}
