import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'view_img_detail_page_switch_event.dart';

class ViewImgDetailPageSwitchBloc extends Bloc<ViewImgDetailPageSwitchEvent, bool> {
  ViewImgDetailPageSwitchBloc() : super(false) {
    on<SwitchPageAction>((event, emit) {
      emit(event.statePage);
    });
  }
}
