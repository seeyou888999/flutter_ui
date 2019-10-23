import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_ui/common/ToastShow.dart';
import 'package:flutter_ui/otherpage/floatingActionButton.dart';
import 'package:flutter_ui/page/LisinterPlayeValidity.dart';
import 'package:flutter_ui/page/LisinterPlayerItem.dart';
import 'package:flutter_ui/res/colors.dart';
import 'package:flutter_ui/res/dimens.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;

class LisinterPlayer extends StatefulWidget {
  @override
  _LisinterPlayerState createState() => _LisinterPlayerState();
}

class _LisinterPlayerState extends State<LisinterPlayer> with SingleTickerProviderStateMixin{
  ScrollController scrollController;
  TabController tabController;
  Color _iconColor = Color.fromARGB(255, 255, 255, 255);
  Color _textBgColor = Color.fromARGB(0, 255, 255, 255);
  Color _titleBgColor = Color.fromARGB(255, 90, 106, 108);
  double paddingTop = 0.0;
  int _tabIndex = 1;
  final int DEFAULT_SCROLLER = 200;
  int editText= 0;
  GlobalKey  globalKey;
  @override
  void initState() {
    super.initState();
    globalKey = new GlobalKey();
    tabController = new TabController(length: 3, vsync: this,initialIndex: 1);
    scrollController = new ScrollController()
    ..addListener((){
      if (scrollController.offset <= 100) {
        setState(() {
          double num = (1 - scrollController.offset / 100) * 255;
          _iconColor = Color.fromARGB(255, num.toInt(), num.toInt(), num.toInt());
          _textBgColor = Color.fromARGB(255-num.toInt(), num.toInt(), num.toInt(), num
              .toInt());
          _titleBgColor = Color.fromARGB(0 + num.toInt(), 90, 106, 108);
        });
      }   else {
        setState(() {
          double num = (1 - scrollController.offset / 100) * 255;
          _iconColor = Color.fromARGB(255, 0, 0, 0);
          _textBgColor = Color.fromARGB(255, 0,0, 0);
          _titleBgColor = Color.fromARGB(255 - num.toInt(), 255, 255, 255);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var pinnedHeaderHeight =statusBarHeight +23;
    Future<bool> _onWillPop()=>new Future.value(false);
    return WillPopScope(
        onWillPop:_onWillPop,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Dimens.titleHeight),
            child: AppBar(
                elevation: 0.0,
                backgroundColor: _titleBgColor,
                automaticallyImplyLeading: false,
                title:Text('我欲封天'),
                centerTitle: true,
                leading: InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Icon(Icons.keyboard_arrow_left,size: 25),
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    ToastShow.removeToast();
                  },
                ),
                textTheme: TextTheme(
                    title: TextStyle(color: _textBgColor,fontSize: 14)
                ),
                iconTheme: IconThemeData(
                    color: _iconColor
                ),
                actions: <Widget>[
                  Container(
                    child: Icon(Icons.share,size: 18,),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    child: Icon(Icons.more_horiz,size: 18,),
                  ),
                  SizedBox(width: 10,)
                ]
            ),
          ),
          body: extended.NestedScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            innerScrollPositionKeyBuilder: () {
              return Key("Tab$_tabIndex");
            },
            pinnedHeaderSliverHeightBuilder: (){
              return pinnedHeaderHeight;
            },
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                loadCoverView(),
              ];
            },
            body: IndexedStack(
              index: _tabIndex,
              children: <Widget>[
                LisinterPlayerValidity(),
                LisinterPlayItem(tabId: "Tab$_tabIndex",scrollController:
                scrollController,glKey: globalKey),
                Container(),
              ],
            ),
         ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Hero(
            tag: 'floatButton',
            child: FloationActionButton(),
          )
      ),
    );
  }

  Widget loadTopTitle(){
    return Positioned(
      child: Container(
        color: Colors.white,
        child: TabBar(
            labelColor: Colors.black87,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.deepOrange,
            unselectedLabelColor:CommonUtils.ADColor('#ADADAD'),
            unselectedLabelStyle: (TextStyle(fontSize: 12)),
            labelStyle: TextStyle(fontSize: 14,color:Colors.red,
                fontWeight:
                FontWeight.w100),
            controller: tabController,
            onTap: (index) {
              setState(() {
                _tabIndex = index;
              });
            },
            tabs: [
              Tab(text: '简介',),
              Tab(text: '节目',),
              Tab(text: '圈子',)
            ]
        ),
      )
    );
  }

  Widget loadCoverView(){
    return SliverToBoxAdapter(
      child: Container(
        key: globalKey,
        color: Color.fromARGB(255, 90, 106, 108),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                loadStackCover(),
                loadCoverTitile()
              ]
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: new Text('8.3分',style: TextStyle(fontSize: 12,color:
                        MyColors.white),),
                          padding:EdgeInsets.only(left: 10)
                      ),
                      Container(child: RatingBar(
                        initialRating: 3.5,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        unratedColor: Colors.grey,
                        itemSize: 10,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.white,
                        ),

                      ),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding:EdgeInsets.only(right: 60),
                        child: new RichText(
                          text: TextSpan(
                              text: '1.6万 ',
                              style: TextStyle(fontSize: 14,color:
                              MyColors.white),
                              children: [
                                new TextSpan(
                                    text: '人订阅',
                                    style: TextStyle(fontSize: 12,color:
                                    MyColors.textBlack9)
                                )
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 70,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add,size: 20),
                        new Text('订阅',style: TextStyle(fontSize: 12),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Stack(
              children: <Widget>[
                loadTopTitle()
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget loadCoverTitile(){
    return Container(
      margin: EdgeInsets.fromLTRB(120, 10, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: new Text('极品透视保镖-005(免费章节每天晚上七点我听直播间现场直播~)',style:
            TextStyle(fontSize: 14,color: MyColors.white),textAlign:
            TextAlign.left,),
          ),
          SizedBox(height: 10,),
          Container(
            height: 20,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.black.withOpacity(0.1)
            ),
            child: new Text('看王麻子如何逆天改命！！！！',style: TextStyle(fontSize: 12,
                color: Colors.grey),),
          ),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage('http://imagev2.xmcdn'
                        '.com/group48/M02/B9/0A/wKgKlVtK4OTzdF7aAAOg8rbroOk663.jpg',)
                  )
                ),
              ),
              SizedBox(width: 5,),
              new Text
                ('kitKing南霸天东风吹',style: TextStyle(color: Colors.grey,
                  fontSize: 10),)
            ],
          )
        ],
      ),
    );
  }

  Widget loadStackCover(){
    return  Container(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Positioned(
            child: Container(
              margin: EdgeInsets.all(10),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  image: DecorationImage(
                      image: NetworkImage('http://imagev2.xmcdn'
                          '.com/group48/M02/B9/0A/wKgKlVtK4OTzdF7aAAOg8rbroOk663.jpg',)
                  )
              ),
            ),
          ),
          Positioned(
            left: 38,
            child: Container(
              margin: EdgeInsets.only(left: 48,bottom: 10),
              width: 20,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  image: DecorationImage(
                      image: NetworkImage('https://s1.xmcdn.com/yx/ximalaya-web-static/last/dist/images/cover-right_dd0ab25.png',)
                  )
              ),
            ),
          ),

          Positioned(
              left: 10,
              bottom: 10,
              width: 80,
              height: 20,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3)
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10,),
                    Container(
                      child: Icon(Icons.headset,size: 10,color: MyColors.white,),
                    ),
                    SizedBox(width: 5,),
                    Container(
                        child: new Text('5.1亿',style: TextStyle(fontSize: 10,
                            color: MyColors.white
                        ),)
                    )
                  ],
                ),
              )
          )
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

}
