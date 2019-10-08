import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeVipPainter extends CustomPainter{

  Paint _paint = Paint()
    ..color = Colors.amber //画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..strokeWidth = 15.0 //画笔的宽度
    ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3.0) //模糊遮罩效果
    ..filterQuality = FilterQuality.high//颜色渲染模式的质量
    ..strokeWidth = 5.0; //画笔的宽度

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }

}