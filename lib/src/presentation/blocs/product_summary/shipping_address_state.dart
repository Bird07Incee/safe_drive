part of 'shipping_address_bloc.dart';

enum ShippingAddressStatus { initial, loading, success, error }

extension AddressStatusX on ShippingAddressStatus {
  bool get isInitial => this == ShippingAddressStatus.initial;
  bool get isLoading => this == ShippingAddressStatus.loading;
  bool get isSuccess => this == ShippingAddressStatus.success;
  bool get isError => this == ShippingAddressStatus.error;
}

class ShippingAddressState extends Equatable {
  const ShippingAddressState(
      {this.status = ShippingAddressStatus.initial,
      this.addressModel = ShippingAddressModel.empty,
      this.formWidget = FormWidgetModel.empty});
  final ShippingAddressModel addressModel;
  final ShippingAddressStatus status;
  final FormWidgetModel formWidget;

  @override
  List<Object> get props => [status, addressModel];

  ShippingAddressState copyWith(
      {ShippingAddressStatus? status,
      ShippingAddressModel? address,
      FormWidgetModel? formWidgetModel}) {
    return ShippingAddressState(
        status: status ?? this.status,
        addressModel: address ?? addressModel,
        formWidget: formWidgetModel ?? formWidget);
  }
}
