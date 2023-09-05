part of 'connectivity_status_bloc.dart';

abstract class ConnectivityStatusState extends Equatable {
  const ConnectivityStatusState();
  @override
  List<Object> get props => [];
}

class ConnectivityStatusInitial extends ConnectivityStatusState {}

class NoInternet extends ConnectivityStatusState {}

class InternetWIFI extends ConnectivityStatusState {}

class InternetMOBILE extends ConnectivityStatusState {}
