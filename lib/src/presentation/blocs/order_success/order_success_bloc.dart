import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marketplace_line_oa/src/model/inquiry_data.dart';

part 'order_success_event.dart';
part 'order_success_state.dart';

class OrderSuccessBloc extends Bloc<OrderSuccessEvent, OrderSuccessState> {
  OrderSuccessBloc() : super(OrderSuccessState()) {
    on<OrderSuccessEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
