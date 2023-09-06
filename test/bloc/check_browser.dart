import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_html/html.dart';

class MockFlutterLineLiff extends Mock implements FlutterLineLiff {}
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('CheckBrowserBloc', () {
    late CheckBrowserBloc checkBrowserBloc;
    late MockFlutterLineLiff mockFlutterLineLiff;
    late MockBuildContext mockBuildContext;

    setUp(() {
      mockFlutterLineLiff = MockFlutterLineLiff();
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
      'emits [BrowserIsLineLiff] when GetBrowserClient is added and conditions are met',
      build: () {
        when(() => mockFlutterLineLiff.ready).thenAnswer((_) async {});
        when(() => window.navigator.userAgent).thenReturn('Line');
        return checkBrowserBloc;
      },
      act: (bloc) => bloc.add(GetBrowserClient(context: mockBuildContext)),
      expect: () => [BrowserIsLineLiff()],
    );

    blocTest<CheckBrowserBloc, CheckBrowserState>(
      'emits [BrowserIsNotLineLiff] when GetBrowserClient is added and conditions are not met',
      build: () {
        when(() => mockFlutterLineLiff.ready).thenAnswer((_) async {});
        when(() => window.navigator.userAgent).thenReturn('SomeOtherBrowser');
        return checkBrowserBloc;
      },
      act: (bloc) => bloc.add(GetBrowserClient(context: mockBuildContext)),
      expect: () => [BrowserIsNotLineLiff()],
    );
  });
}
