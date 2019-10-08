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
import 'package:shared_preferences/shared_preferences.dart';
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
  List<String> keywordlist;
  SharedPreferences sharedPreferences;

  Future<List<String>> getKeyWord() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("keyword");
  }
  removeKeWord() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("keyword");
  }
  @override
  void initState(){
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
     _scrollViewController = new ScrollController
      (initialScrollOffset: 0.0);

    _controller = TabController(length: _tabTitle.length, vsync: this,
        initialIndex: 0);
    getKeyWord().then((List<String> list){
      persist(list);
    });
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      keywordlist = sharedPreferences.getStringList("keyword");
      // will be null if never previously saved
      persist(keywordlist); // set an initial value
      setState(() {});
    });
    //判断防止重复加载Tabview
    super.initState();
  }

  void persist(List<String> value) {
      setState(() {
        keywordlist = value;
      });
      sharedPreferences?.setStringList("keyword", value);
  }

  bool CompierTo(List<String> listTo){
    getKeyWord().then((List<String>list){
        if(list.length > listTo.length){
          return true;
        } else {
          return false;
        }
    });
  }

  void setStateKeyWord(){
    getKeyWord().then((List<String>list){
      setState(() {
        keywordlist = list;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    if( _scrollViewController !=null) {
      _scrollViewController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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
      body: new Builder(builder: (BuildContext context){
        return getBody();
      }),
    );
  }
  //使用indexStack进行保持Tabr 状态活性 并加载Tabview
  Widget  getBody(){
    return Store.connect<PlanModel>(builder: (context,plan,child){
      List<String> listView = Store.value<PlanModel>(context).lists;
      if(listView.length > 0){
        return  NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled){
                return loadSarchHistory(listView);
            },
            body: getNestedViewBody()
        );
      } else{
        return  NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled){
              return loadSearchMust();
            },
            body: getNestedViewBody()
        );
      }
    });
  }
  //判断是否存在搜索历史 返回 搜索历史页面
  List<Widget> loadSarchHistory(List<String> list){
    List<Widget> historylist = new List();
    historylist.add(showSliverAppBar(list));
    return historylist;
  }

  List<Widget> loadSearchMust(){
    List<Widget> historylist = new List();
    historylist.add(
          SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                  getTabBar()
              )
          )
      );
    return historylist;
  }
  //加载滚动头部
  Widget showSliverAppBar(List<String> list){
    // 状态栏高度
    double _statusBarHeight = MediaQuery.of(context).padding.top;
    //MediaQuery.of(context)这个里面还有其他信息，你们自行发掘吧
    // appbar 高度
    double _kLeadingWidth = kToolbarHeight + _statusBarHeight;
    _kLeadingWidth = (list.length/6)<=1?_kLeadingWidth+38:(_kLeadingWidth*2)+40;
    double _maxHeight = _kLeadingWidth;
    return  SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0.0,
      expandedHeight: _maxHeight,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('搜索历史',style: TextStyle(fontSize: 12),),
                      )
                  ),
                  Expanded(
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(top: 5,left: 10,right: 10),
                          child: Icon(Icons.delete_forever,size: 18,color:
                          CommonUtils.ADColor('#BCBCBC'),),
                        ),
                        onTap: (){
                          Store.value<PlanModel>(context).clearList();//重置数据
                        },
                      )
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child:Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child:  Wrap(
                        spacing: 10.0,
                        runSpacing: 5.0,
                        children: loadLabel(list)
                    ),
                  )
              )
            ],
          ),
        ),),
      bottom:  getTabBar(),
    );
  }
  //TabBar 头部
  Widget getTabBar(){
    return TabBar(
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
    );
  }


  List<Widget> loadLabel(List<String> list){
     List<Widget> labelList = new List();
     if (list!=null && list.length>0){
       Iterable<Widget> listTitles =list.map((keyword){
          return Container(
            height: 20,
            child: Chip(
              label: Text(keyword),
              padding: EdgeInsets.only(bottom: 10),
              labelStyle: TextStyle(fontSize: 10,color: Colors.black),
              deleteIcon: Icon(Icons.close,size:10,color: Colors.black,),
            ),
          );
       });
       labelList = listTitles.toList();
     }
     return labelList;
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
            OtherSearch(anguments: {"type":2},),//小说
            OtherSearch(anguments: {"type":2}),//直播
            OtherSearch(anguments: {"type":2}),//粤语
            OtherSearch(anguments: {"type":2}),//畅销书
            OtherSearch(anguments: {"type":2}),//精品
            OtherSearch(anguments: {"type":2}),//广播
            OtherSearch(anguments: {"type":2}),//历史
            OtherSearch(anguments: {"type":2})//商业财经
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
              enabledBorder: UnderlineInputBorder(  //设置boder边框色
                borderSide: BorderSide(color: CommonUtils.ADColor("#F1F2F2")),
                borderRadius: BorderRadius.circular(25.7),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
              suffixIcon: new SearchClickIcon(
                  wid: Icon(Icons.mic,color: CommonUtils.ADColor("#FF7A3F"),),
                  onClick: (){
                    print('点我干掉。。。');
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




