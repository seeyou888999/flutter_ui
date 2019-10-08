import 'package:flutter/material.dart';
import 'package:flutter_ui/page/MyListiner.dart';
import 'package:flutter_ui/page/MyListiner_update.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
import 'dart:math' as math;
class MeHeardPage extends StatefulWidget {
  @override
  _MeHeardPageState createState() => _MeHeardPageState();
}

class _MeHeardPageState extends State<MeHeardPage> with
    AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin,TickerProviderStateMixin{

  TabController _tabController;
  ScrollController _scrollViewController;
  GlobalKey tabrkey = GlobalKey();
  bool _isMenuShow = true;
  bool isMove = false;
  bool isOver = false;
  OverlayEntry _overlayEntry;
  AnimationController _animationController;//动画控制器 0.0到1.0范围值
  Animation<Offset> _animation; //线性
  final List<String> _tabs = <String>[
    "Featured",
    "Popular",
  ];
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

  @override
  void initState() {
    // TODO: implement initState
    _tabController =  TabController(length: 2, vsync: this,initialIndex: 0);
    _scrollViewController = new ScrollController (initialScrollOffset: 0.0);
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 500), vsync:
        this);
    _animation =
        Tween(begin: Offset(0, 0), end: Offset(0, 2)).animate
          (_animationController);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
//        print("status is completed");
        //将动画重置到开始前的状态
        setState(() {
          isOver = true;
        });
      }
    });

    _tabController.addListener((){
        if(_tabController.index==0){
          setState(() {
              _isMenuShow = true;
          });
        } else {
          setState(() {
            _isMenuShow = false;
          });
        }
    });
    super.initState();
//    _animationController.forward();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _scrollViewController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  //执行正向动画
  Future<Null> _buildAnForword() async{
    print("执行正向动画");
    await _animationController.forward();
  }

  //执行反向动画
  Future<Null> _buildAnReverse() async{
    await _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    print("=--111111111--");
    return Scaffold(
      body: _body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideTransition(
        position: _animation,
        child: Container(
          height: 30,
          child: FloatingActionButton.extended(
            heroTag: "guanzhu",
            backgroundColor: Colors.white,
            elevation: 3.0,
            label: Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.add,color: Colors.orange,size: 20,),
                  SizedBox(width: 5,),
                  Text('订阅',style: TextStyle(fontSize: 14,fontWeight:
                  FontWeight.w300,color: Colors.black),)
                ],
              ),
            ),
            onPressed: (){

            },
          ),
        ),
      )
    );
  }

  Widget _body(){
    return Listener(
        onPointerMove: (movePointEvent){
            if(!isMove){
              _buildAnForword();
              setState(() {
                isMove = true;
              });
            }
        },
        onPointerUp: (upPointEvent){
          Future.delayed(Duration(milliseconds: 500), (){ //延迟一秒1执行
            if(isOver){
              _buildAnReverse();
              setState(() {
                isOver = !isOver;
                isMove = !isMove;
              });
            }
          });
        },
        child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
                physics: new NeverScrollableScrollPhysics(),
                headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled){
                  return <Widget>[
                    buildAppBar(innerBoxIsScrolled,context),
                    _buildMenu(),
                    AppBarList(),
//                _isMenuShow?buildView():SliverToBoxAdapter(child: null,),
                  ];
                },
                body: getNestedViewBody()
            ),
        )
    );
  }
  Widget buildAppBar(bool innerBoxIsScrolled,BuildContext context){
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      child: SliverSafeArea(
        top: true,
        sliver: SliverAppBar(
          pinned: true,
          primary: true,
          forceElevated: innerBoxIsScrolled,  //嵌套CustomScrollView
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            title: TextStyle(color: Colors.black,fontSize: 16,fontWeight:
            FontWeight.w100),
            body1: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
              color: Colors.black,
              opacity: 0.8,
              size: 24
          ),
          centerTitle: true,
          title: Text('我听'),
          leading:  Container(
            child: Icon(Icons.supervisor_account),
          ),
          elevation: 0.0,
          actions: <Widget>[
            Icon(Icons.search)
          ],
        ),
      ),
    );
  }
  Widget getNestedViewBody(){
    return TabBarView(
      // These are the contents of the tab views, below the tabs.
      children: <Widget>[
          MyListiner(),
        MyListinerUpdate(),
      ],
    );
  }

  Widget _buildMenu(){
    return SliverToBoxAdapter(
      child: Container(
          height: MediaQuery.of(context).size.height/6,
          child: Card(
            elevation: 5.0,
            margin: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 5),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              padding: EdgeInsets.all(10),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.file_download,color: Colors.deepOrange,size: 30,),
                    ),
                    Container(
                      child: Text('下载',style: TextStyle(fontSize: 14),),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.access_time,color: Colors.deepOrange,size: 30,),
                    ),
                    Container(
                      child: Text('历史',style: TextStyle(fontSize: 14),),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.shopping_cart,color: Colors.deepOrange,size: 30,),
                    ),
                    Container(
                      child: Text('已购',style: TextStyle(fontSize: 14),),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.assignment,color: Colors.deepOrange,size: 30,),
                    ),
                    Container(
                      child: Text('听单',style: TextStyle(fontSize: 14),),
                    )
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget AppBarList(){
    return SliverToBoxAdapter(
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: TabBar(
                  tabs: [
                    Tab(child: Text('订阅'),),
                    Tab(child: Text('听更新'),),
                  ],
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: CommonUtils.ADColor("#FF7A3F"),
                  isScrollable: true,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: TextStyle(fontSize: 12),
                  labelColor: CommonUtils.ADColor("#FF7A3F"),
                  labelStyle: TextStyle(fontSize: 16,fontWeight:
                  FontWeight.w100),
                  onTap: (int index){

                  }
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.assignment,color: CommonUtils.ADColor('#ADADAD'),),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    child: Icon(Icons.arrow_downward,color: CommonUtils.ADColor
                      ('#ADADAD'),),
                  ),
                  GestureDetector(
                    child: Container(
                        child: Text('收起',style: TextStyle(fontSize: 12,color:
                        CommonUtils.ADColor('#ADADAD')))
                    ),
                    onTap: (){
                      _isMenuShow = !_isMenuShow;
//                        _showBaiduOverlayMenu(_isMenuShow);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildView(){
    return SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: _SliverAppBarDelegate(
          maxHeight: (data.length * 35).toDouble(),
          minHeight: (data.length * 35).toDouble(),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border:Border(bottom:BorderSide(width: 1,color: Color
                  (0xffe5e5e5)),top:BorderSide(width: 1,color: Color
                  (0xffe5e5e5)) )
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: loadMenueList()
            ),
          )
      ),
    );
  }


  List<Widget> loadMenueList() {
    List <Widget> list = new List();
    for (int i = 0; i < data.length; i++) {
      list.add(
          Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                    itemCount: 1,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
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
                  label: Text('${list[i]["title"]}',style: TextStyle
                    (fontSize: 14),),
                  padding: EdgeInsets.only(bottom: 12),
                  labelStyle: TextStyle(fontSize: 12,color: Colors.deepOrange)
              ):Text('${list[i]["title"]}',style: TextStyle(fontSize: 12,
                  color: Colors.black),)
          )
      );
    }
    return widgetlist;
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
