part of 'img_gallery_zoom_bloc.dart';

abstract class ImgGalleryZoomState extends Equatable {
  const ImgGalleryZoomState();
  @override
  List<Object> get props => [];
}

class ImgGalleryZoomInitial extends ImgGalleryZoomState {}

class ImageZoomState extends ImgGalleryZoomState {
  final TransformationController transformationController;
  final bool isZoom;
  const ImageZoomState({required this.transformationController, required this.isZoom});
}
