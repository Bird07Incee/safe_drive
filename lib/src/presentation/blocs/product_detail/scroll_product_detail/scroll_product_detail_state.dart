part of 'scroll_product_detail_bloc.dart';

class ScrollProductDetailState {
  const ScrollProductDetailState({this.appBarCarDetailStatus = false});
  final bool appBarCarDetailStatus;

  ScrollProductDetailState copyWith({bool? appBarCarDetailStatus}) {
    return ScrollProductDetailState(appBarCarDetailStatus: appBarCarDetailStatus ?? this.appBarCarDetailStatus);
  }
}
