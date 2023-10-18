part of 'shipping_address_bloc.dart';

enum ShippingAddressStatus { initial, loading, success, error }

extension AddressStatusX on ShippingAddressStatus {
  bool get isInitial => this == ShippingAddressStatus.initial;
  bool get isLoading => this == ShippingAddressStatus.loading;
  bool get isSuccess => this == ShippingAddressStatus.success;
  bool get isError => this == ShippingAddressStatus.error;
}

class ShippingAddressState extends Equatable {
  ShippingAddressState(
      {this.status = ShippingAddressStatus.initial,
      this.addressModel = ShippingAddressModel.empty,
      this.listFormWidget,
      this.formResult,
      this.mainFormKey,
      this.isAllowSubmit = false});
  final ShippingAddressModel addressModel;
  final ShippingAddressStatus status;
  final List<FormWidgetModel>? listFormWidget;
  bool isAllowSubmit;
  List<FormWidgetResultModel>? formResult;
  GlobalKey<FormState>? mainFormKey = GlobalKey<FormState>();

  @override
  List<Object> get props => [status, addressModel, isAllowSubmit];

  ShippingAddressState copyWith(
      {ShippingAddressStatus? status,
      ShippingAddressModel? address,
      List<FormWidgetModel>? formWidgetModel,
      List<FormWidgetResultModel>? formResultModel,
      bool? allowSubmit}) {
    return ShippingAddressState(
        status: status ?? this.status,
        addressModel: address ?? addressModel,
        listFormWidget: formWidgetModel ?? listFormWidget,
        formResult: formResultModel ?? formResult,
        isAllowSubmit: allowSubmit ?? isAllowSubmit);
  }
}
