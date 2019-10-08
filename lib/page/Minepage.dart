import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_marquee/animation_direction.dart';
import 'package:flutter_ui/common/FlutterMarquee.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/model/HomeTabBarModel.dart';
import 'package:flutter_ui/model/TabTitle.dart';
import 'package:flutter_ui/page/HomeSearchBar.dart';
import 'package:flutter_ui/page/HomeVip.dart';
import 'package:flutter_ui/page/HomeVip1.dart';
import 'package:flutter_ui/page/HotSearch.dart';
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

  TabController _tabController;
  PageController mPageController = PageController(initialPage: 0);

  var currentPage = 0;
  var isPageCanChanged = true;
  List<TabTitle> tabList;
  List<Widget> pageView;
  List _marqueeText = [
    '今日头条',
    '诛仙逆袭仙道',
    '鬼吹灯之王八之气',
    '盗墓笔记牛气',
  ];

  initTabData() {
    tabList = [
      new TabTitle('推荐', 0),
      new TabTitle('Vip', 1),
      new TabTitle('小说',2),
      new TabTitle('直播', 3),
      new TabTitle('粤语', 4),
      new TabTitle('儿童', 5),
      new TabTitle('精品', 6),
      new TabTitle('广播', 7),
      new TabTitle('历史', 8),
      new TabTitle('商业财经', 9)
    ];
    pageView = [
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
    ];
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    //Store.value<HomeTabModel>(context).setIsScroll(0);
    if (p != null) {//判断是哪一个切换
      isPageCanChanged = false;
      await mPageController.animateToPage(index, duration: Duration
        (milliseconds: 300), curve: Curves.ease);//等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    } else {
      _tabController.animateTo(index);//切换Tabbar
    }
  }
  @override
  void initState() {
    super.initState();
    initTabData();

    _tabController = new TabController(length: tabList.length, vsync: this,
        initialIndex: 0);
    _tabController.addListener(() {
      if (_tabController.index.toDouble() == _tabController.animation.value) {
        if (this.mounted) {
          Store.value<HomeTabModel>(context).setCurrIndex(_tabController.index);
          if(this._tabController.index == 0){
            Store.value<HomeTabModel>(context).stopPaly(true);
          } else {
            Store.value<HomeTabModel>(context).stopPaly(false);
          }
          onPageChange(_tabController.index, p: mPageController);
        }
      }
    });
  }

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
                var Maps = plan.getMap(plan.currIndex);  //获取当前第几个tabbar
                // 进而获取tabbar 对应的 背景色 以及文字颜色等等
                var colorsMap = Maps["search_colors"];
                var searchWith = Maps['search_type'];
                var isScoll = plan.isScroll;
                var pl = colorsMap==null?Colors.white:colorsMap.toList()
                    .length>1?CommonUtils.ADColor
                  ('${Maps["search_colors"][plan.index]}'):CommonUtils.ADColor
                  ('${Maps["search_colors"][0]}');
                var sizewith = MediaQuery.of(context).size.width;
                return AppBar(
                  elevation: 0,
                  backgroundColor: isScoll==0?pl:Colors.white,
                  flexibleSpace:SafeArea(
                    top: true,
                    child:Column(
                      children: <Widget>[
                        TabBar(
                          labelStyle: new TextStyle(fontSize: 16.0),
                          labelColor: CommonUtils.ADColor(Maps["font_color"][0]),
                          unselectedLabelColor: CommonUtils.ADColor(Maps["font_color"][1]),
                          unselectedLabelStyle: new TextStyle(fontSize: 12.0),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: searchWith==2?Colors .orange:Colors
                              .white,
                          isScrollable: true,
                          controller: _tabController,
                          tabs: tabList.map((item) {
                            return Tab(
                                text: item.title,
                            );
                          }).toList(),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 10,top: 5,right: 10),
                                    height: 30,
                                    width:searchWith==2?sizewith/1.4:searchWith==1?sizewith/1.5:sizewith/1,
                                    child: buildTextField(searchWith),
                                  ),
                                  Container(
                                    alignment:Alignment.topLeft,
                                    width:
                                    searchWith==2?
                                    sizewith/1.7:searchWith==1?
                                    sizewith/1.85:sizewith/1.2,
                                    margin:EdgeInsets.only(top:8,left: 10),
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
                            ),
                            HomeSearchBarPage(Maps,plan.currIndex)
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
      body: PageView.builder(
          itemCount: tabList.length,
          onPageChanged: (index) {
            if (isPageCanChanged) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
              onPageChange(index);
            }
          },
          controller: mPageController,
          itemBuilder: (BuildContext context, int index) {
            return pageView[index];
          }
      )
    );
  }

  Widget buildTextField(int type) {
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
            fillColor: CommonUtils.ADColor('#F3F4F4'),
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}
