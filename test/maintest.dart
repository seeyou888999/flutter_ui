import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()=>runApp(mainDemo());
class mainDemo extends StatefulWidget {
  @override
  _mainDemoState createState() => _mainDemoState();
}

class _mainDemoState extends State<mainDemo> {
  TabController controller;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  final List<Tab> titleTabs = <Tab>[
    Tab(
      text: '今日实时榜',
    ),
    Tab(
      text: '昨日排行榜',
    ),
    Tab(
      text: '上周积分榜',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(26, 172, 255, 1),
          title: TabBar(
              isScrollable: true,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(style: BorderStyle.none)),
              tabs: titleTabs
          ),
        ),
      body: Container(
        color: Color.fromRGBO(26, 172, 255, 1),
        child: TabBarView(
          //TabBarView 默认支持手势滑动，若要禁止设置 NeverScrollableScrollPhysics
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Center(child:Text('view1')),
            Center(child:Text('view2')),
            Center(child:Text('view3')),
          ],
        ),
      ),
    ),
    );
  }
}
