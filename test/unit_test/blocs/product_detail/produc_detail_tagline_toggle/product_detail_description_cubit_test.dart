import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/produc_detail_tagline_toggle/product_detail_description_cubit.dart';

void main() {
  group('ProductDetailDescriptionCubit', () {
    late ProductDetailDescriptionCubit cubit;

    setUp(() {
      cubit = ProductDetailDescriptionCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, ProductDetailDescriptionCubitState());
    });

    blocTest<ProductDetailDescriptionCubit, ProductDetailDescriptionCubitState>(
      'emits [updated state] when updateToggleTapDescription is called',
      build: () => cubit,
      act: (cubit) => cubit.updateToggleTapDescription(
        toggleDescription: true,
        textNotMoreThan: true,
      ),
      expect: () => [
        ProductDetailDescriptionCubitState(
          toggleDescription: true,
          textNotMoreThan: true,
        ),
      ],
    );

    blocTest<ProductDetailDescriptionCubit, ProductDetailDescriptionCubitState>(
      'emits [same state] when updateToggleTapDescription is called with null parameters',
      build: () => cubit,
      act: (cubit) => cubit.updateToggleTapDescription(),
      expect: () => [cubit.state],
    );
  });
}
