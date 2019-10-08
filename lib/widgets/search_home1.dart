import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/model/HomeTabBarModel.dart';
import 'package:flutter_ui/model/planmodel.dart';
import 'package:flutter_ui/page/HotSearch.dart';
import 'package:flutter_ui/page/OtherSearch.dart';
import 'package:flutter_ui/page/SearchMain.dart';
import 'package:flutter_ui/widgets/SearchClick_Button.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
//底部弹出层 回调函数
class Search extends StatefulWidget {
  final String title;
  Search(this.title);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin,
    AutomaticKeepAliveClientMixin{
  TabController _controller;
  List _tabTitle= ['推荐','热搜','有声书','相声评书','儿童','历史','音乐','人文','商业财经','其他'];
  ScrollController _scrollViewController;
  @override
  void initState() {
    // TODO: implement initState
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
    ScrollController _scrollViewController = new ScrollController
      (initialScrollOffset: 0.0);
    _controller = TabController(length: _tabTitle.length, vsync: this,
        initialIndex: 0);
    //判断防止重复加载Tabview
//    _controller.addListener(() {
//      if (this._controller.index.toDouble() == this._controller.animation.value) {
//        if (this.mounted) {
//          //print(this._tabController.index);
////          print(this._controller.index);
//        }
//      }
//      setState(() {});
//    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    if( _scrollViewController !=null) {
      _scrollViewController.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      Store.init(
        context: context,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(primaryColor: Colors.white),
          home:Builder(builder: (BuildContext context){
            Store.context = context;
            return _SeachHome();
          })
        )
    );
  }

  Widget _SeachHome(){
    return Scaffold(
        appBar:
        PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading:false,
              actions: <Widget>[
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(top: 15,right: 20),
                    child: Text('取消',style: TextStyle(fontSize: 12,color: Colors.black),),
                  ),
                  onTap: (){
                    Store.value<HomeTabModel>(context).stopPaly(true);
                    Navigator.of(context).pop();
                  },
                )
              ],
              flexibleSpace:SafeArea(
                bottom: true,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 10,right:70,top: 10),
                      child: buildTextField(),
                    ),
                  ],
                )
              )
          )
        ),
      body: getBody(),
    );
  }
  //使用indexStack进行保持Tabr 状态活性 并加载Tabview
  Widget  getBody(){
        return NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder: (BuildContext context,
            bool innerBoxIsScrolled){
                return <Widget>[
                  SliverAppBar(
                      floating: false,
                      pinned: true,
                      elevation: 0.0,
                      expandedHeight: 100,
                      forceElevated: false,
                  ),
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                            controller: this._controller,
                            tabs: getTab(_tabTitle),
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: CommonUtils.ADColor("#FF7A3F"),
                            isScrollable: true,
                            unselectedLabelColor: Colors.black,
                            labelColor: CommonUtils.ADColor("#FF7A3F"),
                            labelStyle: TextStyle(fontSize: 14),
                            onTap: (int index){

                            }
                        ),
                      )
                  )
                ];
            },
          body: getNestedViewBody()
        );
  }

  Widget getNestedViewBody(){
      return Container(
        color: Colors.white,
        child: TabBarView(
          physics: BouncingScrollPhysics(),
          controller: this._controller,
          children: <Widget>[
            SearchMain(),//首页
            HotSearch(),//vip
            OtherSearch(),//小说
            OtherSearch(),//直播
            OtherSearch(),//粤语
            OtherSearch(),//畅销书
            OtherSearch(),//精品
            OtherSearch(),//广播
            OtherSearch(),//历史
            OtherSearch()//商业财经
          ],
        ),
      );
  }

  List<Widget> getTab(List list){
    List<Widget> listTab = new List();
    if (list.length > 0) {
      for (int i =0; i<list.length; i++){
        listTab.add(
          Tab(
            child: Text(list[i],textAlign: TextAlign.center,style: TextStyle
              (fontSize: 12),),
          )
        );
      }
    }
    return listTab;
  }

  Widget buildTextField() {
    return Theme( //加入主题色 更改边框颜色
      data: new ThemeData(primaryColor: Colors.white),
      child: TextField(
          style: TextStyle(fontSize: 13),
          keyboardType: TextInputType.text,
          autofocus: true,
          cursorColor: CommonUtils.ADColor("#FF7A3F"),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              filled: true,
              hintText: '${widget.title}',
              suffixIcon: new SearchClickIcon(
                  wid: Icon(Icons.mic,color: CommonUtils.ADColor("#FF7A3F"),),
                  onClick: (){
                    print('点我干掉。。。');
                  }
              ),
              prefixIcon: Icon(Icons.search,color: CommonUtils.ADColor("#D5D5D5"))
          )
      ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate{

  final TabBar _tabar;

  _SliverAppBarDelegate(this._tabar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Material(
        color: Colors.white,
        child: _tabar,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => this._tabar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => this._tabar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }

}




