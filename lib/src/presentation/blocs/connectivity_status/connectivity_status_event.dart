part of 'connectivity_status_bloc.dart';

class ConnectivityStatusEvent extends Equatable {
  const ConnectivityStatusEvent({required this.connectivityResult});
  final ConnectivityResult connectivityResult;
  @override
  List<Object> get props => [connectivityResult];
}
