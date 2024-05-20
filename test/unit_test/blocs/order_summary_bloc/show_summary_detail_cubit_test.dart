import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/order_summary/show_summary_detail_cubit.dart';

void main() {
  group('ShowSummaryDetailCubit', () {
    late ShowSummaryDetailCubit showSummaryDetailCubit;

    setUp(() {
      showSummaryDetailCubit = ShowSummaryDetailCubit();
    });

    tearDown(() {
      showSummaryDetailCubit.close();
    });

    test('initial state should false', () {
      expect(ShowSummaryDetailCubit().state, false);
    });

    blocTest<ShowSummaryDetailCubit, bool>(
      'emits toggle value to state',
      build: () => showSummaryDetailCubit,
      act: (bloc) {
        bloc.toggle();
      },
      expect: () {
        return [true];
      },
    );
  });
}
