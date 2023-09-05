import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_status_event.dart';

part 'connectivity_status_state.dart';

class ConnectivityStatusBloc extends Bloc<ConnectivityStatusEvent, ConnectivityStatusState> {
  ConnectivityStatusBloc() : super(ConnectivityStatusInitial()) {
    on<ConnectivityStatusEvent>((event, emit) async {
      ConnectivityResult? connectionStatus;
      connectionStatus = event.connectivityResult;
      if (connectionStatus == ConnectivityResult.mobile) {
        emit(InternetMOBILE());
      } else if (connectionStatus == ConnectivityResult.wifi) {
        emit(InternetWIFI());
      } else {
        emit(NoInternet());
      }
    });
  }
}
