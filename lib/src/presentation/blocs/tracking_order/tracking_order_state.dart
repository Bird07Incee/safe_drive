part of 'tracking_order_bloc.dart';

enum GetTrackingOrderListStatus { initial, loading, success, empty, error }

class TrackingOrderState extends Equatable {
  const TrackingOrderState(
      {this.trackingOrderListStatus = GetTrackingOrderListStatus.initial,
      this.trackingListData = const <Order>[],
      this.trackingListPage = const TrackingListPage(totalCountItems: 1, currentPage: 1, totalPage: 1)});

  final GetTrackingOrderListStatus trackingOrderListStatus;
  final List<Order> trackingListData;
  final TrackingListPage trackingListPage;

  @override
  List<Object> get props => [trackingOrderListStatus, trackingListData, trackingListPage];

  TrackingOrderState copyWith(
      {GetTrackingOrderListStatus? trackingOrderListStatus, List<Order>? trackingListData, TrackingListPage? trackingListPage}) {
    return TrackingOrderState(
        trackingOrderListStatus: trackingOrderListStatus ?? this.trackingOrderListStatus,
        trackingListData: trackingListData ?? this.trackingListData,
        trackingListPage: trackingListPage ?? this.trackingListPage);
  }
}
