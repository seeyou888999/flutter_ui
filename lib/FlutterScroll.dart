import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_ui/widgets/widget_utils.dart';
class NewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with
    SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  final List<String> listItems = [];

  final List<String> _tabs = <String>[
    "Featured",
    "Popular",
    "Latest",
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
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new  TabController(length: 2, vsync: this);
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
    return Material(
      child: Scaffold(
        body: DefaultTabController(
          length: _tabs.length, // This is the number of tabs.
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      title: const Text('Books'),
                      floating: true,
                      pinned: true,
                      snap: false,
                      primary: true,
                      forceElevated: innerBoxIsScrolled,
//                      bottom: TabBar(
//                        // These are the widgets to put in each tab in the tab bar.
//                        tabs: _tabs.map((String name) => Tab(text: name)).toList(),
//                      ),
                    ),
                  ),
                ),
                _buildMenu(),
                SliverToBoxAdapter(
                  child: TabBar(
                    tabs: <Widget>[
                      Tab(child: Text('订阅'),),
                      Tab(child: Text('听更新'),),
                      Tab(child: Text('听更新'),),
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: _tabs.map((String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    // This Builder is needed to provide a BuildContext that is "inside"
                    // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                    // find the NestedScrollView.
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        // The "controller" and "primary" members should be left
                        // unset, so that the NestedScrollView can control this
                        // inner scroll view.
                        // If the "controller" property is set, then this scroll
                        // view will not be associated with the NestedScrollView.
                        // The PageStorageKey should be unique to this ScrollView;
                        // it allows the list to remember its scroll position when
                        // the tab view is not on the screen.
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            // This is the flip side of the SliverOverlapAbsorber above.
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: _SliverAppBarDelegate(
                              maxHeight: (data.length * 35).toDouble(),
                              minHeight: (data.length * 35).toDouble(),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:Border(bottom:BorderSide(width: 1,color: Color
                                      (0xffe5e5e5)),top:BorderSide(width: 1,color: Color
                                      (0xffe5e5e5)) )
                                ) ,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: loadMenueList()
                                ),
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            // In this example, the inner scroll view has
                            // fixed-height list items, hence the use of
                            // SliverFixedExtentList. However, one could use any
                            // sliver widget here, e.g. SliverList or SliverGrid.
                            sliver: SliverFixedExtentList(
                              // The items in this example are fixed to 48 pixels
                              // high. This matches the Material Design spec for
                              // ListTile widgets.
                              itemExtent: 60.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  // This builder is called for each child.
                                  // In this example, we just number each list item.
                                  return Container(
                                      color: Color((math.Random().nextDouble() *
                                                      0xFFFFFF)
                                                  .toInt() <<
                                              0)
                                          .withOpacity(1.0));
                                },
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
                                childCount: 30,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
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
                  controller: _tabController,
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

  List<Widget> loadMenueList() {
    List <Widget> list = new List();
    for (int i = 0; i < data.length; i++) {
      list.add(
          Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                    itemCount: 1,
                    physics: new NeverScrollableScrollPhysics(),
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