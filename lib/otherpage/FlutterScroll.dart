import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
import 'dart:math' as math;
class HomeSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> with
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
        appBar: PreferredSize(
          child: AppBar(
              backgroundColor: Colors.white,
              brightness: Brightness.dark,
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.black)
              ),
              flexibleSpace: Container(
                margin: EdgeInsets.only(left: 10,top: 5),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: CommonUtils.ADColor('#ADADAD')
                            ),
                            child: new Text('MK',style: TextStyle(fontSize: 10),),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            child: new Text('MRCHR',style: TextStyle(fontSize: 14),),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      alignment: Alignment.topLeft,
                      child: new Text('2019-05-01 (三)',style: TextStyle
                        (fontSize: 14),),
                    )
                  ],
                ),
              ),
            ),
          preferredSize: Size.fromHeight(80),),
          body: new NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool indexchange){
                return <Widget>[
                  loadTopBar()
                ];
              },
              body: loadHomeBody()
          ),
        ),
    );
  }
  
  Widget loadHomeBody(){
      return ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context , int index){
         return _loadHome();
      }
    );
  }

  Widget _loadHome(){
    return Container(
      color: CommonUtils.ADColor('#F1F2F2'),
      child: Column(
        children: <Widget>[
          Container( //第一块内容页面
            margin: EdgeInsets.only(top: 20,bottom: 20),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(15, 10, 10, 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: new Text('Agenda',style: TextStyle
                              (fontSize: 16,fontWeight: FontWeight.w600),),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20,
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(60)
                            ),
                            alignment: Alignment.center,
                            child: new Text('29 New'),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.navigate_next,size: 15,color:
                            CommonUtils.ADColor('#ADADAD'),),
                          ),
                        )
                      ],
                    )
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 20),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: CommonUtils.ADColor('#ADADAD'),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
//                                  alignment: Alignment.topLeft,
                                  color: Colors.blueAccent,
                                  child: Text('Title',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                ),
                                Container(
//                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Chip(label: Text('公司假期'),),
                                      Chip(label: Text('迟早')),
                                      Chip(label: Text('早退')),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10,bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Icon(Icons.access_time,size: 20,color: CommonUtils.ADColor('#ADADAD')),
                                      ),
                                      Expanded(
                                        flex: 10,
                                        child:  new Text('(Shift '
                                            '尼玛得BBBBBBBBBBBB)',style: TextStyle(color: CommonUtils
                                            .ADColor('#ADADAD'),
                                            fontSize: 12)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              color: CommonUtils.ADColor('#ADADAD'),
                                              borderRadius: BorderRadius
                                                  .circular(60)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10,bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex:5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius
                                                .circular(3),
                                            border: new Border.all(//添加边框
                                              width: 1.0,//边框宽度
                                              color: Colors.black12,//边框颜色
                                            ),
                                          ),
                                          height: 30,
                                          child: Text('09:03',style:
                                          TextStyle(fontSize: 20,fontWeight:
                                          FontWeight.w600,color: Colors.black12),),
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 20,
                                            height: 30,
                                            child: Text('一',style: TextStyle
                                              (color:CommonUtils.ADColor('#ADADAD')),),
                                          )
                                      ),
                                      Expanded(
                                        flex:5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius
                                                .circular(3),
                                            border: new Border.all(//添加边框
                                              width: 1.0,//边框宽度
                                              color: Colors.black12,//边框颜色
                                            ),
                                          ),
                                          height: 30,
                                          child: Text('18:00',style:
                                          TextStyle(fontSize: 20,fontWeight:
                                          FontWeight.w600,color: Colors.black12),),
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 5,bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Icon(Icons.add_location,size: 20,color: CommonUtils.ADColor('#ADADAD')),
                                      ),
                                      Expanded(
                                        flex: 13,
                                        child:  new Text('(Shift '
                                            '丢你老母丢你老母丢你老母丢你老母xxasdasdadax丢你老母'
                                            '丢你老母丢你老母adasd丢你老母丢你老母丢你老母)'
                                          ,maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: CommonUtils
                                              .ADColor('#ADADAD'),
                                              fontSize: 12),),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 5,bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Icon(Icons.check_circle,size:
                                        20,color: CommonUtils.ADColor('#ADADAD'),),
                                      ),
                                      Expanded(
                                        flex: 13,
                                        child:  new Text('(Shift '
                                            '丢你老母丢你老母丢你老母丢你老母xxasdasdadax丢你老母'
                                            '丢你老母丢你老母adasd丢你老母丢你老母丢你老母)'
                                            , overflow: TextOverflow.ellipsis,style: TextStyle(color: CommonUtils
                                                .ADColor('#ADADAD'),
                                                fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(height: 1.0,color:Colors.orange,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 20),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text('Phasellus porttitos nunc',
                                  style: TextStyle(fontSize: 16,
                                      fontWeight:FontWeight.w600),),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                child: Text('09:00 - 12:00',style: TextStyle
                                  (fontSize: 12,color: CommonUtils.ADColor('#ADADAD')),),
                              ),
                              SizedBox(height: 10,),
                              Divider(height: 1.0,color: CommonUtils.ADColor('#ADADAD')) ,
                            ],
                          ),
                        )
                      ],
                    )
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10,20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10,right: 20),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text('Phasellus porttitos nunc',
                                  style: TextStyle(fontSize: 16,
                                      fontWeight:FontWeight.w600),),
                              ),
                              Container(
                                child: Text('09:00 - 12:00',style: TextStyle
                                  (fontSize: 12,color: CommonUtils.ADColor('#ADADAD')),),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
          _buildListView(),
        ],
      ),
    );
  }

  Widget _buildListView(){
    return  ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index){
        return  Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(15, 10, 10, 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: new Text('Agenda',style: TextStyle
                              (fontSize: 16,fontWeight: FontWeight.w600),),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20,
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(60)
                            ),
                            alignment: Alignment.center,
                            child: new Text('29 New'),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.navigate_next,size: 15,color:
                            CommonUtils.ADColor('#ADADAD'),),
                          ),
                        )
                      ],
                    )
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10,20),
                    child: Column(
                      children: [
                        ListView.builder(
                            itemCount: 3,
                            shrinkWrap: true,
                            physics: new NeverScrollableScrollPhysics(),
                            itemBuilder: ((BuildContext
                            context, int indexh){
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10,right: 20),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Chip(
                                          elevation: 0.0,
                                          backgroundColor: CommonUtils.ADColor('#F1F2F2'),
                                          label: Text('Lucas Pough'),
                                          avatar: Icon(Icons.check_circle,size: 18,),
//                              shape: ,
                                        ),
                                      ),
                                      Container(
                                        child: Text('Phasellus porttitos nunc',
                                          style: TextStyle(fontSize: 16,
                                              fontWeight:FontWeight.w600),),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        child: Text('09:00 - 12:00',style: TextStyle
                                          (fontSize: 12,color: CommonUtils.ADColor('#ADADAD')),),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        child: Chip(
                                          avatar: Icon(Icons.radio_button_unchecked,
                                            color: Colors.deepOrangeAccent,size: 15,),
                                          label: Text('Status'),
                                        ),
                                      ),
                                      indexh==2?Container():Divider(height: 1.0,
                                          color:
                                      CommonUtils.ADColor('#ADADAD'))
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                         )
                        )
                      ]
                    )
                ),
              ]
          ),
        );
    });
  }



  Widget loadTopBar(){
    return SliverPersistentHeader(
          pinned: true,
        delegate: _SliverAppBarDelegate(
            maxHeight: 60,
            minHeight: 60,
            child: Container(
              color: Colors.orangeAccent,
                child: Row(
                  children: <Widget>[
                   Expanded(child:  Container(
                     child: Icon(Icons.add_alert,size: 40,),
                     ),
                   ),
                  Expanded(
                    flex: 3,
                      child:  Container(
                      child:new Text('我丢你老母啊啊啊',
                        maxLines: 2,overflow: TextOverflow.ellipsis,style:
                        TextStyle(fontSize: 14),),
                    )
                  ),
                  Expanded(
                    child: Container(
//                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(left: 20),
                      child: Icon(Icons.close,size: 20,),
                    )),
                  ],
                )
              ),
            )
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