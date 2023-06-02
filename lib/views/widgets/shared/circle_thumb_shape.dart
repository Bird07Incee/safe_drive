import 'package:flutter/material.dart';

class CircleThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;

  const CircleThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 30, height: 30),
        const Radius.circular(15),
      ),
      Paint()..color = const Color.fromARGB(255, 233, 26, 26),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 24, height: 24),
        const Radius.circular(12),
      ),
      Paint()..color = const Color.fromARGB(255, 255, 255, 255),
    );
  }
}
