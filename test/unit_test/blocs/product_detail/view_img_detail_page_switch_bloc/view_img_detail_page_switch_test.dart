import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:autoStation_promptBuy/src/presentation/blocs/product_detail/view_img_detail_page_switch/view_img_detail_page_switch_bloc.dart';

void main() {
  group('ViewImgDetailPageSwitchBloc', () {
    late ViewImgDetailPageSwitchBloc bloc;

    setUp(() {
      bloc = ViewImgDetailPageSwitchBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test("ViewImgDetailPageSwitchEvent supports comparisons", (){
      expect(ViewImgDetailPageSwitchEvent().props, ViewImgDetailPageSwitchEvent().props);
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
  });
}
