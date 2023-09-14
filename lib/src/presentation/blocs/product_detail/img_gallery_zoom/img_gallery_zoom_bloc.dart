import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'img_gallery_zoom_event.dart';

class ImgGalleryZoomBloc extends Bloc<ImgGalleryZoomEvent, TransformationController> {
  ImgGalleryZoomBloc() : super(TransformationController()) {
    final transformationController = TransformationController();
    on<ZoomImageAction>((event, emit) {
      if (transformationController.value != Matrix4.identity()) {
        transformationController.value = Matrix4.identity();
        emit(transformationController);
      } else {
        transformationController.value = Matrix4.identity() * 2
          ..translate(-(event.details.localPosition.dx / 2), -(event.details.localPosition.dy / 1.9));
        emit(transformationController);
      }
    });
  }
}
