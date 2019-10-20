import 'package:flutter/material.dart';
import 'package:flutter_ui/common/ToastShow.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/model/LisinterBottomModel.dart';
import 'package:flutter_ui/otherpage/bottom_drag_widget.dart';
import 'package:flutter_ui/res/colors.dart';
import 'package:flutter_ui/res/dimens.dart';
import 'package:sticky_headers/sticky_headers.dart';

class LisinterBottomDrag extends StatefulWidget {
  final AnimationController offsetAnimationController;
  LisinterBottomDrag({this.offsetAnimationController});

  @override
  _LisinterBottomDragState createState() => _LisinterBottomDragState();
}

class _LisinterBottomDragState extends State<LisinterBottomDrag> {
  ScrollController _controller;
  double get screenH => MediaQuery.of(context).size.height;
  List<String>  listwidget = new List();
  double _mPage = 0;
  @override
  void initState() {
    getData();
    _controller = new ScrollController()..addListener((){
      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        //如果不是最后一页数据，则生成新的数据添加到list里面
        if(_mPage < 4){
          print('----上拉加载----');
          _retrieveData();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //初始化加载数据
  void getData(){
    for (int i=0;i<5;i++){
      listwidget.insert(listwidget.length, "这是新加载的第${listwidget.length}条数据");
      print(listwidget[i]);
    }
  }
  //上拉加载数据
  void _retrieveData() async {
    _mPage ++;
    await Future.delayed(Duration(seconds: 1)).then((e){
      for (int i=0;i<3;i++){
        listwidget.insert(listwidget.length, "这是上拉加载的第${listwidget.length}条数据");
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.grey.withOpacity(0.1),
        child: BottomDragWidget(
          dragContainer: DragContainer(
            drawer: Container(
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.98),
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: Column(
                children: <Widget>[
                  _buildSheetTabBar(),
                  Expanded(child: _buildSheetContext())
                ],
              ),
            ),
            defaultShowHeight: 0,
            height: screenH,
          ),
        ));
  }

  Widget _buildSheetTabBar() {
    return Container(
      height: Dimens.titleHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: new Text(
                  '全部 300 条评论',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )),
          ),
          InkWell(
            child: Container(
              child: Icon(
                Icons.close,
                color: Colors.red,
                size: 25,
              ),
            ),
            onTap: () async {
              widget.offsetAnimationController.reverse();
              await Future.delayed(Duration(milliseconds: 300));
              ToastShow.removeToast();
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  Widget _buildSheetContext() {
    return OverscrollNotificationWidget(
        child:ListView(
          controller: _controller,
          padding: EdgeInsets.only(bottom: 10),
          physics: new ClampingScrollPhysics(),
          children: <Widget>[
            new StickyHeader(
              header: new Container(
                height: 38,
                color: Colors.grey.withOpacity(0.9),
                padding: new EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: new Text(
                  '热门评论 ',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              content: ListView.builder(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _buildHotReviewList(0);
                },
                itemCount: 3,
              ),
            ),
            new StickyHeader(
              header: new Container(
                height: 38,
                color: Colors.grey.withOpacity(0.9),
                padding: new EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: new Text(
                  '全部评论 ',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              content:
                Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if(index == listwidget.length){ //最后一条数据
                      if(_mPage < 4){
                        return new Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator
                                  (strokeWidth: 2.0,
                                  backgroundColor:Colors.grey,),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              new Text('正在加载更多内容......',style:
                              TextStyle(fontSize: 12,color: Colors.grey),)
                            ],
                          ),
                        );
                      } else {
                        return new Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: new Text('我是有底线的!!!',style:TextStyle
                            (color: Colors.grey),),
                        );
                      }
                    } else {
                      return _buildHotReviewList(1);
                    }
                  },
                  //分割线构造器
                  separatorBuilder: (context,index){
                    return new Divider(
                        indent: 70, color: MyColors.meBgColor
                        .withOpacity(0.5));
                  },
                  itemCount: listwidget.length+1,
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget _buildHotReviewList(int type) {
    return Container(
      child: ListTile(
          leading: Container(
            //本地圆角图片
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(type == 0
                      ? 'https://imagev2.xmcdn.com/group47/M00/2B/E1/wKgKm1uEthTz13hxAAROx6fnPZ8302.jpg'
                      : 'http://imagev2.xmcdn.com/group50/M00/48/C5/wKgKmVvvmKCRMK-JAAF-6QUkwdE602.jpg'),
                )),
          ),
          title: Text(
            type == 0 ? '偷得半生闲' : "锎总今日说",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                child: new Text(
                  '2019-06-06',
                  style: TextStyle(
                      fontSize: 14,
                      color: MyColors.textBlack9.withOpacity(0.5)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //回复内容
              Container(
                child: new Text(
                  type == 0 ? '这声音怎么找不到当初听鬼吹灯的感觉' : "锎总说要赚一个亿！！！",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //点赞
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ActionChip(
                      backgroundColor: Colors.white,
                      avatar: Icon(
                        Icons.thumb_up,
                        size: 15,
                        color: MyColors.meBgColor.withOpacity(0.5),
                      ),
                      label: new Text(
                        '31',
                        style:
                        TextStyle(color: MyColors.textBlack9, fontSize: 12),
                      ),
                      onPressed: () {
                        print("点你妹啊");
                      },
                    ),
                    ActionChip(
                      backgroundColor: Colors.white,
                      avatar: Icon(
                        Icons.share,
                        size: 15,
                        color: MyColors.meBgColor.withOpacity(0.5),
                      ),
                      label: Text('分享',
                          style: TextStyle(
                              color: MyColors.textBlack9, fontSize: 12)),
                      onPressed: () {
                        print("分享个毛");
                      },
                    ),
                    Expanded(
                      child: InkWell(
                        child: new Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.more_horiz,
                            size: 20,
                            color: MyColors.meBgColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //被评价
              Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: MyColors.textBlack9.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2)),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: buildRColumn(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: InkWell(
                            child: new Text('查看全部200条回复 >'),
                            onTap: () {
                            })),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

            ],
          )),
    );
  }

  List<Widget> buildRColumn() {
    List<Widget> list = new List();
    for (int i = 0; i < 2; i++) {
      list.add(Container(
        margin: EdgeInsets.all(5),
        child: RichText(
          text: TextSpan(
              text: '李总',
              style: TextStyle(fontSize: 12, color: Colors.blue),
              children: <TextSpan>[
                i % 2 == 0
                    ? TextSpan(
                  text: ' 回复 ',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )
                    : TextSpan(),
                i % 2 == 0
                    ? TextSpan(
                  text: '邱毛',
                  style: TextStyle(fontSize: 12),
                )
                    : TextSpan(),
                TextSpan(
                  text: ' : ',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                TextSpan(
                    text: '食屎啦你！！！食屎啦你！！！食屎啦你！！！食屎啦你！！！食屎啦你！！！食屎啦你！！！',
                    style: TextStyle(fontSize: 12, color: Colors.black))
              ]),
        ),
      ));
    }
    return list;
  }
}
