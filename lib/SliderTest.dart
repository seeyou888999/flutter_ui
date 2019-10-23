import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double value = 0.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text('Slider'),
      ),
      body: Center(
        child: Container(
          color: Colors.yellow,
          width: MediaQuery.of(context).size.width-5,
          height: 25,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: StudySliderThumbShape(), //滑块形状
              overlayShape: StudySliderOverlayShape(),//水泡形状
              trackShape: StudySliderTrackShape(), //进度条形状
              trackHeight: 5,
              overlayColor: Colors.black,
              thumbColor: Colors.transparent,
            ),
            child: Slider(
              label: '12312312312321',
              value: value,
              max: 100,
              activeColor: Colors.red,
              inactiveColor: Colors.black,
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
                print('value=$value');
              },
            ),
          ),
        ),
      ),
    );
  }
}

class StudySliderOverlayShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(100, 35);
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

class StudySliderThumbShape extends SliderComponentShape {
  final TextPainter _textPainter = TextPainter();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(100, 25);
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
    Paint paint = Paint();
    paint.color = sliderTheme.thumbColor;
    Rect rect = Rect.fromCenter(center: center, width: 100, height: 25);
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(25.0));
    context.canvas.drawRRect(rrect, paint);
    _textPainter.text =
        TextSpan(text: "${(value * 100).toInt()}/100", style: TextStyle(color: Colors
            .black));
    _textPainter.textDirection = textDirection;
    _textPainter.layout();
    _textPainter.paint(
      context.canvas,
      Offset(
        center.dx - _textPainter.width / 2,
        center.dy - _textPainter.height / 2,
      ),
    );
  }
}

class StudySliderTrackShape extends SliderTrackShape {
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
      trackRect.bottom,topLeft: Radius.circular(50),bottomLeft: Radius
            .circular(50),topRight: Radius.circular(50),bottomRight: Radius
            .circular(50));
    if (!leftTrackSegment.isEmpty)
      context.canvas.drawRRect(leftTrackSegment, leftTrackPaint);
    final RRect rightTrackSegment = RRect.fromLTRBAndCorners(
        thumbCenter.dx + thumbSize.width / 2 - trackRect.height,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,bottomRight: Radius.circular(50),topRight: Radius
        .circular(30),bottomLeft:Radius.circular(50),topLeft:  Radius.circular
      (50));
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