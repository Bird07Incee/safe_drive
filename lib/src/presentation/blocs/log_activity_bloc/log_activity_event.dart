part of 'log_activity_bloc.dart';

abstract class LogActivityEvent extends Equatable {
  const LogActivityEvent();

  @override
  List<Object> get props => [];
}

class SendLogEvent extends LogActivityEvent {
  final Map<String, dynamic> payload;
  const SendLogEvent({required this.payload});

  @override
  List<Object> get props => [payload];
}
