part of 'tracking_order_bloc.dart';

class TrackingOrderEvent extends Equatable {
  const TrackingOrderEvent();

  @override
  List<Object> get props => [];
}

class GetTrackingOrderListFromJson extends TrackingOrderEvent {
  const GetTrackingOrderListFromJson();
}
