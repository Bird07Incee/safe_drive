import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/scroll_product_detail/scroll_product_detail_bloc.dart';

void main() {
  group("product detail bloc", ()
  {
    setUp(() {

    });


    test(
      'initial state [ScrollProductDetailState]',
          () {
        expect(
          ScrollProductDetailBloc().state,
          ScrollProductDetailState(),
        );
      },
    );

    test(
      'ScrollProductDetailState copyWith method initial state',
          () {
        expect(
          ScrollProductDetailBloc().state,
          ScrollProductDetailBloc().state.copyWith(),
        );
      },
    );

    group("ProductDetailBloc ProductDetailScrollAction", () {
      blocTest<ScrollProductDetailBloc, ScrollProductDetailState>("ProductDetailScrollAction success case 1",
          build: () => ScrollProductDetailBloc(),
          act: (bloc) => bloc.add(ProductDetailScrollAction(0.0, 320.0, "1")),
          expect: () => <ScrollProductDetailState>[
            ScrollProductDetailState(appBarCarDetailStatus: false)
          ]);

      blocTest<ScrollProductDetailBloc, ScrollProductDetailState>("ProductDetailScrollAction success case 2",
          build: () => ScrollProductDetailBloc(),
          act: (bloc) => bloc.add(ProductDetailScrollAction(1000.0, 320.0, "0")),
          expect: () => <ScrollProductDetailState>[
            ScrollProductDetailState(appBarCarDetailStatus: true)
          ]);
    });
  });
}

