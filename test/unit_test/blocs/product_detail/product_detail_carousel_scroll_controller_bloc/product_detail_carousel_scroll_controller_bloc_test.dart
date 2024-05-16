import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:autoStation_promptBuy/src/presentation/blocs/product_detail/product_detail_carousel_scroll_controller/product_detail_carousel_scroll_controller_bloc.dart';

void main() {
  group('ProductDetailCarouselScrollControllerBloc', () {
    late ProductDetailCarouselScrollControllerBloc bloc;

    setUp(() {
      bloc = ProductDetailCarouselScrollControllerBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test("ProductDetailCarouselScrollControllerEvent supports comparisons", (){
      expect(const ProductDetailCarouselScrollControllerEvent().props, const ProductDetailCarouselScrollControllerEvent().props);
    });

    test('initial state should be a PageController', () {
      expect(bloc.state, isA<PageController>());
    });

    blocTest<ProductDetailCarouselScrollControllerBloc, PageController>(
      'emits a new PageController on CarouselScrollAction',
      build: () => bloc,
      act: (bloc) {
        const index = 2; // Change this value as needed
        bloc.add(CarouselScrollAction(index: index));
      },
      expect: () => [isA<PageController>()],
    );
  });
}
