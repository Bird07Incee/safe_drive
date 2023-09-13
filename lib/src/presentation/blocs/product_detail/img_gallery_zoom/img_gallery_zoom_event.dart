part of 'img_gallery_zoom_bloc.dart';

class ImgGalleryZoomEvent extends Equatable {
  const ImgGalleryZoomEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ZoomImageAction extends ImgGalleryZoomEvent {
  final TapDownDetails details;
  const ZoomImageAction({required this.details});
}
