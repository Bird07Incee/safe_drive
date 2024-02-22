part of 'shipping_address_bloc.dart';

class ShippingAddressEvent extends Equatable {
  const ShippingAddressEvent();

  @override
  List<Object> get props => [];
}

class SetFormWidget extends ShippingAddressEvent {
  const SetFormWidget({required this.listForm, required this.listResult});
  final List<FormWidgetModel> listForm;
  final List<FormWidgetResultModel> listResult;

  @override
  List<Object> get props => [listForm, listResult];
}
