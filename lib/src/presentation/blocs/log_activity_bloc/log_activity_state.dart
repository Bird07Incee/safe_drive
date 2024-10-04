part of 'log_activity_bloc.dart';

abstract class LogActivityState extends Equatable {
  const LogActivityState();

  @override
  List<Object> get props => [];
}

class LogActivityInitial extends LogActivityState {}

class LogActivityLoading extends LogActivityState {}

class LogActivitySuccess<T> extends LogActivityState {
  final T? data;

  const LogActivitySuccess(this.data);

  @override
  List<Object> get props => [data ?? const []];
}

class LogActivityError extends LogActivityState {
  final String message;

  const LogActivityError(this.message);

  @override
  List<Object> get props => [message];
}
