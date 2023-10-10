part of 'shipping_address_bloc.dart';

class ShippingAddressEvent {
  const ShippingAddressEvent();

  @override
  List<Object> get props => [];
}

class SetFormWidget extends ShippingAddressEvent {
  const SetFormWidget({required this.listForm});
  final List<FormWidgetModel> listForm;

  @override
  List<Object> get props => [listForm];
}
