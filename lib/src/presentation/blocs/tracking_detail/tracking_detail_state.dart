part of 'tracking_detail_bloc.dart';

enum TrackingDetailStatus { initial, loading, success, error }

extension TrackingDetailStatusX on TrackingDetailStatus {
  bool get isInitial => this == TrackingDetailStatus.initial;
  bool get isLoading => this == TrackingDetailStatus.loading;
  bool get isSuccess => this == TrackingDetailStatus.success;
  bool get isError => this == TrackingDetailStatus.error;
}

class TrackingDetailState extends Equatable {
  const TrackingDetailState({this.status = TrackingDetailStatus.initial, this.tracking = TrackingModel.empty});
  final TrackingDetailStatus status;
  final TrackingModel tracking;

  @override
  List<Object> get props => [status, tracking];

  TrackingDetailState copyWith({TrackingDetailStatus? status, TrackingModel? tracking}) {
    return TrackingDetailState(status: status ?? this.status, tracking: tracking ?? this.tracking);
  }
}
