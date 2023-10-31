import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/show_sale_code_cubit.dart';

void main() {
  group('ShowSaleCodeCubit', () {
    late ShowSaleCodeCubit showSaleCodeCubit;

    setUp(() {
      showSaleCodeCubit = ShowSaleCodeCubit();
    });

    tearDown(() {
      showSaleCodeCubit.close();
    });

    test('initial state should false', () {
      expect(ShowSaleCodeCubit().state, false);
    });

    blocTest<ShowSaleCodeCubit, bool>(
      'emits the value to state',
      build: () => showSaleCodeCubit,
      act: (bloc) {
        bloc.show(true);
      },
      expect: () {
        return [true];
      },
    );
  });
}
