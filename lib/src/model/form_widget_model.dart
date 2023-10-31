import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension FormWidgetX on FormWidgetModel {
  bool get isEmpty => this != FormWidgetModel.empty;
}

class FormWidgetModel {
  final GlobalKey<FormState>? key;
  final String label;
  final TextEditingController? controller;
  final String fieldName;
  final String formType;
  final bool isHiding;
  final dynamic value;
  final List<dynamic>? options;
  final bool required;
  final TextInputType? keyboardType;
  final List<String>? childSelectFields;
  final List<dynamic>? visibleIfMatchValue;
  final String? matchField;
  final int? maxLength;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? checkRequiredField;
  final List<dynamic>? checkRequiredFieldMatchValue;
  final String? textControllerValue;
  final bool isShowCounter;
  final List<TextInputFormatter>? listInputFormatter;
  final FocusNode? focusNode;

  const FormWidgetModel(
      {this.key,
      this.label = '',
      this.controller,
      this.fieldName = '',
      this.formType = '',
      this.value,
      this.options,
      this.isHiding = false,
      this.required = false,
      this.keyboardType,
      this.childSelectFields,
      this.visibleIfMatchValue,
      this.matchField,
      this.maxLength,
      this.textInputType,
      this.maxLines,
      this.checkRequiredField,
      this.checkRequiredFieldMatchValue,
      this.textControllerValue,
      this.isShowCounter = false,
      this.listInputFormatter,
      this.focusNode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['fieldName'] = fieldName;
    data['formType'] = formType;
    data['value'] = value;
    data['options'] = options;
    data['isHiding'] = isHiding;
    data['required'] = required;
    data['keyboardType'] = keyboardType;
    data['childSelectFields'] = childSelectFields;
    data['visibleIfMatchValue'] = visibleIfMatchValue;
    data['matchField'] = matchField;
    data['maxLength'] = maxLength;
    data['maxLines'] = maxLines;
    data['checkRequiredField'] = checkRequiredField;
    data['checkRequiredFieldMatchValue'] = checkRequiredFieldMatchValue;
    data['textControllerValue'] = textControllerValue;
    data['isShowCounter'] = isShowCounter;
    data['listInputFormatter'] = listInputFormatter;
    return data;
  }

  static const empty = FormWidgetModel(
    label: '',
    fieldName: '',
    formType: '',
  );
}

class FormWidgetResultModel {
  String? id;
  String? fieldName;
  String? value;
  FormWidgetResultModel({this.id, this.fieldName, this.value});
}
