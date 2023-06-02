import 'package:flutter/material.dart';

class CircleThumbShapeSlider extends SliderComponentShape {
  final double thumbRadius;

  const CircleThumbShapeSlider({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 25, height: 25),
        const Radius.circular(15),
      ),
      Paint()..color = const Color.fromARGB(255, 233, 26, 26),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 20, height: 20),
        const Radius.circular(12),
      ),
      Paint()..color = const Color.fromARGB(255, 255, 255, 255),
    );
  }
}
