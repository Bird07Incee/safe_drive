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

class ShippingAddressBloc
    extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  ShippingAddressBloc() : super(ShippingAddressState()) {
    on<SetFormWidget>(_setFormData);
  }
  final DioUtilityRepository dioUtilityRepository =
      DioUtilityRepository(service: DioUtilityService(dio: DioClient.client));

  _setFormData(SetFormWidget event, Emitter<ShippingAddressState> emit) async {
    emit(state.copyWith(status: ShippingAddressStatus.loading));

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
          maxLines: 1),
      FormWidgetModel(
        label: 'จังหวัด',
        controller: TextEditingController(),
        fieldName: 'province',
        formType: 'selectDropdown',
        options: [
          {"label": "test1", "value": "1"},
        ],
      ),
      FormWidgetModel(
        label: 'เขต/อำเภอ',
        controller: TextEditingController(),
        fieldName: 'district',
        formType: 'selectDropdown',
        matchField: 'province',
        options: [
          {"label": "test1", "value": "1"},
        ],
      ),
      FormWidgetModel(
        label: 'แขวง/ตำบล',
        controller: TextEditingController(),
        fieldName: 'subDistrict',
        formType: 'selectDropdown',
        matchField: 'district',
        options: [
          {"label": "test1", "value": "1"},
        ],
      ),
      FormWidgetModel(
        label: 'รหัสไปรษณีย์',
        controller: TextEditingController(),
        fieldName: 'zipCode',
        formType: 'selectDropdown',
        matchField: 'subDistrict',
        options: [
          {"label": "test1", "value": "1"},
        ],
      ),
    ];
    List<FormWidgetResultModel> listResult = [];
    for (int i = 0; i < listFormWidget.length; i++) {
      listResult.add(FormWidgetResultModel(listFormWidget[i].fieldName, ''));
    }

    try {
      String path = "/ecommerce/v1/data/province";
      LineDataHelper lineDataHelper = LineDataHelper();
      final baseUrl = Environment().getValue("BFF_BASE_URL");
      final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
      // String accessToken = await lineDataHelper.getLineAccessToken();
      const accessToken =
          "AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQEUk3/Zj+oXruNIaluHKaLyAAABVDCCAVAGCSqGSIb3DQEHBqCCAUEwggE9AgEAMIIBNgYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAwU35iBDNidEe3In6YCARCAggEHapD+3ohNbUyQshpMkrgAsg7klkyxCW1ZYFmwUNtr6IDuetQ3c0/yChhINiYRAPMloZ7aY2abHIkS3xVUblaznTUy+fbw6KcPON19rABqciIzDj9fB8Dxog+BdYbsjc0zOA2Aw/rAA7cI9Lyn22YNZTb51wXFINYI/tTyGxgPPMXukDkHQvo0H4asAvTka6FXjldV8t/W365W53PUD5Wy1KedP3XZ8rWeBRYfs7gO42ixVhjQbLS/1o1VfN61wvdRpkQO1ba2afeV86L6qDihXg9xoNzBvHcKcobmTY+NvT3LjMPc2lHYIO5CfgC3CEDAnNiPxobENBR5SpLZNrxQ10lDkY8ZqFk=";

      Response response = await dioUtilityRepository.getByURL(
          "$baseUrl$inventoryApiPath$path", {},
          headers: {"Authorization": "Bearer $accessToken"});
      if (response.statusCode == 200) {
        var province = DropdownAddressModel.fromJson(response.data['items']);
        print(province);
        emit(state.copyWith(
            status: ShippingAddressStatus.success,
            formWidgetModel: listFormWidget,
            formResultModel: listResult));
      }
    } catch (e) {
      emit(state.copyWith(status: ShippingAddressStatus.error));
    }
  }
}
