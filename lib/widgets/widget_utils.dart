import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonUtils {

  /// 颜色创建方法
  /// - [colorString] 颜色值
  /// - [alpha] 透明度(默认1，0-1)
  ///
  /// 可以输入多种格式的颜色代码，如: 0x000000,0xff000000,#000000
  static Color ADColor(String colorString, {double alpha = 1.0}) {
    String colorStr = colorString;
    // colorString未带0xff前缀并且长度为6
    if (!colorStr.startsWith('0xff') && colorStr.length == 6) {
      colorStr = '0xff' + colorStr;
    }
    // colorString为8位，如0x000000
    if(colorStr.startsWith('0x') && colorStr.length == 8) {
      colorStr = colorStr.replaceRange(0, 2, '0xff');
    }
    // colorString为7位，如#000000
    if(colorStr.startsWith('#') && colorStr.length == 7) {
      colorStr = colorStr.replaceRange(0, 1, '0xff');
    }
    // 先分别获取色值的RGB通道
    Color color = Color(int.parse(colorStr));
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    // 通过fromRGBO返回带透明度和RGB值的颜色
    return Color.fromRGBO(red, green, blue, alpha);
  }
  //获取Text
  static Widget AdText(){

  }

  //获取Tab
  static Widget AdTabItems(String title, {bool showRowImage = false}) {
    return Tab(child: Center(child: Text(title)),);
  }
  //获取图标
  static Image AdTabImage(path,double w,double h,Color c,BoxFit f) {
    return  Image.asset(
        path, width: w, height: h,color: c,fit: f,
    );
  }
  //获取Container 带图片
  static Container AdContainer({String path,double h,double w,double
  l,double r,
    double t,
    double b,
    Color color,
    Widget widget,
    bool isShowImage}){
    print(isShowImage);
    if (isShowImage) {
      return  new Container(
        height: h,
        width: w,
        padding: EdgeInsets.only(left: l,top: t,right: r,bottom: b),
        child: ClipOval(
            child: AdTabImage(path,w,h,Colors.white,BoxFit.cover)
        ),
      );
    } else {
      return  new Container(
        padding: EdgeInsets.only(left: l,top: t,right: r,bottom: b),
        child: ClipOval(
            child: AdTabImage(path,w,h,Colors.white,BoxFit.cover)
        ),
      );
    }
  }

}