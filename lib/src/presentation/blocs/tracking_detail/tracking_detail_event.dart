part of 'tracking_detail_bloc.dart';

class TrackingDetailEvent extends Equatable {
  const TrackingDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTracking extends TrackingDetailEvent {
  const GetTracking({this.orderNo = '', this.productId = ''});
  final String orderNo;
  final String productId;

  @override
  List<Object> get props => [orderNo, productId];
}
