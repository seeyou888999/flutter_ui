import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/common/AudioPlayerManager.dart';
import 'package:flutter_ui/common/MyPainter.dart';
import 'package:flutter_ui/common/NoSplashFactory.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/common/provide_util.dart' show Store;
import 'package:flutter_ui/otherpage/floatingActionButton.dart';
import 'package:flutter_ui/page/FindPage.dart';
import 'package:flutter_ui/page/LisinterPage.dart';
import 'package:flutter_ui/page/meheardpage.dart';
import 'package:flutter_ui/page/minepage.dart';
import 'package:flutter_ui/page/UserCenter.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/AudioPlayModel.dart';
import 'model/HomeTabBarModel.dart';

void main()  {
  runApp(MainPage());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Store.init(
      context: context,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '我听',
        theme: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashFactory: const NoSplashFactory(),
        ),
        home: Builder(builder: (context){
          Store.context = context;
           return MainHome();
        })
      )
    );
  }
}

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}



class _MainHomeState extends State<MainHome> with
    TickerProviderStateMixin<MainHome>,AutomaticKeepAliveClientMixin{

  final pageController = PageController();
  var _currIndex = 0;
  static var _tabIcons = [
    Icon(Icons.home,size: 30,),
    Icon(Icons.find_in_page,size: 30,),
    Icon(Icons.calendar_today,size: 20,color: Colors.transparent,),
    Icon(Icons.shopping_cart,size: 30,),
    Icon(Icons.account_box,size: 30,)
  ];
  final bodyList = [
    SafeArea(top:true,child: MinePage()),
    SafeArea(top:true,child: MeHeardPage()),
//    SafeArea(top:true,child: GradientDemo()),
    SafeArea(top:true,child: FindPage()),
    SafeArea(top:true,child: UserCenter())
  ];



  void onTap(int index) {
//    pageController.jumpToPage(index);
    //点击下面tabbar的时候执行动画跳转方法
    pageController.animateToPage(index, duration: new Duration(milliseconds:
    700),curve:new ElasticOutCurve(4));
    index == 0 ? Store.value<HomeTabModel>(context,1).stopPaly(true):
    Store.value<HomeTabModel>(context,1).stopPaly(false);
  }

  void onPageChanged(int index) {
    setState(() {
      _currIndex = index;
    });
  }
  final items = [
    BottomNavigationBarItem(icon: _tabIcons[0],title:getText(0)),
    BottomNavigationBarItem(icon: _tabIcons[1],title:getText(1)),
    BottomNavigationBarItem(icon: _tabIcons[3],title:getText(2)),
    BottomNavigationBarItem(icon: _tabIcons[4],title:getText(3)),
  ];

  static List _bottomBarTitles = ['首页','我听','发现','账号'];

  static Widget getText(int index){
    return Text(_bottomBarTitles[index],style: TextStyle(fontSize: 12),);
  }

//  void test(int index){
//    subSize = 2;
//    double subPageTotal = (newTitle.length / subSize)
//        + ((newTitle.length % subSize > 0) ?1 : 0);
//    List<Widget> list = new List();
//    int fromIndex = index-1 * subSize;
//    int toIndex = ((index == subPageTotal-1) ? newTitle.length : ((index +1)
//        * subSize));
//    for (var i = 0, len = subPageTotal - 1; i <= len; i++) {
//      // 分页计算
//      int fromIndex = i * subSize;
//      int toIndex = ((i == len) ? newTitle.length : ((i + 1) * subSize));
//
//      print('$fromIndex==${toIndex-1}');
//    }
//  }
  @override
  Widget build(BuildContext context) {
    //初始化加载
    return Scaffold(
        key: ObjectKey("MinePage"),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: bodyList,
          physics: NeverScrollableScrollPhysics(), // 禁止滑动
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          iconSize: 36,
          fixedColor: Colors.brown,
          currentIndex: _currIndex,
          onTap: onTap,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Hero(
          tag: 'floatButton',
          child: FloationActionButton(),
        )
      );
  }

  @override
  void initState() {
      super.initState();
    }

  @override
  void dispose() {
    print("-------------");
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}





