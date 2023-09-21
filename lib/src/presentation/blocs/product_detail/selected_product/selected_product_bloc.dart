import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/model/product_list.dart';

part 'selected_product_event.dart';
part 'selected_product_state.dart';

class SelectedProductBloc extends Bloc<SelectedProductEvent, SelectedProductState> {
  SelectedProductBloc() : super(const SelectedProductState()) {
    on<SelectedProductEvent>((event, emit) {
      emit(state.copyWith(selectedProduct: event.p));
    });
  }
}
