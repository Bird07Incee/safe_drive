import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/model/form_widget_model.dart';
import 'package:marketplace_line_oa/src/model/product_summary/dropdown_address_model.dart';
import 'package:marketplace_line_oa/src/model/product_summary/shipping_address_model.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

part 'shipping_address_event.dart';
part 'shipping_address_state.dart';

class ShippingAddressBloc extends Cubit<ShippingAddressState> {
  ShippingAddressBloc() : super(ShippingAddressState()) {
    setFormData();
  }

  final DioUtilityRepository dioUtilityRepository =
      DioUtilityRepository(service: DioUtilityService(dio: DioClient.client));
  final String getProvinceAPIPath = "/ecommerce/v1/data/province";
  final String getDistrictAPIPath = "/ecommerce/v1/data/district";
  List<DropdownAddressModel> listSubDistrict = [];
  List<String> listZipCode = [];

  updateDropdownSelected(
      {String? id,
      String? fieldName,
      String? filterRefId,
      List<FormWidgetModel>? listForm,
      List<FormWidgetResultModel>? listResult}) {
    if (fieldName == 'province') {
      listForm!
          .where((element) => element.fieldName == 'district')
          .first
          .controller!
          .clear();
      listResult!
          .where((element) => element.fieldName == 'district')
          .first
          .value = '';
      listResult.where((element) => element.fieldName == 'district').first.id =
          '';

      // var response = fetchDataFromApi(getDistrictAPIPath, refId: filterRefId!);
      if (listForm
          .where((element) => element.fieldName == 'district')
          .first
          .options!
          .isEmpty) {
        var items = districtDataMock['items'] as List;
        List<DropdownAddressModel> listDistrict = [];
        for (int i = 0; i < items.length; i++) {
          listDistrict.add(DropdownAddressModel.fromJson(items[i]));
        }

        listForm
            .where((element) => element.fieldName == 'district')
            .first
            .options!
            .addAll(listDistrict);
      }
    } else if (fieldName == 'district') {
      listForm!
          .where((element) => element.fieldName == 'subDistrict')
          .first
          .controller!
          .clear();
      listResult!
          .where((element) => element.fieldName == 'subDistrict')
          .first
          .value = '';
      listResult
          .where((element) => element.fieldName == 'subDistrict')
          .first
          .id = '';
      listForm
          .where((element) => element.fieldName == 'zipCode')
          .first
          .controller!
          .clear();
      listResult
          .where((element) => element.fieldName == 'zipCode')
          .first
          .value = '';
      listResult.where((element) => element.fieldName == 'zipCode').first.id =
          '';
      if (listForm
          .where((element) => element.fieldName == 'subDistrict')
          .first
          .options!
          .isEmpty) {
        var items = subDistrictDataMock['items'] as List;

        for (int i = 0; i < items.length; i++) {
          listSubDistrict.add(DropdownAddressModel.fromJson(items[i]));
        }

        listForm
            .where((element) => element.fieldName == 'subDistrict')
            .first
            .options!
            .addAll(listSubDistrict);
      }
    } else if (fieldName == 'subDistrict') {
      listForm!
          .where((element) => element.fieldName == 'zipCode')
          .first
          .controller!
          .clear();
      listForm
          .where((element) => element.fieldName == 'zipCode')
          .first
          .options!
          .clear();
      if (listResult!
          .where((element) => element.fieldName == 'subDistrict')
          .first
          .value!
          .isNotEmpty) {
        var subDistrict = listForm
            .where((element) => element.fieldName == 'subDistrict')
            .first
            .options;

        for (int i = 0; i < subDistrict!.length; i++) {
          if (!listZipCode.contains(subDistrict[i].zipCode)) {
            listZipCode.add(subDistrict[i].zipCode!);
          }
        }
        if (listZipCode.length > 1) {
          listForm
              .where((element) => element.fieldName == 'zipCode')
              .first
              .options!
              .addAll(listZipCode);
        } else if (listZipCode.length == 1) {
          listForm
              .where((element) => element.fieldName == 'zipCode')
              .first
              .options!
              .addAll(listZipCode);
          listForm
              .where((element) => element.fieldName == 'zipCode')
              .first
              .controller!
              .text = listZipCode[0];
        }
      }
    }

    emit(state.copyWith(
        status: ShippingAddressStatus.success,
        formWidgetModel: listForm,
        formResultModel: listResult));
  }

  setFormData() async {
    emit(state.copyWith(status: ShippingAddressStatus.loading));

    try {
      var response = await fetchDataFromApi(getProvinceAPIPath);
      if (response.statusCode == 200) {
        var province = response.data['items'] as List;

        // var province = provinceDataMock['items'] as List;
        List<DropdownAddressModel> listProvice = [];
        for (int i = 0; i < province.length; i++) {
          listProvice.add(DropdownAddressModel.fromJson(province[i]));
        }

        List<FormWidgetModel> listFormWidget = [
          FormWidgetModel(
            label: 'ชื่อ นามสกุล',
            controller: TextEditingController(),
            fieldName: 'name',
            formType: 'textField',
            required: true,
            maxLength: 250,
            maxLines: 1,
          ),
          FormWidgetModel(
              label: 'เบอร์โทรศัพท์',
              controller: TextEditingController(),
              fieldName: 'phone',
              keyboardType: TextInputType.number,
              formType: 'textField',
              listInputFormatter: [
                LengthLimitingTextInputFormatter(12),
                FilteringTextInputFormatter.allow(RegExp(r"[0-9-]")),
                FilteringTextInputFormatter.deny(RegExp(
                    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'))
              ],
              required: true,
              maxLines: 1),
          FormWidgetModel(
              label: 'อีเมล',
              controller: TextEditingController(),
              fieldName: 'email',
              formType: 'textField',
              required: true,
              maxLength: 250,
              maxLines: 1),
          FormWidgetModel(
              label: 'บ้านเลขที่ อาคาร ซอย หมู่ ถนน',
              controller: TextEditingController(),
              fieldName: 'address',
              formType: 'textField',
              required: true,
              isShowCounter: true,
              maxLength: 250,
              maxLines: null),
          FormWidgetModel(
            label: 'จังหวัด',
            controller: TextEditingController(),
            fieldName: 'province',
            formType: 'selectDropdown',
            options: listProvice,
          ),
          FormWidgetModel(
            label: 'เขต/อำเภอ',
            controller: TextEditingController(),
            fieldName: 'district',
            formType: 'selectDropdown',
            matchField: 'province',
            options: [],
          ),
          FormWidgetModel(
            label: 'แขวง/ตำบล',
            controller: TextEditingController(),
            fieldName: 'subDistrict',
            formType: 'selectDropdown',
            matchField: 'district',
            options: [],
          ),
          FormWidgetModel(
            label: 'รหัสไปรษณีย์',
            controller: TextEditingController(),
            fieldName: 'zipCode',
            formType: 'selectDropdown',
            matchField: 'subDistrict',
            options: [],
          ),
        ];
        List<FormWidgetResultModel> listResult = [];
        for (int i = 0; i < listFormWidget.length; i++) {
          listResult.add(FormWidgetResultModel(
              id: '', fieldName: listFormWidget[i].fieldName, value: ''));
        }
        emit(state.copyWith(
            status: ShippingAddressStatus.success,
            formWidgetModel: listFormWidget,
            formResultModel: listResult));
      }
    } catch (e) {
      emit(state.copyWith(status: ShippingAddressStatus.error));
    }
  }

  fetchDataFromApi(String path, {String refId = ""}) async {
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
    String accessToken = await lineDataHelper.getLineAccessToken();
    await Future.delayed(Duration(seconds: 3));
    // "{\"uid\":\"e959b083b3166422fb8717c6fe7e19e0cc6042dcb53976b26cb0c67085f636bf9fa8bef968f675d85619e150b1b2c91e6edf9859880ea63b38a5d18bca1b2be6\",\"access_token\":\"AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQH4nKVAp/gozm61a0mypo4DAAABVDCCAVAGCSqGSIb3DQEHBqCCAUEwggE9AgEAMIIBNgYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAynz3WmZaoMeGvYH4oCARCAggEHqA//8Lht7diWVyNlsaQGZNK1GVAqVXY1cBFN0p18t0EwzSNucJelmHFb6KGWvMztYNZbIaWFUw7LRpQfHUdl0hsd8atswL/LMQr3fDl6DCXeY/bo/K55is1gr9NYNASQfmLmLc16Nyjlvyu8A7HpH3yrxWtsX9g3PpoDJav7QQkFhtarnnwze9GTUJ4cXbU9nqhdG2teJPv/XFnqzQTucs0p2y+BNWSWM9q0+QSGj4r+LkwY7yy8AzlWMZU+s2H3lYqpNT5NBbevTgivXXYmE6YUvj+1FzC9boIkiyAPZCyDmVYH2FFfug/u/dP3tAjiBDHXqgMVxSm/lTRdi5u7iGoE7XHMqZY=\",\"refresh_token\":\"AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQGoZ4kJPpvz6OMAAAl4Ju/RAAAAcjBwBgkqhkiG9w0BBwagYzBhAgEAMFwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMhmG428hvR2jYE9KwAgEQgC8oYsKjK4WQzdcwG9ed0S9pCefIYEeo4EBRZ48uOQRWpXdZZ/I/l/kQG0aZ964vkg==\",\"expires_in\":2592000,\"tc_version\":\"1\",\"tc_accept\":\"false\"}"
    // const accessToken =
    //     "AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQGoZ4kJPpvz6OMAAAl4Ju/RAAAAcjBwBgkqhkiG9w0BBwagYzBhAgEAMFwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMhmG428hvR2jYE9KwAgEQgC8oYsKjK4WQzdcwG9ed0S9pCefIYEeo4EBRZ48uOQRWpXdZZ/I/l/kQG0aZ964vkg==";
    Map<String, dynamic> queryParams = {};
    if (path.contains('district')) {
      queryParams = {'province': refId};
    } else if (path.contains('subdistrict')) {
      queryParams = {'district': refId};
    }

    Response response = await dioUtilityRepository.getByURL(
        "$baseUrl$inventoryApiPath$path", queryParams,
        headers: {"Authorization": "Bearer $accessToken"});

    return response;
  }

  var provinceDataMock = {
    "allItems": 77,
    "page": 1,
    "countItems": 77,
    "items": [
      {
        "nameEn": "Bangkok",
        "version": "1",
        "nameTh": "กรุงเทพมหานคร",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "01",
        "regionId": "2"
      },
      {
        "nameEn": "Samut Prakan",
        "version": "1",
        "nameTh": "สมุทรปราการ",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "02",
        "regionId": "2"
      },
      {
        "nameEn": "Nonthaburi",
        "version": "1",
        "nameTh": "นนทบุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "03",
        "regionId": "2"
      },
      {
        "nameEn": "Pathum Thani",
        "version": "1",
        "nameTh": "ปทุมธานี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "04",
        "regionId": "2"
      },
      {
        "nameEn": "Phra Nakhon Si Ayutthaya",
        "version": "1",
        "nameTh": "พระนครศรีอยุธยา",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "05",
        "regionId": "2"
      },
      {
        "nameEn": "Ang Thong",
        "version": "1",
        "nameTh": "อ่างทอง",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "06",
        "regionId": "2"
      },
      {
        "nameEn": "Loburi",
        "version": "1",
        "nameTh": "ลพบุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "07",
        "regionId": "2"
      },
      {
        "nameEn": "Sing Buri",
        "version": "1",
        "nameTh": "สิงห์บุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "08",
        "regionId": "2"
      },
      {
        "nameEn": "Chai Nat",
        "version": "1",
        "nameTh": "ชัยนาท",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "09",
        "regionId": "2"
      },
      {
        "nameEn": "Saraburi",
        "version": "1",
        "nameTh": "สระบุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "10",
        "regionId": "2"
      },
      {
        "nameEn": "Chon Buri",
        "version": "1",
        "nameTh": "ชลบุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "11",
        "regionId": "5"
      },
      {
        "nameEn": "Rayong",
        "version": "1",
        "nameTh": "ระยอง",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "12",
        "regionId": "5"
      },
      {
        "nameEn": "Chanthaburi",
        "version": "1",
        "nameTh": "จันทบุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "13",
        "regionId": "5"
      },
      {
        "nameEn": "Trat",
        "version": "1",
        "nameTh": "ตราด",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "14",
        "regionId": "5"
      },
      {
        "nameEn": "Chachoengsao",
        "version": "1",
        "nameTh": "ฉะเชิงเทรา",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "15",
        "regionId": "5"
      },
      {
        "nameEn": "Prachin Buri",
        "version": "1",
        "nameTh": "ปราจีนบุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "16",
        "regionId": "5"
      },
      {
        "nameEn": "Nakhon Nayok",
        "version": "1",
        "nameTh": "นครนายก",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "17",
        "regionId": "2"
      },
      {
        "nameEn": "Sa Kaeo",
        "version": "1",
        "nameTh": "สระแก้ว",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "18",
        "regionId": "5"
      },
      {
        "nameEn": "Nakhon Ratchasima",
        "version": "1",
        "nameTh": "นครราชสีมา",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "19",
        "regionId": "3"
      },
      {
        "nameEn": "Buri Ram",
        "version": "1",
        "nameTh": "บุรีรัมย์",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "20",
        "regionId": "3"
      },
      {
        "nameEn": "Surin",
        "version": "1",
        "nameTh": "สุรินทร์",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "21",
        "regionId": "3"
      },
      {
        "nameEn": "Si Sa Ket",
        "version": "1",
        "nameTh": "ศรีสะเกษ",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "22",
        "regionId": "3"
      },
      {
        "nameEn": "Ubon Ratchathani",
        "version": "1",
        "nameTh": "อุบลราชธานี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "23",
        "regionId": "3"
      },
      {
        "nameEn": "Yasothon",
        "version": "1",
        "nameTh": "ยโสธร",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "24",
        "regionId": "3"
      },
      {
        "nameEn": "Chaiyaphum",
        "version": "1",
        "nameTh": "ชัยภูมิ",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "25",
        "regionId": "3"
      },
      {
        "nameEn": "Amnat Charoen",
        "version": "1",
        "nameTh": "อำนาจเจริญ",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "26",
        "regionId": "3"
      },
      {
        "nameEn": "Nong Bua Lam Phu",
        "version": "1",
        "nameTh": "หนองบัวลำภู",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "27",
        "regionId": "3"
      },
      {
        "nameEn": "Khon Kaen",
        "version": "1",
        "nameTh": "ขอนแก่น",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "28",
        "regionId": "3"
      },
      {
        "nameEn": "Udon Thani",
        "version": "1",
        "nameTh": "อุดรธานี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "29",
        "regionId": "3"
      },
      {
        "nameEn": "Loei",
        "version": "1",
        "nameTh": "เลย",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "30",
        "regionId": "3"
      },
      {
        "nameEn": "Nong Khai",
        "version": "1",
        "nameTh": "หนองคาย",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "31",
        "regionId": "3"
      },
      {
        "nameEn": "Maha Sarakham",
        "version": "1",
        "nameTh": "มหาสารคาม",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "32",
        "regionId": "3"
      },
      {
        "nameEn": "Roi Et",
        "version": "1",
        "nameTh": "ร้อยเอ็ด",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "33",
        "regionId": "3"
      },
      {
        "nameEn": "Kalasin",
        "version": "1",
        "nameTh": "กาฬสินธุ์",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "34",
        "regionId": "3"
      },
      {
        "nameEn": "Sakon Nakhon",
        "version": "1",
        "nameTh": "สกลนคร",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "35",
        "regionId": "3"
      },
      {
        "nameEn": "Nakhon Phanom",
        "version": "1",
        "nameTh": "นครพนม",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "36",
        "regionId": "3"
      },
      {
        "nameEn": "Mukdahan",
        "version": "1",
        "nameTh": "มุกดาหาร",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "37",
        "regionId": "3"
      },
      {
        "nameEn": "Chiang Mai",
        "version": "1",
        "nameTh": "เชียงใหม่",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "38",
        "regionId": "1"
      },
      {
        "nameEn": "Lamphun",
        "version": "1",
        "nameTh": "ลำพูน",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "39",
        "regionId": "1"
      },
      {
        "nameEn": "Lampang",
        "version": "1",
        "nameTh": "ลำปาง",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "40",
        "regionId": "1"
      },
      {
        "nameEn": "Uttaradit",
        "version": "1",
        "nameTh": "อุตรดิตถ์",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "41",
        "regionId": "1"
      },
      {
        "nameEn": "Phrae",
        "version": "1",
        "nameTh": "แพร่",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "42",
        "regionId": "1"
      },
      {
        "nameEn": "Nan",
        "version": "1",
        "nameTh": "น่าน",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "43",
        "regionId": "1"
      },
      {
        "nameEn": "Phayao",
        "version": "1",
        "nameTh": "พะเยา",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "44",
        "regionId": "1"
      },
      {
        "nameEn": "Chiang Rai",
        "version": "1",
        "nameTh": "เชียงราย",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "45",
        "regionId": "1"
      },
      {
        "nameEn": "Mae Hong Son",
        "version": "1",
        "nameTh": "แม่ฮ่องสอน",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "46",
        "regionId": "1"
      },
      {
        "nameEn": "Nakhon Sawan",
        "version": "1",
        "nameTh": "นครสวรรค์",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "47",
        "regionId": "2"
      },
      {
        "nameEn": "Uthai Thani",
        "version": "1",
        "nameTh": "อุทัยธานี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "48",
        "regionId": "2"
      },
      {
        "nameEn": "Kamphaeng Phet",
        "version": "1",
        "nameTh": "กำแพงเพชร",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "49",
        "regionId": "2"
      },
      {
        "nameEn": "Tak",
        "version": "1",
        "nameTh": "ตาก",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "50",
        "regionId": "4"
      },
      {
        "nameEn": "Sukhothai",
        "version": "1",
        "nameTh": "สุโขทัย",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "51",
        "regionId": "2"
      },
      {
        "nameEn": "Phitsanulok",
        "version": "1",
        "nameTh": "พิษณุโลก",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "52",
        "regionId": "2"
      },
      {
        "nameEn": "Phichit",
        "version": "1",
        "nameTh": "พิจิตร",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "53",
        "regionId": "2"
      },
      {
        "nameEn": "Phetchabun",
        "version": "1",
        "nameTh": "เพชรบูรณ์",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "54",
        "regionId": "2"
      },
      {
        "nameEn": "Ratchaburi",
        "version": "1",
        "nameTh": "ราชบุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "55",
        "regionId": "4"
      },
      {
        "nameEn": "Kanchanaburi",
        "version": "1",
        "nameTh": "กาญจนบุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "56",
        "regionId": "4"
      },
      {
        "nameEn": "Suphan Buri",
        "version": "1",
        "nameTh": "สุพรรณบุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "57",
        "regionId": "2"
      },
      {
        "nameEn": "Nakhon Pathom",
        "version": "1",
        "nameTh": "นครปฐม",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "58",
        "regionId": "2"
      },
      {
        "nameEn": "Samut Sakhon",
        "version": "1",
        "nameTh": "สมุทรสาคร",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "59",
        "regionId": "2"
      },
      {
        "nameEn": "Samut Songkhram",
        "version": "1",
        "nameTh": "สมุทรสงคราม",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "60",
        "regionId": "2"
      },
      {
        "nameEn": "Phetchaburi",
        "version": "1",
        "nameTh": "เพชรบุรี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "61",
        "regionId": "4"
      },
      {
        "nameEn": "Prachuap Khiri Khan",
        "version": "1",
        "nameTh": "ประจวบคีรีขันธ์",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "62",
        "regionId": "4"
      },
      {
        "nameEn": "Nakhon Si Thammarat",
        "version": "1",
        "nameTh": "นครศรีธรรมราช",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "63",
        "regionId": "6"
      },
      {
        "nameEn": "Krabi",
        "version": "1",
        "nameTh": "กระบี่",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "64",
        "regionId": "6"
      },
      {
        "nameEn": "Phangnga",
        "version": "1",
        "nameTh": "พังงา",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "65",
        "regionId": "6"
      },
      {
        "nameEn": "Phuket",
        "version": "1",
        "nameTh": "ภูเก็ต",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "66",
        "regionId": "6"
      },
      {
        "nameEn": "Surat Thani",
        "version": "1",
        "nameTh": "สุราษฎร์ธานี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "67",
        "regionId": "6"
      },
      {
        "nameEn": "Ranong",
        "version": "1",
        "nameTh": "ระนอง",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "68",
        "regionId": "6"
      },
      {
        "nameEn": "Chumphon",
        "version": "1",
        "nameTh": "ชุมพร",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "69",
        "regionId": "6"
      },
      {
        "nameEn": "Songkhla",
        "version": "1",
        "nameTh": "สงขลา",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "70",
        "regionId": "6"
      },
      {
        "nameEn": "Satun",
        "version": "1",
        "nameTh": "สตูล",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "71",
        "regionId": "6"
      },
      {
        "nameEn": "Trang",
        "version": "1",
        "nameTh": "ตรัง",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "72",
        "regionId": "6"
      },
      {
        "nameEn": "Phatthalung",
        "version": "1",
        "nameTh": "พัทลุง",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "73",
        "regionId": "6"
      },
      {
        "nameEn": "Pattani",
        "version": "1",
        "nameTh": "ปัตตานี",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "74",
        "regionId": "6"
      },
      {
        "nameEn": "Yala",
        "version": "1",
        "nameTh": "ยะลา",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "75",
        "regionId": "6"
      },
      {
        "nameEn": "Narathiwat",
        "version": "1",
        "nameTh": "นราธิวาส",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "76",
        "regionId": "6"
      },
      {
        "nameEn": "buogkan",
        "version": "1",
        "nameTh": "บึงกาฬ",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "77",
        "regionId": "3"
      }
    ]
  };

  var districtDataMock = {
    "allItems": 50,
    "page": 1,
    "countItems": 50,
    "items": [
      {
        "nameEn": "Khet Phra Nakhon",
        "createdDatetime": "2023-25-09 04:30:30",
        "id": "0101",
        "nameTh": "เขตพระนคร",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Dusit",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0102",
        "nameTh": "เขตดุสิต",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Nong Chok",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0103",
        "nameTh": "เขตหนองจอก",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bang Rak",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0104",
        "nameTh": "เขตบางรัก",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bang Khen",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0105",
        "nameTh": "เขตบางเขน",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bang Kapi",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0106",
        "nameTh": "เขตบางกะปิ",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Pathum Wan",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0107",
        "nameTh": "เขตปทุมวัน",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Pom Prap Sattru Phai",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0108",
        "nameTh": "เขตป้อมปราบศัตรูพ่าย",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Phra Khanong",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0109",
        "nameTh": "เขตพระโขนง",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Min Buri",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0110",
        "nameTh": "เขตมีนบุรี",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Lat Krabang",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0111",
        "nameTh": "เขตลาดกระบัง",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Yan Nawa",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0112",
        "nameTh": "เขตยานนาวา",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Samphanthawong",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0113",
        "nameTh": "เขตสัมพันธวงศ์",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Phaya Thai",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0114",
        "nameTh": "เขตพญาไท",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Thon Buri",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0115",
        "nameTh": "เขตธนบุรี",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bangkok Yai",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0116",
        "nameTh": "เขตบางกอกใหญ่",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Huai Khwang",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0117",
        "nameTh": "เขตห้วยขวาง",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Khlong San",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0118",
        "nameTh": "เขตคลองสาน",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Taling Chan",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0119",
        "nameTh": "เขตตลิ่งชัน",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bangkok Noi",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0120",
        "nameTh": "เขตบางกอกน้อย",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bang Khun Thian",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0121",
        "nameTh": "เขตบางขุนเทียน",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Phasi Charoen",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0122",
        "nameTh": "เขตภาษีเจริญ",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Nong Khaem",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0123",
        "nameTh": "เขตหนองแขม",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Rat Burana",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0124",
        "nameTh": "เขตราษฎร์บูรณะ",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bang Phlat",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0125",
        "nameTh": "เขตบางพลัด",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Din Daeng",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0126",
        "nameTh": "เขตดินแดง",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bueng Kum",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0127",
        "nameTh": "เขตบึงกุ่ม",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Sathon",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0128",
        "nameTh": "เขตสาทร",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bang Sue",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0129",
        "nameTh": "เขตบางซื่อ",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Chatuchak",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0130",
        "nameTh": "เขตจตุจักร",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bang Kho Laem",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0131",
        "nameTh": "เขตบางคอแหลม",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Prawet",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0132",
        "nameTh": "เขตประเวศ",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Khlong Toei",
        "createdDatetime": "2023-25-09 04:30:31",
        "id": "0133",
        "nameTh": "เขตคลองเตย",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Suan Luang",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0134",
        "nameTh": "เขตสวนหลวง",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Chom Thong",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0135",
        "nameTh": "เขตจอมทอง",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Don Mueang",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0136",
        "nameTh": "เขตดอนเมือง",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Ratchathewi",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0137",
        "nameTh": "เขตราชเทวี",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Lat Phrao",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0138",
        "nameTh": "เขตลาดพร้าว",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Watthana",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0139",
        "nameTh": "เขตวัฒนา",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bang Khae",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0140",
        "nameTh": "เขตบางแค",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Lak Si",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0141",
        "nameTh": "เขตหลักสี่",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Sai Mai",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0142",
        "nameTh": "เขตสายไหม",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Khan Na Yao",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0143",
        "nameTh": "เขตคันนายาว",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Saphan Sung",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0144",
        "nameTh": "เขตสะพานสูง",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Wang Thonglang",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0145",
        "nameTh": "เขตวังทองหลาง",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Khlong Sam Wa",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0146",
        "nameTh": "เขตคลองสามวา",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bang Na",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0147",
        "nameTh": "เขตบางนา",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Thawi Watthana",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0148",
        "nameTh": "เขตทวีวัฒนา",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Thung Khru",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0149",
        "nameTh": "เขตทุ่งครุ",
        "provinceId": "01"
      },
      {
        "nameEn": "Khet Bang Bon",
        "createdDatetime": "2023-25-09 04:30:32",
        "id": "0150",
        "nameTh": "เขตบางบอน",
        "provinceId": "01"
      }
    ]
  };

  var subDistrictDataMock = {
    "allItems": 12,
    "page": 1,
    "countItems": 12,
    "items": [
      {
        "nameEn": "Phra Borom Maha Ratchawang",
        "zipcode": "10200",
        "nameTh": "พระบรมมหาราชวัง",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010101"
      },
      {
        "nameEn": "Wang Burapha Phirom",
        "zipcode": "10200",
        "nameTh": "วังบูรพาภิรมย์",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010102"
      },
      {
        "nameEn": "Wat Ratchabophit",
        "zipcode": "10200",
        "nameTh": "วัดราชบพิธ",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010103"
      },
      {
        "nameEn": "Samran Rat",
        "zipcode": "10200",
        "nameTh": "สำราญราษฎร์",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010104"
      },
      {
        "nameEn": "San Chao Pho Suea",
        "zipcode": "10200",
        "nameTh": "ศาลเจ้าพ่อเสือ",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010105"
      },
      {
        "nameEn": "Sao Chingcha",
        "zipcode": "10200",
        "nameTh": "เสาชิงช้า",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010106"
      },
      {
        "nameEn": "Bowon Niwet",
        "zipcode": "10200",
        "nameTh": "บวรนิเวศ",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010107"
      },
      {
        "nameEn": "Talat Yot",
        "zipcode": "10200",
        "nameTh": "ตลาดยอด",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010108"
      },
      {
        "nameEn": "Chana Songkhram",
        "zipcode": "10200",
        "nameTh": "ชนะสงคราม",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010109"
      },
      {
        "nameEn": "Ban Phan Thom",
        "zipcode": "10200",
        "nameTh": "บ้านพานถม",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010110"
      },
      {
        "nameEn": "Bang Khun Phrom",
        "zipcode": "10200",
        "nameTh": "บางขุนพรหม",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010111"
      },
      {
        "nameEn": "Wat Sam Phraya",
        "zipcode": "10200",
        "nameTh": "วัดสามพระยา",
        "districtId": "0101",
        "createdDatetime": "2023-25-09 04:30:33",
        "id": "010112"
      }
    ]
  };
}
