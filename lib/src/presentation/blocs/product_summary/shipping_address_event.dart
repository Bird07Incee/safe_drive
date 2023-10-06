part of 'shipping_address_bloc.dart';

class ShippingAddressEvent {
  const ShippingAddressEvent();

  @override
  List<Object> get props => [];
}

class SetFormWidget extends ShippingAddressEvent {
  const SetFormWidget({required this.form});
  final FormWidgetModel form;

  @override
  List<Object> get props => [form];
}
