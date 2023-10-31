part of 'shipping_address_bloc.dart';

enum ShippingAddressStatus { initial, loading, success, error, fetching }

extension AddressStatusX on ShippingAddressStatus {
  bool get isInitial => this == ShippingAddressStatus.initial;
  bool get isLoading => this == ShippingAddressStatus.loading;
  bool get isSuccess => this == ShippingAddressStatus.success;
  bool get isError => this == ShippingAddressStatus.error;
  bool get isFetching => this == ShippingAddressStatus.fetching;
}

class ShippingAddressState extends Equatable {
  const ShippingAddressState(
      {this.status = ShippingAddressStatus.initial,
      this.addressModel = ShippingAddressModel.empty,
      this.listFormWidget,
      this.formResult,
      this.isAllowSubmit = false,
      this.isFromEditing = false});
  final ShippingAddressModel addressModel;
  final ShippingAddressStatus status;
  final List<FormWidgetModel>? listFormWidget;
  final bool isFromEditing;
  final bool isAllowSubmit;
  final List<FormWidgetResultModel>? formResult;

  @override
  List<Object> get props => [status, addressModel, isAllowSubmit, isFromEditing];

  ShippingAddressState copyWith(
      {ShippingAddressStatus? stateStatus,
      ShippingAddressModel? address,
      List<FormWidgetModel>? formWidgetModel,
      List<FormWidgetResultModel>? formResultModel,
      bool? isEditing,
      bool? allowSubmit}) {
    return ShippingAddressState(
        status: stateStatus ?? status,
        addressModel: address ?? addressModel,
        listFormWidget: formWidgetModel ?? listFormWidget,
        formResult: formResultModel ?? formResult,
        isFromEditing: isEditing ?? isFromEditing,
        isAllowSubmit: allowSubmit ?? isAllowSubmit);
  }
}
