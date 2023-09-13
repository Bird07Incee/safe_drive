part of 'view_img_detail_page_switch_bloc.dart';

class ViewImgDetailPageSwitchEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SwitchPageAction extends ViewImgDetailPageSwitchEvent {
  final bool statePage;
  SwitchPageAction({required this.statePage});
}
