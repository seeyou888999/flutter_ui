import 'package:flutter/material.dart';
class CustomShape extends SliderComponentShape {

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // TODO: implement getPreferredSize
    return Size(95, 35);
  }

  @override
  void paint(PaintingContext context, Offset center, {Animation<double> activationAnimation, Animation<double> enableAnimation, bool isDiscrete, TextPainter labelPainter, RenderBox parentBox, SliderThemeData sliderTheme, TextDirection textDirection, double value}) {
    // TODO: implement paint
    Paint paint = Paint();
    paint.color = Colors.grey;
    var rect = Rect.fromCenter(center: center,width: 100,height: 18);
    //设置圆角
    var rrect = RRect.fromRectAndRadius(rect, Radius.circular(16));
    context.canvas.drawRRect(rrect, paint);
    double dx = center.dx - (labelPainter.width /2);
    double dy = center.dy - (labelPainter.height/2);

    //计算字体居中
    var offSet = Offset(dx,dy);
    //写入
    labelPainter.paint(context.canvas, offSet);
  }

}