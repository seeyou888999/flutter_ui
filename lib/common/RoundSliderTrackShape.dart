import 'package:flutter/material.dart';
import 'dart:math' as math;
class RoundSliderTrackShape extends SliderTrackShape {
  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        @required RenderBox parentBox,
        @required SliderThemeData sliderTheme,
        @required Animation<double> enableAnimation,
        @required TextDirection textDirection,
        @required Offset thumbCenter,
        bool isDiscrete = false,
        bool isEnabled = false,
      }) {
    assert(context != null);
    assert(offset != null);
    assert(parentBox != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(enableAnimation != null);
    assert(textDirection != null);
    assert(thumbCenter != null);
    // If the slider track height is less than or equal to 0, then it makes no
    // difference whether the track is painted or not, therefore the painting
    // can be a no-op.
    if (sliderTheme.trackHeight <= 0) {
      return;
    }

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation);
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation);
    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Rect trackRect = Rect.fromLTWH(
        offset.dx,
        offset.dy + parentBox.size.height / 2 - sliderTheme.trackHeight / 2,
        parentBox.size.width - sliderTheme.trackHeight / 2,
        sliderTheme.trackHeight);

    // The arc rects create a semi-circle with radius equal to track height.
    final Rect leftTrackArcRect = Rect.fromLTWH(
        trackRect.left, trackRect.top, trackRect.height, trackRect.height);
    if (!leftTrackArcRect.isEmpty)
      context.canvas.drawArc(
          leftTrackArcRect, math.pi / 2, math.pi, false, leftTrackPaint);
    final Rect rightTrackArcRect = Rect.fromLTWH(
        trackRect.right - trackRect.height / 2,
        trackRect.top,
        trackRect.height,
        trackRect.height);
    if (!rightTrackArcRect.isEmpty)
      context.canvas.drawArc(
          rightTrackArcRect, -math.pi / 2, math.pi, false, rightTrackPaint);
    final Size thumbSize =
    sliderTheme.thumbShape.getPreferredSize(isEnabled, isDiscrete);

    final RRect leftTrackSegment = RRect.fromLTRBAndCorners(trackRect.left +
        trackRect.height / 2,
        trackRect.top,
        thumbCenter.dx - thumbSize.width / 2 + trackRect.height,
        trackRect.bottom);
    if (!leftTrackSegment.isEmpty)
      context.canvas.drawRRect(leftTrackSegment, leftTrackPaint);
    final RRect rightTrackSegment = RRect.fromLTRBAndCorners(
        thumbCenter.dx + thumbSize.width / 2 - trackRect.height,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,);
    if (!rightTrackSegment.isEmpty)
      context.canvas.drawRRect(rightTrackSegment, rightTrackPaint);
  }

  @override
  Rect getPreferredRect(
      {RenderBox parentBox,
        Offset offset = Offset.zero,
        SliderThemeData sliderTheme,
        bool isEnabled,
        bool isDiscrete}) {
    double thumbWidth =
        sliderTheme.thumbShape.getPreferredSize(isEnabled, isDiscrete).width;
    return Rect.fromLTWH(
        offset.dx + (thumbWidth / 2),
        offset.dy + parentBox.size.height / 2 - sliderTheme.trackHeight / 2,
        parentBox.size.width - thumbWidth,
        sliderTheme.trackHeight);
  }
}
