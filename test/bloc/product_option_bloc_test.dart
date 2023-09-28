import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_options/product_options_bloc.dart';


void main() {
  group('ProductOptionBloc', () {
    // Test initial state
    blocTest<ProductOptionBloc, ProductOptionState>(
      'emits [ProductOptionState()] when nothing is added',
      build: () => ProductOptionBloc(),
      expect: () => <ProductOptionState>[],
    );


    blocTest<ProductOptionBloc, ProductOptionState>(
      'emits correct state after updateStepOneVariables',
      build: () => ProductOptionBloc(),
      act: (bloc) => bloc.updateStepOneVariables(
        groupValueRadio: 'SomeValue',
        price: 42,
        indexSelect: 1,
      ),
      expect: () => <ProductOptionState>[
        ProductOptionState(
          stepOneGroupValueRadio: 'SomeValue',
          stepOnePrice: 42,
          stepOneIndexSelect: 1,
        ),
      ],
    );

    blocTest<ProductOptionBloc, ProductOptionState>(
      'emits correct state after updateStepTwoVariables',
      build: () => ProductOptionBloc(),
      act: (bloc) => bloc.updateStepTwoVariables(
        groupValueRadio: 'SomeValue',
        price: 42,
        indexSelect: 1,
      ),
      expect: () => <ProductOptionState>[
        ProductOptionState(
          stepTwoGroupValueRadio: 'SomeValue',
          stepTwoPrice: 42,
          stepTwoIndexSelect: 1,
        ),
      ],
    );

    blocTest<ProductOptionBloc, ProductOptionState>(
      'emits correct state after updateStepTreeVariables',
      build: () => ProductOptionBloc(),
      act: (bloc) => bloc.updateStepTreeVariables(
        groupValueRadio: 'SomeValue',
        price: 42,
        indexSelect: 1,
      ),
      expect: () => <ProductOptionState>[
        ProductOptionState(
          stepTreeGroupValueRadio: 'SomeValue',
          stepTreePrice: 42,
          stepTreeIndexSelect: 1,
        ),
      ],
    );

    blocTest<ProductOptionBloc, ProductOptionState>(
      'emits correct state after updateStepFourVariables',
      build: () => ProductOptionBloc(),
      act: (bloc) => bloc.updateStepFourVariables(
        groupValueRadio: 'SomeValue',
        price: 42,
        indexSelect: 1,
      ),
      expect: () => <ProductOptionState>[
        ProductOptionState(
          stepFourGroupValueRadio: 'SomeValue',
          stepFourPrice: 42,
          stepFourIndexSelect: 1,
        ),
      ],
    );

    blocTest<ProductOptionBloc, ProductOptionState>(
      'emits correct state after updateStepFiveVariables',
      build: () => ProductOptionBloc(),
      act: (bloc) => bloc.updateStepFiveVariables(
        groupValueRadio: 'SomeValue',
        price: 42,
        indexSelect: 1,
      ),
      expect: () => <ProductOptionState>[
        ProductOptionState(
          stepFiveGroupValueRadio: 'SomeValue',
          stepFivePrice: 42,
          stepFiveIndexSelect: 1,
        ),
      ],
    );


    blocTest<ProductOptionBloc, ProductOptionState>(
      'emits correct state after updateLastOption',
      build: () => ProductOptionBloc(),
      act: (bloc) => bloc.updateLastOption(3),
      expect: () => <ProductOptionState>[
        ProductOptionState(lastOption: 3),
      ],
    );

    blocTest<ProductOptionBloc, ProductOptionState>(
      'emits correct state after updateSelectCurrentOption',
      build: () => ProductOptionBloc(),
      act: (bloc) => bloc.updateSelectCurrentOption(1),
      expect: () => <ProductOptionState>[
        ProductOptionState(selectCurrentOption: 1),
      ],
    );
  });
}