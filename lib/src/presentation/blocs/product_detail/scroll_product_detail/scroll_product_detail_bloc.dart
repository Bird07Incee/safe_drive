import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scroll_product_detail_event.dart';
part 'scroll_product_detail_state.dart';

class ScrollProductDetailBloc extends Bloc<ScrollProductDetailEvent, ScrollProductDetailState> {
  ScrollProductDetailBloc() : super(const ScrollProductDetailState()) {
    on<ProductDetailScrollAction>(_scrollingProcess);
  }
  void _scrollingProcess(ProductDetailScrollAction event, Emitter<ScrollProductDetailState> emit) {
    if (!state.appBarCarDetailStatus && event.pixels > ((event.maxWidth - 32.0) / 16) * 9 + 270) {
      emit(state.copyWith(appBarCarDetailStatus: true));
    } else if (state.appBarCarDetailStatus && event.pixels < ((event.maxWidth - 32.0) / 16) * 9 + 270 || event.isPopNavigator == "1") {
      emit(state.copyWith(appBarCarDetailStatus: false));
    }
  }
}
