import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:mocktail/mocktail.dart';
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('CheckBrowserBloc', () {
    late CheckBrowserBloc checkBrowserBloc;
    late MockBuildContext mockBuildContext;

    setUp(() {
      checkBrowserBloc = CheckBrowserBloc();
      mockBuildContext = MockBuildContext();
    });

    tearDown(() {
      checkBrowserBloc.close();
    });

    test('initial state is CheckBrowserInitial', () {
      expect(checkBrowserBloc.state, equals(CheckBrowserInitial()));
    });

    blocTest<CheckBrowserBloc, CheckBrowserState>(
      'emits [CheckBrowserLoading, BrowserIsNotLineLiff] when GetBrowserClient event is added',
      build: () => checkBrowserBloc,
      act: (bloc) => bloc.add(GetBrowserClient(context: mockBuildContext)),
      expect: () => [
        CheckBrowserLoading(),
        BrowserIsNotLineLiff(),
      ],
    );

    // Add more tests as needed
  });
}

