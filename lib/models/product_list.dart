import 'package:equatable/equatable.dart';
import 'package:marketplace_line_oa/helpers/extensions.dart';

class ProductListModel extends Equatable {
  final int? allItems;
  final int? page;
  final int? countItems;
  final List<ProductData>? items;

  const ProductListModel({
    this.allItems,
    this.page,
    this.countItems,
    this.items,
  });

  static const empty = ProductListModel(allItems: 0, page: 0, countItems: 0, items: []);

  ProductListModel.fromJson(Map<String, dynamic> json)
      : allItems = json['allItems'] as int?,
        page = json['page'] as int?,
        countItems = json['countItems'] as int?,
        items = (json['items'] as List?)?.map((dynamic e) => ProductData.fromJson(e as Map<String, dynamic>)).toList();

  @override
  List<Object?> get props => [allItems, page, countItems, items];
}

extension PostDataX on ProductData {
  String get postTitle {
    return "$manufactureYear $brand $model $submodel";
  }

  double get lat {
    if (dealerAddressLatLong != null && dealerAddressLatLong!.isLatLong()) {
      return double.parse(dealerAddressLatLong!.split(',')[0]);
    }
    return 0;
  }

  double get long {
    if (dealerAddressLatLong != null && dealerAddressLatLong!.isLatLong()) {
      return double.parse(dealerAddressLatLong!.split(',')[1]);
    }
    return 0;
  }

  bool get noContacts {
    if ((dealerAddressLatLong != null && dealerAddressLatLong != "" && dealerAddressLatLong!.isLatLong()) ||
        (dealerMobileNumberMap != null && dealerMobileNumberMap!.isNotEmpty) ||
        (dealerLineId != null && dealerLineId != "" && dealerLineId != [])) {
      return false;
    }
    return true;
  }
}

class ProductData extends Equatable {
  final String? dealerAddressLatLong;
  final String? dealerLogo;
  final String? partnerLogo;
  final String? color;
  final String? lastUpdateDate;
  final String? registrationProvince;
  final String? postStatus;
  final int? discountPrice;
  final String? carPostTypeId;
  final String? description;
  final String? title;
  final List<DealerModel>? dealerMobileNumberMap;
  final String? pullDataLastUpdate;
  final List<String>? dealerImage;
  final String? totalViewCount;
  final String? carType;
  final String? transmission;
  final String? pdfCertificated;
  final String? carRefId;
  final int? price;
  final String? model;
  final String? id;
  final String? brand;
  final int? mileage;
  final String? dealerDistrict;
  final String? dealerName;
  final String? partnerName;
  final String? dealerAddress;
  final String? pullDataStageStatus;
  final String? submodel;
  final String? messageId;
  final String? ownerProperty;
  final int? engineCapacity;
  final dynamic dealerLineId;
  final String? createdDate;
  final String? dealerFullName;
  final String? fuelType;
  final List<String>? carImage;
  final String? carImageThumbnail;
  final String? dealerProvince;
  final String? registration;
  final String? sellerType;
  final int? manufactureYear;
  final String? createDate;
  final String? updateDate;
  final String? marketplaceTitle;
  final String? dealerRegion;
  final bool? isFavorite;
  final String? contentId;

  const ProductData(
      {this.dealerAddressLatLong,
      this.dealerLogo,
      this.partnerLogo,
      this.color,
      this.lastUpdateDate,
      this.registrationProvince,
      this.postStatus,
      this.discountPrice,
      this.carPostTypeId,
      this.description,
      this.title,
      this.dealerMobileNumberMap,
      this.pullDataLastUpdate,
      this.dealerImage,
      this.totalViewCount,
      this.carType,
      this.transmission,
      this.pdfCertificated,
      this.carRefId,
      this.price,
      this.model,
      this.id,
      this.brand,
      this.mileage,
      this.dealerDistrict,
      this.dealerName,
      this.partnerName,
      this.dealerAddress,
      this.pullDataStageStatus,
      this.submodel,
      this.messageId,
      this.ownerProperty,
      this.engineCapacity,
      this.dealerLineId,
      this.createdDate,
      this.dealerFullName,
      this.fuelType,
      this.carImage,
      this.carImageThumbnail,
      this.dealerProvince,
      this.registration,
      this.sellerType,
      this.manufactureYear,
      this.createDate,
      this.updateDate,
      this.marketplaceTitle,
      this.dealerRegion,
      this.isFavorite,
      this.contentId});

  static const empty = ProductData(
      dealerAddressLatLong: "",
      dealerLogo: "",
      partnerLogo: "",
      color: "",
      lastUpdateDate: "",
      registrationProvince: "",
      postStatus: "",
      discountPrice: 0,
      carPostTypeId: "",
      description: "",
      title: "",
      dealerMobileNumberMap: [],
      pullDataLastUpdate: "",
      dealerImage: [],
      totalViewCount: "",
      carType: "",
      transmission: "",
      pdfCertificated: "",
      carRefId: "",
      price: 0,
      model: "",
      id: "",
      brand: "",
      mileage: 0,
      dealerDistrict: "",
      dealerName: "",
      partnerName: "",
      dealerAddress: "",
      pullDataStageStatus: "",
      submodel: "",
      messageId: "",
      ownerProperty: "",
      engineCapacity: 0,
      dealerLineId: "",
      createdDate: "",
      dealerFullName: "",
      fuelType: "",
      carImage: [],
      carImageThumbnail: "",
      dealerProvince: "",
      registration: "",
      sellerType: "",
      manufactureYear: 0,
      createDate: "",
      updateDate: "",
      marketplaceTitle: "",
      dealerRegion: "",
      isFavorite: false,
      contentId: "");

  ProductData copyWith({
    String? dealerAddressLatLong,
    String? dealerLogo,
    String? partnerLogo,
    String? color,
    String? lastUpdateDate,
    String? registrationProvince,
    String? postStatus,
    int? discountPrice,
    String? carPostTypeId,
    String? description,
    String? title,
    List<DealerModel>? dealerMobileNumberMap,
    String? pullDataLastUpdate,
    List<String>? dealerImage,
    String? totalViewCount,
    String? carType,
    String? transmission,
    String? pdfCertificated,
    String? carRefId,
    int? price,
    String? model,
    String? id,
    String? brand,
    int? mileage,
    String? dealerDistrict,
    String? dealerName,
    String? partnerName,
    String? dealerAddress,
    String? pullDataStageStatus,
    String? submodel,
    String? messageId,
    String? ownerProperty,
    int? engineCapacity,
    dynamic dealerLineId,
    String? createdDate,
    String? dealerFullName,
    String? fuelType,
    List<String>? carImage,
    String? carImageThumbnail,
    String? dealerProvince,
    String? registration,
    String? sellerType,
    int? manufactureYear,
    String? createDate,
    String? updateDate,
    String? marketplaceTitle,
    String? dealerRegion,
    bool? isFavorite,
    String? contentId,
  }) {
    return ProductData(
        dealerAddressLatLong: dealerAddressLatLong ?? this.dealerAddressLatLong,
        dealerLogo: dealerLogo ?? this.dealerLogo,
        partnerLogo: partnerLogo ?? this.partnerLogo,
        color: color ?? this.color,
        lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
        registrationProvince: registrationProvince ?? this.registrationProvince,
        postStatus: postStatus ?? this.postStatus,
        discountPrice: discountPrice ?? this.discountPrice,
        carPostTypeId: carPostTypeId ?? this.carPostTypeId,
        description: description ?? this.description,
        title: title ?? this.title,
        dealerMobileNumberMap: dealerMobileNumberMap ?? this.dealerMobileNumberMap,
        pullDataLastUpdate: pullDataLastUpdate ?? this.pullDataLastUpdate,
        dealerImage: dealerImage ?? this.dealerImage,
        totalViewCount: totalViewCount ?? this.totalViewCount,
        carType: carType ?? this.carType,
        transmission: transmission ?? this.transmission,
        pdfCertificated: pdfCertificated ?? this.pdfCertificated,
        carRefId: carRefId ?? this.carRefId,
        price: price ?? this.price,
        model: model ?? this.model,
        id: id ?? this.id,
        brand: brand ?? this.brand,
        mileage: mileage ?? this.mileage,
        dealerDistrict: dealerDistrict ?? this.dealerDistrict,
        dealerName: dealerName ?? this.dealerName,
        partnerName: partnerName ?? this.partnerName,
        dealerAddress: dealerAddress ?? this.dealerAddress,
        pullDataStageStatus: pullDataStageStatus ?? this.pullDataStageStatus,
        submodel: submodel ?? this.submodel,
        messageId: messageId ?? this.messageId,
        ownerProperty: ownerProperty ?? this.ownerProperty,
        engineCapacity: engineCapacity ?? this.engineCapacity,
        dealerLineId: dealerLineId ?? this.dealerLineId,
        createdDate: createdDate ?? this.createdDate,
        dealerFullName: dealerFullName ?? this.dealerFullName,
        fuelType: fuelType ?? this.fuelType,
        carImage: carImage ?? this.carImage,
        carImageThumbnail: carImageThumbnail ?? this.carImageThumbnail,
        dealerProvince: dealerProvince ?? this.dealerProvince,
        registration: registration ?? this.registration,
        sellerType: sellerType ?? this.sellerType,
        manufactureYear: manufactureYear ?? this.manufactureYear,
        createDate: createDate ?? this.createDate,
        updateDate: updateDate ?? this.updateDate,
        marketplaceTitle: marketplaceTitle ?? this.marketplaceTitle,
        dealerRegion: dealerRegion ?? this.dealerRegion,
        isFavorite: isFavorite ?? this.isFavorite,
        contentId: contentId ?? this.contentId);
  }

  ProductData.fromJson(Map<String, dynamic> json)
      : dealerAddressLatLong = json['dealerAddressLatLong'] as String?,
        dealerLogo = json['dealerLogo'] as String?,
        partnerLogo = json['partnerLogo'] != null ? json['partnerLogo'] as String : "",
        color = json['color'] as String?,
        lastUpdateDate = json['lastUpdateDate'] as String?,
        registrationProvince = json['registrationProvince'] as String?,
        postStatus = json['postStatus'] as String?,
        discountPrice = json['discountPrice'] as int?,
        carPostTypeId = json['carPostTypeId'] as String?,
        description = json['description'] as String?,
        title = json['title'] as String?,
        dealerMobileNumberMap =
            (json['dealerMobileNumberMap'] as List?)?.map((dynamic e) => DealerModel.fromJson(e)).toList(),
        pullDataLastUpdate = json['pullDataLastUpdate'] as String?,
        dealerImage = (json['dealerImage'] as List?)?.map((dynamic e) => e as String).toList(),
        totalViewCount = json['totalViewCount'] as String?,
        carType = json['carType'] as String?,
        transmission = json['transmission'] as String?,
        pdfCertificated = json['pdfCertificated'] as String?,
        carRefId = json['carRefId'] as String?,
        price = json['price'] as int?,
        model = json['model'] as String?,
        id = json['id'] as String?,
        brand = json['brand'] as String?,
        mileage = json['mileage'] as int?,
        dealerDistrict = json['dealerDistrict'] as String?,
        dealerName = json['dealerName'] as String?,
        partnerName = json['partnerName'] as String?,
        dealerAddress = json['dealerAddress'] as String?,
        pullDataStageStatus = json['pullDataStageStatus'] as String?,
        submodel = json['submodel'] as String?,
        messageId = json['messageId'] as String?,
        ownerProperty = json['ownerProperty'] as String?,
        engineCapacity = json['engineCapacity'].runtimeType == int
            ? json['engineCapacity'] as int?
            : json['engineCapacity'].runtimeType == String
                ? int.tryParse(json['engineCapacity'])
                : 0,
        dealerLineId = json['dealerLineId'].runtimeType != String
            ? (json['dealerLineId'] as List?)?.map((dynamic e) => e != null ? e.toString() : "").toList()
            : json['dealerLineId'] as String?,
        createdDate = json['createdDate'] as String?,
        dealerFullName = json['dealerFullName'] as String?,
        fuelType = json['fuelType'] as String?,
        carImage = (json['carImage'] as List?)?.map((dynamic e) => e != null ? e.toString() : "").toList(),
        carImageThumbnail = json['carImageThumbnail']?.toString(),
        dealerProvince = json['dealerProvince'] as String?,
        registration = json['registration'] as String?,
        sellerType = json['sellerType'] as String?,
        manufactureYear = json['manufactureYear'] as int?,
        createDate = json['createDate'] as String?,
        updateDate = json['updateDate'] as String?,
        marketplaceTitle = json['marketplaceTitle'] as String?,
        dealerRegion = json['dealerRegion'] as String?,
        isFavorite = json['isFavorite'] as bool?,
        contentId = json['contentId'] ?? json['zm5ContentId'] as String?;

  @override
  List<Object?> get props => [
        dealerAddressLatLong,
        dealerLogo,
        partnerLogo,
        color,
        lastUpdateDate,
        registrationProvince,
        postStatus,
        discountPrice,
        carPostTypeId,
        description,
        title,
        dealerMobileNumberMap,
        pullDataLastUpdate,
        dealerImage,
        totalViewCount,
        carType,
        transmission,
        pdfCertificated,
        carRefId,
        price,
        model,
        id,
        brand,
        mileage,
        dealerDistrict,
        dealerName,
        partnerName,
        dealerAddress,
        pullDataStageStatus,
        submodel,
        messageId,
        ownerProperty,
        engineCapacity,
        dealerLineId,
        createdDate,
        dealerFullName,
        fuelType,
        carImage,
        carImageThumbnail,
        dealerProvince,
        registration,
        sellerType,
        manufactureYear,
        createDate,
        updateDate,
        marketplaceTitle,
        dealerRegion,
        isFavorite,
        contentId
      ];
}

class DealerModel extends Equatable {
  final String? name;
  final String? phoneNumber;

  const DealerModel({this.name, this.phoneNumber});

  factory DealerModel.fromJson(Map<String, dynamic> json) {
    return DealerModel(name: json['name'], phoneNumber: json['number']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, phoneNumber];
}
