import 'package:flutter/material.dart';
class CustomShape extends SliderComponentShape {

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // TODO: implement getPreferredSize
    return Size(10, 10);
  }

  @override
  void paint(PaintingContext context, Offset center, {Animation<double> activationAnimation, Animation<double> enableAnimation, bool isDiscrete, TextPainter labelPainter, RenderBox parentBox, SliderThemeData sliderTheme, TextDirection textDirection, double value}) {
    // TODO: implement paint
    var rect = Rect.fromCenter(center: center,width: 90,height: 18);
    //设置圆角
    var rrect = RRect.fromRectAndRadius(rect, Radius.circular(16));
    context.canvas.drawRRect(rrect, Paint());
    //计算字体居中
    var offSet = Offset(center.dx - (labelPainter.width /2),center.dy - (labelPainter.height/2));
    //写入
    labelPainter.paint(context.canvas, offSet);
  }

}