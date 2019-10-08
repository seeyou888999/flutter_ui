import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'package:flutter/widgets.dart';

/*
 * 利用overlay实现Toast
 * 基本功能实现ok
 * 待实现防重复
 *
 */

class LoadingView {
  static var overlayState;
  static OverlayEntry overlayEntry;

  static void show({
    @required BuildContext context,        //组件上下文
    String message,                        //信息文字
    Color backgroundColor=Colors.redAccent,//信息底色
    Color textColor=Colors.white,          //文字颜色
  }) {

    //
    overlayState = Overlay.of(context);
    var winSize = MediaQuery.of(context).size;//获取屏幕尺寸
    var cwidth= winSize.width * 0.15;
    var owidth= 30.0;
    var _controller = AnimationController(vsync: overlayState, duration: Duration(milliseconds: 1400))..repeat();

    //创建一个OverlayEntry对象
    overlayEntry  = new OverlayEntry(builder: (context) {


      /**
       * loding图标， 容器宽度，画图，容器padding相互配合才能居中
       * 因为是以画图时的起点为中心  屏幕或者容器左上角起点
       *
       */
      //AbsorbPointer  IgnorePointer
      return  IgnorePointer(
          ignoring: false,
          child:Container(
            child: Material(
              //使屏幕样式独立，独立背景色
                color: Colors.black.withOpacity(0.0),
                child: Center(
                    child: Container(
                      height: cwidth + owidth,
                      width:  cwidth + owidth,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.9),
                        borderRadius: BorderRadius.all( Radius.circular(5) ),
                      ),
                      child: Container(
                        height: cwidth ,
                        width:  cwidth , //容器必须跟 画布尺寸一样，且padding 不能加,否则不居中
                        child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              //CustomPaint 画笔
                              return CustomPaint(
                                  painter: LoadingIcon(cwidth , _controller)
                              );
                            }),
                        margin:  EdgeInsets.all(owidth/2),  // margin 必须为外部容器额外宽度 owidth的一半,否则不居中
                      ),
                    )
                )
            ),
          )
      );

    });

    //往Overlay中插入插入OverlayEntry
    overlayState.insert(overlayEntry);

    //8秒后计算超时自动移除
    Future.delayed(Duration(seconds: 8)).then((value) {
      //移除
      if(overlayEntry!=null){
        overlayEntry.remove();
      }
    });

  }

  static void hide(){
    //手动移除
    if(overlayEntry!=null){
      overlayEntry.remove();
    }
    overlayEntry=null;
  }

}



class LoadingIcon extends CustomPainter {
  AnimationController _controller;

  Paint mHelpPaint;
  double swidth=0.0;
  double _arcStart=0.0;
  double _arcSweep=0.0;

  //构造函数
  LoadingIcon(this.swidth , this._controller ) {
    mHelpPaint = new Paint();
    mHelpPaint.style=PaintingStyle.stroke;
    mHelpPaint.color=Color(0xffBBC3C5);
    mHelpPaint.isAntiAlias=true;

    _arcStart=Tween(begin: Math.pi * 1.5, end: Math.pi * 1.5 + Math.pi * 2)
        .chain(CurveTween(curve: Interval(0.5, 1.0)))
        .evaluate(_controller);

    // _arcSweep=Math.sin(Tween(begin: 0.0, end: Math.pi).evaluate(_controller)) * Math.pi;
    _arcSweep=Math.sin(_controller.value * Math.pi) * Math.pi;


  }


  @override
  void paint(Canvas canvas, Size size) {
    double side =swidth;
    mHelpPaint
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;
    // 外圈
    canvas.drawArc( Offset.zero & Size(side, side), _arcStart, _arcSweep, false, mHelpPaint);
    //
    canvas.drawLine( Offset(side/2 -10, side/2-10), Offset(side/2 - 10, side/2+10), mHelpPaint);
    canvas.drawLine( Offset(side/2 +10, side/2-10), Offset(side/2 + 10, side/2+10), mHelpPaint);

  }

  @override
  bool shouldRepaint(LoadingIcon other) {

    return _arcStart != other._arcStart || _arcSweep != other._arcSweep;
    // return true;
  }

}

