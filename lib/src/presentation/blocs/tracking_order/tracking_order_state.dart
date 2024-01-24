part of 'tracking_order_bloc.dart';

enum GetTrackingOrderListStatus { initial, loading, success, empty, error }

class TrackingOrderState extends Equatable {
  const TrackingOrderState({this.trackingOrderListStatus = GetTrackingOrderListStatus.initial, this.trackingListData = const <Order>[]});

  final GetTrackingOrderListStatus trackingOrderListStatus;
  final List<Order> trackingListData;

  @override
  List<Object> get props => [trackingOrderListStatus, trackingListData];

  TrackingOrderState copyWith({GetTrackingOrderListStatus? trackingOrderListStatus, List<Order>? trackingListData}) {
    return TrackingOrderState(
        trackingOrderListStatus: trackingOrderListStatus ?? this.trackingOrderListStatus,
        trackingListData: trackingListData ?? this.trackingListData);
  }
}
