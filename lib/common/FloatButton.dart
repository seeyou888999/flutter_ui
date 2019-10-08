import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(
          child: RadialMenu(),
        ),
      ),
    );
  }
}

class RadialMenu extends StatefulWidget {
  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimetion(
      controller: controller,
    );
  }
}

class RadialAnimetion extends StatelessWidget {
  RadialAnimetion({Key key, this.controller})
      : scale = Tween<double>(
    begin: 1.0,  //float按钮起始位置
    end: 0.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    ),
  ),
        translation = Tween<double>(  //执行动画效果之前的距离
          begin: 0.0,
          end: 90.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.linear,
          ),
        ),
        rotation = Tween<double>( //执行动画之后的距离
          begin: -180.0,
          end: -20.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.8), // 到80%结束
          ),
        ),
        super(key: key);
  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;
  final Animation<double> rotation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder) {
        return Transform.rotate(
          angle: radians(rotation.value),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildButton(200, color: Colors.blueGrey, icon: Icons
                  .details),
              _buildButton(230,
                  color: Colors.purple, icon: Icons.do_not_disturb_on),
              _buildButton(260, color: Colors.lime, icon: Icons.drafts),
              _buildButton(290, color: Colors.lime, icon: Icons.drafts),
//              _buildButton(320,
//                  color: Colors.indigo, icon: Icons.error_outline),
              Container(
//                margin: EdgeInsets.only(right: 10,bottom: 40),
                child: Transform.scale(
                  scale: scale.value - 1,
                  child: FloatingActionButton(
                    heroTag: "solo",
                    mini: true,
                    child: Icon(Icons.close),
                    onPressed: _close,
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Transform.scale(
                scale: scale.value,
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: _open,
                  backgroundColor: Colors.orange,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildButton(double angle, {Color color, IconData icon}) {
    // 将[度]转换为弧度。
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          translation.value * cos(rad),
          translation.value * sin(rad),
        ),
      child: FloatingActionButton(
        mini: true,
        backgroundColor: color,
        child: Icon(icon,semanticLabel: '123',),
        onPressed: () {},
      ),
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}