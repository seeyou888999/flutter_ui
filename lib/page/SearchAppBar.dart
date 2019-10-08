import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/page/OtherSearch.dart';
import 'package:flutter_ui/widgets/SearchClick_Button.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class SearchAppBar extends StatefulWidget {
  final augments;

  SearchAppBar({this.augments});

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> with
    AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin{
  ScrollController _controller;
  TabController _tabController;
  int type;
  List searchlist =['精选','专辑','声音','广播','用户','新闻','旋律古风','甜美岁月','忘我者'];
  List<List<Map>> data =[
    [
      {"id":'123','title':'重合排序'},
      {"id":'123','title':'最新更新'},
      {"id":'123','title':'播放最多'},
    ],
    [
      {"id":'123','title':'全部'},
      {"id":'123','title':'相声评书'},
      {"id":'123','title':'有声书'},
      {"id":'123','title':'情感生活'},
      {"id":'123','title':'其他'},
      {"id":'123','title':'历史'},
      {"id":'123','title':'人文'},
      {"id":'123','title':'天气'},
      {"id":'123','title':'模仿者'},
    ],
    [
      {"id":'123','title':'不限'},
      {"id":'123','title':'付费'},
      {"id":'123','title':'免费'},
    ],
  ];
  GlobalKey _appMenuKey = new GlobalKey();

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
    _tabController = TabController(length: searchlist.length, vsync: this,
        initialIndex: 0)..addListener((){
      if (_tabController.index.toDouble() == _tabController.animation.value) {
        if (this.mounted) {
            print("123123");
        }
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    if( _controller !=null) {
      _controller.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return   MaterialApp(
              debugShowCheckedModeBanner: false,
                    theme: new ThemeData(primaryColor: Colors.white),
                home:Builder(builder: (BuildContext context){
                return _SeachHome();
          })
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
        controller: this._controller,
        headerSliverBuilder: (BuildContext context,
            bool innerBoxIsScrolled){
          return <Widget>[
            SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                      key: _appMenuKey,
                      controller: this._tabController,
                      tabs: getTab(searchlist),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: CommonUtils.ADColor("#FF7A3F"),
                      isScrollable: true,
                      unselectedLabelColor: Colors.black,
                      labelColor: CommonUtils.ADColor("#FF7A3F"),
                      labelStyle: TextStyle(fontSize: 14),
                      onTap: (int index){
                      }
                  )
                ,context,_appMenuKey,data)
            )
          ];
        },
        body: getNestedViewBody()
    );
  }

  Widget getNestedViewBody(){
    return Container(
      color: CommonUtils.ADColor("#F1F2F2"),
      child: TabBarView(
        physics: BouncingScrollPhysics(),
        controller: this._tabController,
        children: <Widget>[
          OtherSearch(anguments: widget.augments),//首页
          OtherSearch(anguments: widget.augments),//vip
          OtherSearch(anguments: widget.augments),//小说
          OtherSearch(anguments: widget.augments),//直播
          OtherSearch(anguments: widget.augments),//粤语
          OtherSearch(anguments: widget.augments),//粤语
          OtherSearch(anguments: widget.augments),//粤语
          OtherSearch(anguments: widget.augments),//粤语
          OtherSearch(anguments: widget.augments),//粤语
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
              hintText: '${widget.augments['title']}',
              enabledBorder: UnderlineInputBorder(  //设置boder边框色
                borderSide: BorderSide(color: CommonUtils.ADColor("#F1F2F2")),
                borderRadius: BorderRadius.circular(25.7),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              suffixIcon: new SearchClickIcon(
                  wid: Icon(Icons.clear,color: CommonUtils.ADColor("#BCBCBC")
                      ,size: 20,),
                  onClick: (){
                    Navigator.of(context).pop();
                  }
              ),
              prefixIcon: Icon(Icons.search,color: CommonUtils.ADColor("#BCBCBC"))
          )
      ),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
//Tab 加入悬浮菜单
class _SliverAppBarDelegate  extends SliverPersistentHeaderDelegate {
  final TabBar _tabar;
  final BuildContext _buildContext;
  final GlobalKey _appMenuKey;
  final List<List<Map>> _data;
  _SliverAppBarDelegate(this._tabar,this._buildContext,this._appMenuKey,this._data);

  bool _isMenuShow = false;
  //找到当前Tabar的高度  GlobalKey
  OverlayEntry _overlayEntry;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Material(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: _tabar,
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(Icons.view_headline,size: 25,color: CommonUtils
                    .ADColor('#ADADAD'),),
              ),
              onTap: (){
                _isMenuShow = !_isMenuShow;
                _showBaiduOverlayMenu(_isMenuShow);
              },
            ),
          )
        ],
      ),
    );
  }
  _showBaiduOverlayMenu(isMenuShow) {
    if (isMenuShow) {
      this._overlayEntry = this._createOverlayEntry(_buildContext);
      Overlay.of(_buildContext).insert(this._overlayEntry);
    } else {
      this._overlayEntry.remove();
    }
  }

  OverlayEntry _createOverlayEntry (BuildContext context){
    //加载悬浮菜单
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    renderBox = _appMenuKey.currentContext.findRenderObject();
    var menusize = renderBox.size; //高度
    var menupositon = renderBox.localToGlobal(Offset.zero); //计算位置

    return OverlayEntry(builder: (context) =>
        new Positioned(
          top: menupositon.dy + menusize.height, //定位
          width: size.width,//整个屏幕尺寸
          child:new Material(
            color: Colors.white,
            child: Container(
              height: 100,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: loadBuiderListView(_data)
              ),
            ),
          )
        )
    );
  }

  List<Widget> loadBuiderListView(List<List<Map>> data){
    List <Widget> list = new List();
    for(int i=0;i < data.length; i++){
      list.add(
          Expanded(
              child:Container(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                    itemCount: 1,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context,int index){
                      return Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: buidListTitle(data[i]),
                        ),
                      );
                    }),
              )
          )
      );
    }
    return list;
  }

  List<Widget> buidListTitle(List<Map> list){
      List<Widget> widgetlist = new List();
      for(int i=0; i< list.length; i++){
          widgetlist.add(
            Container(
              height: 20,
             margin: EdgeInsets.only(right: 10,top: i==0?0:5),
             child: i==0?Chip(
               label: Text('${list[i]["title"]}',style: TextStyle(fontSize: 12),),
               padding: EdgeInsets.only(bottom: 12),
               labelStyle: TextStyle(fontSize: 10,color: Colors.deepOrange)
             ):Text('${list[i]["title"]}',style: TextStyle(fontSize: 10,
                 color: Colors.black),)
            )
          );
      }
      return widgetlist;
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

