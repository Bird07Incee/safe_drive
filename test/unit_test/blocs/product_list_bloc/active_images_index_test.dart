import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_list/active_images_index.dart';

void main() {
  group('ActiveImagesIndexCubit', () {
    late ActiveImagesIndexCubit activeImagesIndexCubit;

    setUp(() {
      activeImagesIndexCubit = ActiveImagesIndexCubit();
    });

    tearDown(() {
      activeImagesIndexCubit.close();
    });

    test('initial state should []', () {
      expect(ActiveImagesIndexCubit().state, []);
    });

    blocTest<ActiveImagesIndexCubit, List<int>>(
      'emits the an initial active index to state',
      build: () => activeImagesIndexCubit,
      act: (bloc) {
        bloc.initialItems([1,1]);
      },
      expect: () {
        return [[1,1]];
      },
    );

    blocTest<ActiveImagesIndexCubit, List<int>>(
      'emits the an actives index to List<index> state',
      build: () => activeImagesIndexCubit,
      seed: () {
        return [0,0];
      },
      act: (bloc) {
        bloc.update(0, 2);
      },
      expect: () {
        return [[2,0]];
      },
    );
  });
}
