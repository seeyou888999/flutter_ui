import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/page/HomeVip.dart';
import 'package:flutter_ui/widgets/home_tabar_page.dart';

final routes = {
  '/':(context)=>HomeVip(),
  "/mass":(context)=>HomeTabrPage(),
  "/mass":(context,{arguments})=>HomeTabrPage(),
};

// ignore: top_level_function_literal_block
var onGenerateRoute =(RouteSettings settings){
  final String name =  settings.name; //方法名字
  final Function pageContentBuilder = routes[name];// 执行跳转的方法

  if(pageContentBuilder != null){
    if(settings.arguments!=null) { //参数不等于null
      final Route  route = MaterialPageRoute(builder: (BuildContext context) =>
          pageContentBuilder(context,arguments:settings.arguments));
      return route;
    }else {
      final Route route = MaterialPageRoute(builder: (BuildContext context) =>
          pageContentBuilder(context));
      return route;
    }
  }
};
