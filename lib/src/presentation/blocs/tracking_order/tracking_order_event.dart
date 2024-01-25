part of 'tracking_order_bloc.dart';

class TrackingOrderEvent extends Equatable {
  const TrackingOrderEvent();

  @override
  List<Object> get props => [];
}

class GetTrackingOrderListFromJson extends TrackingOrderEvent {
  const GetTrackingOrderListFromJson();
}

class GetTrackingOrderListByPage extends TrackingOrderEvent {
  const GetTrackingOrderListByPage(this.page, this.context);

  final int page;
  final BuildContext context;
}
