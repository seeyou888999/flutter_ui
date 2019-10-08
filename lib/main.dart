import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/common/provide_util.dart' show Store;
import 'package:flutter_ui/otherpage/FlutterScroll.dart';
import 'package:flutter_ui/page/FindPage.dart';
import 'package:flutter_ui/page/meheardpage.dart';
import 'package:flutter_ui/page/minepage.dart';
import 'package:flutter_ui/page/UserCenter.dart';
void main()  {
  runApp(MainPage());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle
      (statusBarColor:Colors.red);
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
        title: '回马枪',
          theme: new ThemeData(
            brightness: Brightness.light,
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
    SingleTickerProviderStateMixin<MainHome>,AutomaticKeepAliveClientMixin{
  final pageController = PageController();
  var _currIndex = 0;
  static var _tabIcons = [
    Icon(Icons.home),
    Icon(Icons.find_in_page),
    Icon(Icons.calendar_today),
    Icon(Icons.shopping_cart),
    Icon(Icons.account_box)
  ];
  final bodyList = [
    SafeArea(top:true,child: MinePage()),
    SafeArea(top:true,child: MeHeardPage()),
    SafeArea(top:true,child: HomeSearch()),
    SafeArea(top:true,child: FindPage()),
    SafeArea(top:true,child: UserCenter())
  ];



  void onTap(int index) {
//    pageController.jumpToPage(index);
    //点击下面tabbar的时候执行动画跳转方法
    pageController.animateToPage(index, duration: new Duration(milliseconds:
    700),curve:new ElasticOutCurve(4));
  }

  void onPageChanged(int index) {
    setState(() {
      _currIndex = index;
    });
  }
  final items = [
    BottomNavigationBarItem(icon: _tabIcons[0],title:getText
      (0)),
    BottomNavigationBarItem(icon: _tabIcons[1],title:getText
      (1)),
    BottomNavigationBarItem(icon: _tabIcons[2],title:getText
      (2)),
    BottomNavigationBarItem(icon: _tabIcons[3],title:getText
      (3)),
    BottomNavigationBarItem(icon: _tabIcons[4],title:getText
      (4)),
  ];

  static List _bottomBarTitles = ['首页','我听','我听快讯','发现','账号'];

  static Widget getText(int index){
    return Text(_bottomBarTitles[index],style: TextStyle(fontSize: 12),);
  }


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
        bottomNavigationBar: CupertinoTabBar(
            inactiveColor: Colors.black,
            backgroundColor: Colors.white,
            items: items,
            currentIndex: _currIndex,
            onTap: onTap
        )
      );
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }
}



