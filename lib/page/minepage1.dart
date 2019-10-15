import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_marquee/animation_direction.dart';
import 'package:flutter_ui/common/FlutterMarquee.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/model/HomeTabBarModel.dart';
import 'package:flutter_ui/model/planmodel.dart';
import 'package:flutter_ui/page/HomeVip.dart';
import 'package:flutter_ui/page/HomeVip1.dart';
import 'package:flutter_ui/page/HotSearch.dart';
import 'package:flutter_ui/page/MyFind_Dub.dart';
import 'package:flutter_ui/widgets/SearchClick_Button.dart';
import 'package:flutter_ui/widgets/home_tabar_page.dart';
import 'package:flutter_ui/widgets/search_home.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';

class MinePage extends StatefulWidget {

  @override
  _MinePageState createState() => _MinePageState();
}

//首页tabar加载
class _MinePageState extends State<MinePage> with
    AutomaticKeepAliveClientMixin<MinePage>,SingleTickerProviderStateMixin<MinePage>{
  bool isLoadHome = true;
  TabController _tabController;
  List<Tab> _tabs = <Tab>[
    CommonUtils.AdTabItems('推荐'),
    CommonUtils.AdTabItems('Vip'),
    CommonUtils.AdTabItems('小说'),
    CommonUtils.AdTabItems('直播'),
    CommonUtils.AdTabItems('粤语'),
    CommonUtils.AdTabItems('儿童'),
    CommonUtils.AdTabItems('精品'),
    CommonUtils.AdTabItems('广播'),
    CommonUtils.AdTabItems('历史'),
    CommonUtils.AdTabItems('商业财经'),
  ];
  List _marqueeText = [
    '今日头条',
    '诛仙逆袭仙道',
    '鬼吹灯之王八之气',
    '盗墓笔记牛气',
  ];

  List<Widget> _getMarqueeWidget(List lists){
    List<Widget> list = new List();
    if(lists.isNotEmpty && lists.length > 0 ) {
      for (int i = 0; i< lists.length; i ++) {
        list.add(
            Container(
                margin: EdgeInsets.only(left: 60),
                width: MediaQuery.of(context).size.width,
                child: Text(lists[i].toString(),overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),textAlign: TextAlign.left,)
            )

        );
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return loadHome();
  }

  Widget loadHome(){
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: new Builder(builder: (BuildContext context){ //重新创建builder
            return
              Store.connect<HomeTabModel>(builder: (context,plan,child){
                return AppBar(
                  elevation: 0,
                  backgroundColor: CommonUtils.ADColor(plan.getIndex(plan.index)),
                  flexibleSpace:SafeArea(
                    top: true,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TabBar(
                          labelStyle: new TextStyle(fontSize: 16.0),
                          unselectedLabelColor: Colors.black,
                          unselectedLabelStyle: new TextStyle(fontSize: 12.0),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: CommonUtils.ADColor(plan.getIndex(plan.index)),
                          isScrollable: true,
                          controller: _tabController,
                          tabs: _tabs,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10,top: 5,
                                      right: 10),
                                  height: 30,
                                  width: MediaQuery.of(context).size
                                      .width/1.4,
                                  child: buildTextField(),
                                ),
                                Container(
                                  alignment:Alignment.topLeft,
                                  width:MediaQuery.of(context).size
                                      .width/1.8,
                                  margin:EdgeInsets.only(top:8),
                                  child: FlutterMarquee(
                                    singleStart: plan.boolPay,
                                    animationDirection: AnimationDirection.b2t,
                                    children: _getMarqueeWidget(_marqueeText),
                                    autoStart: plan.boolPay,
                                    onChange: (index){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder:(context){
                                            return Search( _marqueeText[index]);
                                            //跳转搜索页面
                                          })
                                      );
                                      plan.stopPaly(false);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Icon(Icons.access_time,size: 20,color:
                              Colors.white,),
                            ),
                            SizedBox(width: 20),
                            Container(
                              child: Icon(Icons.menu,size: 20,color: Colors.white,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
             }
        )
      ),
      body: TabBarView(
        controller: this._tabController,
        children: <Widget>[
          HomeTabrPage(),//首页
          HomeVip(),
          HomeVip1(),
          HotSearch(),
          HotSearch(),
          HotSearch(),
          HotSearch(),
          HotSearch(),
          HotSearch(),
          HotSearch(),
        ],
      )
    );
  }

  Widget buildTextField() {
    return  TextField(
        style: TextStyle(fontSize: 13),
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(70)),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: '',
            enabledBorder: UnderlineInputBorder(  //设置boder边框色
              borderSide: BorderSide(color: Colors.white),
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
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _tabController = new TabController(length: _tabs.length, vsync: this,
        initialIndex: 0);
    _tabController.addListener(() {
      if (_tabController.index.toDouble() == _tabController.animation.value) {
        if (this.mounted) {
          if(this._tabController.index == 0){
            Store.value<HomeTabModel>(context,0).setIndex(0);
            Store.value<HomeTabModel>(context,0).stopPaly(true);
          } else {
            Store.value<HomeTabModel>(context,0).setIndex(5);
            Store.value<HomeTabModel>(context,0).stopPaly(false);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}
