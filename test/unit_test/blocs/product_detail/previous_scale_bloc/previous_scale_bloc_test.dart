import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/previous_scale/previous_scale_bloc.dart';

void main() {
  group('PreviousScaleBloc', () {
    late PreviousScaleBloc previousScaleBloc;

    setUp(() {
      previousScaleBloc = PreviousScaleBloc();
    });

    tearDown(() {
      previousScaleBloc.close();
    });

    test("PreviousScaleEvent supports comparisons", (){
      expect(const PreviousScaleEvent(previousScale: 1.0).props, const PreviousScaleEvent(previousScale: 1.0).props);
    });

    test('initial state should be 0.5', () {
      expect(previousScaleBloc.state, 0.5);
    });

    blocTest<PreviousScaleBloc, double>(
      'emits the previous scale value on PreviousScaleEvent',
      build: () => previousScaleBloc,
      act: (bloc) {
        const previousScale = 0.75; // Change this value as needed
        bloc.add(const PreviousScaleEvent(previousScale: previousScale));
      },
      expect: () => [0.75],
    );
  });
}
