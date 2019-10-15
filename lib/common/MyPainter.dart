import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
class MyPainter extends CustomPainter{
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;

  MyPainter({this.lineColor, this.completeColor, this.completePercent, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width/2, size.height/2);  //  坐标中心
    double radius = math.min(size.width/2, size.height/2);  //  半径
    canvas.drawCircle(//  画圆方法
        center,
        radius,
        line
    );

    double arcAngle = 2*math.pi*(completePercent / 100);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi/2,  //  从正上方开始
        arcAngle,
        false,
        complete
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}