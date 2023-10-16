part of 'shipping_address_bloc.dart';

class ShippingAddressEvent {
  const ShippingAddressEvent();

  @override
  List<Object> get props => [];
}

class SetFormWidget extends ShippingAddressEvent {
  SetFormWidget({required this.listForm, required this.listResult});
  final List<FormWidgetModel> listForm;
  List<FormWidgetResultModel> listResult;

  @override
  List<Object> get props => [listForm];
}
