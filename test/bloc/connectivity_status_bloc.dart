import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/connectivity_status/connectivity_status_bloc.dart';
import 'package:test/test.dart';


void main() {
  group('ConnectivityStatusBloc', () {
    late ConnectivityStatusBloc connectivityStatusBloc;

    setUp(() {
      connectivityStatusBloc = ConnectivityStatusBloc();
    });

    tearDown(() {
      connectivityStatusBloc.close();
    });

    test('initial state is ConnectivityStatusInitial', () {
      expect(connectivityStatusBloc.state, equals(ConnectivityStatusInitial()));
    });

    blocTest<ConnectivityStatusBloc, ConnectivityStatusState>(
      'emits InternetMOBILE state when ConnectivityResult.mobile is added',
      build: () => connectivityStatusBloc,
      act: (bloc) => bloc.add(const ConnectivityStatusEvent(connectivityResult: ConnectivityResult.mobile)),
      expect: () => [InternetMOBILE()],
    );

    blocTest<ConnectivityStatusBloc, ConnectivityStatusState>(
      'emits InternetWIFI state when ConnectivityResult.wifi is added',
      build: () => connectivityStatusBloc,
      act: (bloc) => bloc.add(const ConnectivityStatusEvent(connectivityResult: ConnectivityResult.wifi)),
      expect: () => [InternetWIFI()],
    );

    blocTest<ConnectivityStatusBloc, ConnectivityStatusState>(
      'emits NoInternet state when ConnectivityResult.none is added',
      build: () => connectivityStatusBloc,
      act: (bloc) => bloc.add(const ConnectivityStatusEvent(connectivityResult: ConnectivityResult.none)),
      expect: () => [NoInternet()],
    );
  });
}
