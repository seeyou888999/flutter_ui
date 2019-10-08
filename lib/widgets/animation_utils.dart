import 'package:flutter/material.dart';

//创建路由动画 需要的情况下直接调用该方法
class CustomAnimation extends PageRouteBuilder {
  final Widget widget;
  final int status;

  CustomAnimation(this.widget, {this.status = 0})
      : super(
            transitionDuration: const Duration(milliseconds: 500), //设置动画时长500毫秒
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              switch (status) {
                case 0:
                  return FadeTransition(//渐变过渡 0.0-1.0
                    opacity: Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation1, //动画样式
                          curve: Curves.fastOutSlowIn, //动画曲线
                        )),
                    child: child,
                  );
                  break;
                case 2:
                  return RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).
                    animate(
                      CurvedAnimation(
                        parent: animation1,
                        curve: Curves.fastOutSlowIn,
                      )
                    ));
                  break;
                  default: {
                    return SlideTransition(
                      position: Tween<Offset>(
                          begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                          parent: animation1, curve: Curves.fastOutSlowIn)),
                      child: child,
                    );
                  }
                  break;
              }
            });
}
