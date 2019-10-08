import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/FlutterScroll.dart';
import 'package:flutter_ui/common/provide_util.dart' show Store;
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
  var _currIndex = 0;
  var _body; //定义body
  var _tabIcons = [
    Icon(Icons.home),
    Icon(Icons.find_in_page),
    Icon(Icons.calendar_today),
    Icon(Icons.shopping_cart),
    Icon(Icons.account_box)
  ];

  void initData(){
      _body = new IndexedStack(
          children: <Widget>[
              //放置安全区域
            SafeArea(top:true,child: MinePage()), //首页推荐模块  配置顶部导航和swiper
            SafeArea(top:true,child: MeHeardPage()), //加载我听模块
            SafeArea(top:true,child: NewsScreen()), //加载我听咨询模块
            SafeArea(top:true,child: FindPage()), //加载发现模块
            SafeArea(top:true,child: UserCenter()), //加载个人中心模块
          ],
        index: _currIndex,
      );
  }
  List _bottomBarTitles = ['首页','我听','我听快讯','发现','账号'];

  Widget getText(int index){
    return Text(_bottomBarTitles[index],style: TextStyle(fontSize: 12),);
  }
  @override
  Widget build(BuildContext context) {
    initData();
    //初始化加载
    return Scaffold(
        key: ObjectKey("MinePage"),
        body: _body,
        bottomNavigationBar: _bootmNavigationBar()
      );
  }

  Widget _bootmNavigationBar() {
   return  CupertinoTabBar(
      inactiveColor: Colors.black,
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
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
      ],
      currentIndex: _currIndex,
      onTap: (index){
        setState(() {
          _currIndex = index;
        });
      },
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
  Widget getShowBottomSheet(){
//       Scaffold.of(context).showBottomSheet(
//         //弹出底部层
//               (BuildContext context){
//                return  GestureDetector(
//                    child: Container(
//                      child: Text("我是底部弹出来的"),
//                      height: double.infinity,
//                      width: double.infinity,
//                    ),
//                    onPanUpdate: (DragUpdateDetails e) {
//                      //用户手指滑动时，更新偏移，重新构建
//                      setState(() {
////                                                      _left += e.delta.dx;
////                                                      _top += e.delta.dy;
//                      });
//                    }
//                );
//           },
//           shape: new BeveledRectangleBorder
//           //修改底部圆角
//             (borderRadius: BorderRadius.circular
//             (2.0),side: new BorderSide(
//             style: BorderStyle.none,)
//           ),
//       );
  }
}



