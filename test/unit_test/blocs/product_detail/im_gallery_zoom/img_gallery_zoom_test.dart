import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:autoStation_promptBuy/src/extension/custom_tap_down_details.dart';
import 'package:autoStation_promptBuy/src/presentation/blocs/product_detail/img_gallery_zoom/img_gallery_zoom_bloc.dart';

void main() {
  group('ImgGalleryZoomBloc', () {
    late ImgGalleryZoomBloc imgGalleryZoomBloc;
    late ImgGalleryZoomBloc imgGalleryZoomBloc2;
    final transformationController = TransformationController();
    final transformationController2 = TransformationController(Matrix4(3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3));


    setUp(() {
      imgGalleryZoomBloc = ImgGalleryZoomBloc(transformationController: transformationController);
      imgGalleryZoomBloc2 = ImgGalleryZoomBloc(transformationController: transformationController2);
    });

    tearDown(() {
      imgGalleryZoomBloc.close();
    });

    test("ImgGalleryZoomEvent supports comparisons", (){
      expect(const ImgGalleryZoomEvent().props, const ImgGalleryZoomEvent().props);
    });

    test('initial state should TransformationController()', () {
      expect(imgGalleryZoomBloc.state, imgGalleryZoomBloc.state);
    });

    blocTest<ImgGalleryZoomBloc, TransformationController>(
      'emits the previous scale value on ZoomImageAction default state',
      build: () => imgGalleryZoomBloc2,
      act: (bloc) {
        bloc.add(ZoomImageAction(details: TapDownDetails()));
      },
      expect: () {
        transformationController.value = Matrix4.identity();
        return [transformationController2];
      },
    );

    blocTest<ImgGalleryZoomBloc, TransformationController>(
      'emits the previous scale value on ZoomImageAction initialed state',
      build: () => imgGalleryZoomBloc,
      act: (bloc) {
        bloc.add(ZoomImageAction(details: customTapDownDetails(const Offset(0, 0))));
      },
      expect: () {
        final detail = customTapDownDetails(const Offset(0, 0));
        transformationController.value = Matrix4.identity() * 2.0
          ..translate(-(detail.localPosition.dx / 2), -(detail.localPosition.dy / 1.9));
        return [transformationController];
      },
    );
  });
}
