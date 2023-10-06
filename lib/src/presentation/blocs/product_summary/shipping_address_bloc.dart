import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    List<FormWidgetModel> formWidget = [
      FormWidgetModel(
        label: 'อื่นๆ โปรดระบุ',
        controller: TextEditingController(),
        fieldName: 'addressDetail',
        formType: 'textField',
        required: true,
        visibleIfMatchValue: ["CR2", "CR3"],
        matchField: 'addressCheck',
        maxLength: 40,
        maxLines: 2,
      ),
      FormWidgetModel(
        label: 'ตรวจ',
        controller: TextEditingController(),
        fieldName: 'addressCheck',
        formType: 'selectDropdown',
        options: [
          {"label": "ถูกต้องตามแจ้ง", "value": "CR1"},
          {"label": "ไม่ถูกต้อง แต่ที่ถูกต้อง คือ...", "value": "CR2"},
          {"label": "ไม่พบสถานที่ตั้ง ตามแจ้ง...", "value": "CR3"},
        ],
        required: true,
      ),
      FormWidgetModel(
        label: 'ลักษณะที่อยู่อาศัย',
        controller: TextEditingController(),
        fieldName: 'houseType',
        formType: 'selectDropdown',
        visibleIfMatchValue: ["CR1", "CR2"],
        matchField: 'addressCheck',
        options: [
          {"label": "บ้านเดี่ยวเนื้อที่...ตร.ว.", "value": "AT1"},
          {"label": "บ้านฝาแฝดเนื้อที่...ตร.ว.", "value": "AT2"},
          {"label": "ทาวน์เฮ้าส์เนื้อที่...ตร.ว.", "value": "AT3"},
          {"label": "อาคารพานิชย์", "value": "AT4"},
          {"label": "แฟลต/อาคารชุด", "value": "AT5"},
          {"label": "อื่นๆ...", "value": "AT6"},
        ],
      ),
      FormWidgetModel(
        label: 'ระบุเนื้อที่ ตร.ว.',
        controller: TextEditingController(),
        fieldName: 'areaSize',
        formType: 'textField',
        required: true,
        visibleIfMatchValue: ["AT1", "AT2", "AT3"],
        matchField: 'houseType',
        textInputType: TextInputType.number,
        maxLength: 10,
      ),
      FormWidgetModel(
        label: 'อื่นๆ โปรดระบุ',
        controller: TextEditingController(),
        fieldName: 'houseDetail',
        formType: 'textField',
        required: true,
        visibleIfMatchValue: ["AT6"],
        matchField: 'houseType',
        maxLength: 40,
        maxLines: 2,
      ),
      FormWidgetModel(
        label: 'สถานภาพ',
        controller: TextEditingController(),
        fieldName: 'addressStatus',
        formType: 'selectDropdown',
        options: [
          {"label": "เจ้าบ้าน", "value": "AS1"},
          {"label": "เจ้าของบ้าน", "value": "AS2"},
          {"label": "บ้านบิดามารดา", "value": "AS3"},
          {"label": "บ้านสามีภรรยา", "value": "AS4"},
          {"label": "อาศัยกับ...", "value": "AS5"},
          {"label": "เช่าเดือนละ...", "value": "AS6"},
          {"label": "เซ้ง...", "value": "AS7"},
          {"label": "บ้านพักราชการ/บริษัท", "value": "AS8"},
          {"label": "อื่นๆ...", "value": "AS9"},
        ],
        visibleIfMatchValue: ["CR1", "CR2"],
        matchField: 'addressCheck',
      ),
      FormWidgetModel(
        label: 'อื่นๆ โปรดระบุ',
        controller: TextEditingController(),
        fieldName: 'addressOther',
        formType: 'textField',
        required: true,
        visibleIfMatchValue: ["AS5", "AS6", "AS7", "AS9"],
        matchField: 'addressStatus',
        maxLength: 40,
        maxLines: 2,
      ),
      FormWidgetModel(
        label: 'เพิ่มเติม',
        controller: TextEditingController(),
        fieldName: 'houseRemark',
        formType: 'textField',
        required: false,
        maxLength: 316,
        maxLines: 15,
      ),
    ];
    emit(state.copyWith(status: ShippingAddressStatus.success));
  }
}
