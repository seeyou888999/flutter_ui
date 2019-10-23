import 'package:flutter/material.dart';

class SliderOverlayShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(110, 35);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
        Animation<double> enableAnimation,
        bool isDiscrete,
        TextPainter labelPainter,
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value}) {
    Tween<double> widthTween = Tween<double>(
      begin: 100,
      end: 125,
    );
    Tween<double> heightTween = Tween<double>(
      begin: 25,
      end: 50,
    );

    Paint paint = Paint();
    paint.color = sliderTheme.overlayColor;

    Rect rect = Rect.fromCenter(
        center: center,
        width: widthTween.evaluate(activationAnimation),
        height: heightTween.evaluate(activationAnimation));
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(25.0));
    context.canvas.drawRRect(rrect, paint);
  }
}