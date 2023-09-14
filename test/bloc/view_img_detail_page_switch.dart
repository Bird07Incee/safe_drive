import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';

void main() {
  group('ViewImgDetailPageSwitchBloc', () {
    late ViewImgDetailPageSwitchBloc bloc;

    setUp(() {
      bloc = ViewImgDetailPageSwitchBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state should be false', () {
      expect(bloc.state, false);
    });

    blocTest<ViewImgDetailPageSwitchBloc, bool>(
      'emits the updated state when handling SwitchPageAction',
      build: () => bloc,
      act: (bloc) {
        const statePage = true; // Change this value as needed
        bloc.add(SwitchPageAction(statePage: statePage));
      },
      expect: () => [true],
    );

    // You can write similar blocTest cases for other scenarios and actions.
  });
}
