import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_detail_carousel_scroll_controller_event.dart';
part 'product_detail_carousel_scroll_controller_state.dart';

class ProductDetailCarouselScrollControllerBloc
    extends Bloc<ProductDetailCarouselScrollControllerEvent, PageController> {
  ProductDetailCarouselScrollControllerBloc() : super(PageController()) {
    on<CarouselScrollAction>((event, emit) {
      PageController pageController = PageController(initialPage: event.index, keepPage: false);
      emit(pageController);
    });
  }
}
