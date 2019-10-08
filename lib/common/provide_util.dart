//Store 定义全局Context Stroe
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_ui/model/HomeTabBarModel.dart';
import 'package:flutter_ui/model/HomeVipCourse.dart';
import 'package:flutter_ui/model/HomeVipModel.dart';
import 'package:flutter_ui/model/planmodel.dart';
import 'package:flutter_ui/model/swiperstatus.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider, Consumer, Provider;
export 'package:provider/provider.dart';
export 'package:flutter_ui/common/provide_util.dart';

class Store {

  static BuildContext context;
  static BuildContext widgetContext;

  //  我们将会在main.dart中runAPP实例化init
  static init({context, child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_)=>PlanModel(),),//普通状态对象
        // 如果多对象则需要在此类全部定义
        ChangeNotifierProvider(builder: (_)=>SwiperModel(),),
        ChangeNotifierProvider(builder: (_)=>HomeVipModel(),),
        ChangeNotifierProvider(builder: (_)=>HomeTabModel(),),
        ChangeNotifierProvider(builder: (_)=>HomeVipCourseModel(),),
      ],
      child: child,
    );
  }
  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(context){
    return Provider.of(context);
  }
  // 通过Consumer(builder,child)获取状态数据 只更新调用该方法的widget
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }

}