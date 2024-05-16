import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autoStation_promptBuy/configs/enivironment_config.dart';
import 'package:autoStation_promptBuy/src/model/product_summary/create_order_request_model.dart';
import 'package:autoStation_promptBuy/src/model/product_summary/order_response_model.dart';
import 'package:autoStation_promptBuy/src/repositories/dio_utility_repository.dart';

part 'order_summary_event.dart';
part 'order_summary_state.dart';

class OrderSummaryBloc extends Bloc<OrderSummaryEvent, OrderSummaryState> {
  OrderSummaryBloc({required this.utilityRepository}) : super(OrderSummaryState()) {
    on<InitialOrderState>((event, emit) {
      emit(state.copyWith(paymentType: PaymentType.none, orderStatus: OrderStatus.initial, orderResponseModel: OrderResponseModel.empty));
    });
    on<SelectPaymentType>((event, emit) {
      emit(state.copyWith(paymentType: event.paymentType));
    });
    on<CreateOrder>(_onCreateOrder);
  }
  final DioUtilityRepository utilityRepository;

  _onCreateOrder(CreateOrder event, Emitter<OrderSummaryState> emit) async {
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final transactionApiPath = Environment().getValue("BFF_TRANSACTION_CREATE_BASE_URL");
    emit(state.copyWith(orderStatus: OrderStatus.loading));

    try {
      String path = "/v1/create";
      Response response = await utilityRepository.postByURL("$baseUrl$transactionApiPath$path", event.requestModel.toJson());

      final o = OrderResponseModel.fromJson(response.data);
      emit(state.copyWith(orderStatus: OrderStatus.success, orderResponseModel: o));
    } catch (e) {
      emit(state.copyWith(orderStatus: OrderStatus.error));
    }
  }
}
