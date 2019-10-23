import 'package:flutter/cupertino.dart';
//动画路由
class RouteAnimted{
  //右划入,左画出
  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }

  //跳转路由(自带参数)
  static PageRouteTo(BuildContext context,Widget widget){
    Navigator.push<String>(
        context,
        new PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          // 跳转的路由对象
          return widget;
        }, transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
            ) {
          return createTransition(animation, child);
        })
    ).then((String str){

    });
  }

}