import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'img_gallery_zoom_event.dart';

class ImgGalleryZoomBloc extends Bloc<ImgGalleryZoomEvent, TransformationController> {
  final TransformationController? transformationController;
  ImgGalleryZoomBloc({this.transformationController}) : super(TransformationController()) {
    final ctrl = transformationController ?? TransformationController();
    on<ZoomImageAction>((event, emit) {
      if (ctrl.value != Matrix4.identity()) {
        ctrl.value = Matrix4.identity();
        emit(ctrl);
      } else {
        ctrl.value = Matrix4.identity() * 2.0
          ..translate(-(event.details.localPosition.dx / 2), -(event.details.localPosition.dy / 1.9));
        emit(ctrl);
      }
    });
  }
}
