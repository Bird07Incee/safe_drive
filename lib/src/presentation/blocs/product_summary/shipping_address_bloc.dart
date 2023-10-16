import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/model/form_widget_model.dart';
import 'package:marketplace_line_oa/src/model/product_summary/shipping_address_model.dart';

part 'shipping_address_event.dart';
part 'shipping_address_state.dart';

class ShippingAddressBloc
    extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  ShippingAddressBloc() : super(ShippingAddressState()) {
    on<SetFormWidget>(_setFormData);
  }

  _setFormData(SetFormWidget event, Emitter<ShippingAddressState> emit) {
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
    emit(state.copyWith(
        status: ShippingAddressStatus.success,
        formWidgetModel: listFormWidget,
        formResultModel: listResult));
  }
}
