import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoStation_promptBuy/src/presentation/blocs/check_browser/check_browser_bloc.dart';

void main() {
  group('CheckBrowserBloc', () {
    late CheckBrowserBloc checkBrowserBloc;

    setUp(() {
      checkBrowserBloc = CheckBrowserBloc();
    });

    tearDown(() {
      checkBrowserBloc.close();
    });

    test("GetBrowserClient supports comparisons", (){
      expect(GetBrowserClient().props, GetBrowserClient().props);
    });

    test('initial state is CheckBrowserInitial', () {
      expect(checkBrowserBloc.state, equals(CheckBrowserInitial()));
    });

    blocTest<CheckBrowserBloc, CheckBrowserState>(
      'emits [CheckBrowserLoading, BrowserIsNotLineLiff] when GetBrowserClient event is added',
      build: () => checkBrowserBloc,
      act: (bloc) => bloc.add(GetBrowserClient()),
      expect: () => [
        CheckBrowserLoading(),
        BrowserIsNotLineLiff(),
      ],
    );

    // Add more tests as needed
  });
}

