import 'package:flutter/material.dart';
import 'package:flutter_ui/common/FloatButton.dart';
import 'package:flutter_ui/page/MyFind_Dub.dart';
import 'package:flutter_ui/page/MyFind_Recommond.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
import 'dart:math' as math;
class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor:  CommonUtils.ADColor('#F1F2F2'),
        primaryColor: Colors.white
      ),
      home: MyFind(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class MyFind extends StatefulWidget {
  @override
  _MyFindState createState() => _MyFindState();
}

class _MyFindState extends State<MyFind> with AutomaticKeepAliveClientMixin,
    SingleTickerProviderStateMixin<MyFind>{
  TabController _tabController;

  List _titles = ['全民朗读','语言房','声音交友','趣味测验','活动','K歌房'];
  List _imgUrl = ['images/6.png','images/7.png','images/8.png','images/9.png','images/10.png','images/10.png'];

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 3, vsync: this,initialIndex: 1);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primaryTextTheme: TextTheme(
            body2: TextStyle(color: Colors.black),
            body1: TextStyle(color: Colors.black),
        ),
        primaryIconTheme: IconThemeData(
            color: Colors.black,
            size: 20
        ),
        indicatorColor: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          textTheme: TextTheme(
            title: TextStyle(color: Colors.black)
          )
        )
      ),
      home: Scaffold(
          appBar:PreferredSize(
            preferredSize: Size.fromHeight(25),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading:false,
              title:Text('发现'),
              centerTitle: true,
              leading: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Icon(Icons.person_add),
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Icon(Icons.search),
                )
              ]
            ),
          ),
          body: new NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool indexchange){
                return <Widget>[
                  loadTopTitle(),
                  loadTopBar()
                ];
              },
              body: loadTabView()
          ),
//        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//        floatingActionButton: RadialMenu(),
      ),
    );
  }

  Widget loadTopTitle(){
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _titles.length,
          childAspectRatio: 1.0
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index){
             return Container(
               padding: EdgeInsets.only(top: 5),
               color: Colors.white,
               child: loadBar(index),
             );
        },childCount: _titles.length
      ),
    );
  }

  Widget loadBar(int index){
    return Column(
      children: <Widget>[
        Container(
            width: 32,
            height: 32,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage(_imgUrl[index]),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  offset: new Offset(0.0, 1.0),
                  blurRadius: 1.0,
                  color: const Color(0xffaaaaaa),
                ),
              ],
            )
        ),
        SizedBox(height: 5),
        Container(
          child: Text(_titles[index],style: TextStyle(fontSize: 10),
            overflow:
            TextOverflow.ellipsis,),
        )
      ],
    );
  }

  Widget loadTopBar(){
    return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverAppBarDelegate(
        maxHeight: 35,
        minHeight: 35,
        child: Container(
          color: Colors.white,
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            unselectedLabelColor:CommonUtils.ADColor('#ADADAD'),
            unselectedLabelStyle: (TextStyle(fontSize: 12)),
            labelStyle: TextStyle(fontSize: 16,color:Colors.red,fontWeight:
            FontWeight.w100),
            tabs: <Widget>[
              Tab(text: '关注',),
              Tab(text: '推荐',),
              Tab(text: '趣配音',),
            ],
            onTap: (int index){
            },
        ),
        )
      )
    );
  }

  Widget loadTabView(){
    return  Container(
      color: CommonUtils.ADColor("#F1F2F2"),
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          MyFindRecommond(),
          MyFindRecommond(),
          MyFindDub()
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
