import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
as extended;
import 'package:flutter_ui/common/AudioPlayerManager.dart';
import 'package:flutter_ui/common/PopupMenuItem.dart';
import 'package:flutter_ui/common/StickSlivers.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/page/LisinterBulidItem.dart';
import 'package:flutter_ui/page/LisinterPage.dart';
import 'package:flutter_ui/res/colors.dart';

class LisinterPlayItem extends StatefulWidget {
  final String tabId;
  final ScrollController scrollController;
  final GlobalKey glKey;
  final editParentText;
  LisinterPlayItem(
      {this.tabId, this.scrollController, this.glKey, this.editParentText});
  @override
  _LisinterPlayItemState createState() => _LisinterPlayItemState();
}

class _LisinterPlayItemState extends State<LisinterPlayItem> {
  EasyRefreshController easyRefreshController;
  int listCount = 5;
  int TYPE_INDEX = 0;
  bool isshow = false;
  int selectIndex = 0;
  double offset = 0;
  @override
  void initState() {
    easyRefreshController = new EasyRefreshController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildItem(double offset){



    return HJPopupMenu(
      top: offset,
      initialValue: TYPE_INDEX,
      items: TYPES.map((e) {
        return HJPopupMenuItemData(
            title: e['title'], value: e['value']);
      }).toList(),
      valueChanged: (value) {
        setState(() {
          TYPE_INDEX = value;
          isshow = !isshow;
          selectIndex = !isshow ? 0 : 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
        children: <Widget>[
          buildHome(),
          bulidItemPlayer()
        ],
      index: selectIndex,
    );
  }
  Widget bulidItemPlayer(){
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate:
          StickyTabBarDelegate(child: buildTabBar(), height: 48),
          floating: true,
          pinned: true,
        ),
        SliverToBoxAdapter(
          child:  buildItem(0),
        )
      ],
    );
  }
  Widget buildHome(){
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
        Key('Tab1'),
        EasyRefresh.builder(
          controller: easyRefreshController,
          header: ClassicalHeader(
            refreshText: '下拉刷新',
            refreshReadyText: '释放刷新',
            refreshingText: '正在刷新...',
            refreshedText: '刷新完成',
            refreshFailedText: '刷新失败',
            noMoreText: '没有更多',
            infoText: '更新于 %T',
          ),
          footer: ClassicalFooter(
              loadedText: '加载完成',
              loadReadyText: '释放加载',
              loadingText: '正在加载...',
              loadFailedText: '加载失败',
              noMoreText: '没有更多',
              infoText: '更新于 %T'),
          taskIndependence: true,
          builder: (context, physics, header, footer) {
            return CustomScrollView(
              physics: physics,
              slivers: <Widget>[
                SliverPersistentHeader(
                  delegate:
                  StickyTabBarDelegate(child: buildTabBar(), height: 48),
                  floating: true,
                  pinned: true,
                ),
                header,
                SliverList(delegate:  SliverChildBuilderDelegate((BuildContext context, int index) {
                  return loadListView();
                },childCount: 1)),
                footer
              ],
            );
          },
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              setState(() {
                listCount += 5;
              });
            });
          },
          onLoad: () async {
            await Future.delayed(Duration(seconds: 2), () {
              setState(() {
                listCount += 20;
              });
            });
          },
        ));
  }

  Widget loadListView() {
    return ScrollNotificationInterceptor(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: listCount,
            physics: new NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return buildListItem(index);
            }));
  }

  void valueChanged(value){
      setState(() {
        TYPE_INDEX = value;
        isshow = !isshow;
        selectIndex = !isshow ? 0 : 1;
      });
  }

  Widget buildListItem(int index) {
    return
    InkWell(
      child: Container(
          margin: EdgeInsets.all(10),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text('${index+1}',style: TextStyle(fontSize: 16,color: Colors
                  .grey),),
              new Expanded(
                  child: new Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20,),
                          new Expanded(
                            child: new Text("${index+1}章。哈啊哈",style: TextStyle
                              (fontSize: 16,fontWeight: FontWeight.w300,color:
                            Colors.black.withOpacity(0.8)),),
                          ),
                          new Text('2019-02-01',style: TextStyle(fontSize: 12,
                              color: Colors.grey))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: <Widget>[
                          Row(children: <Widget>[
                            SizedBox(width: 20,),
                            Icon(Icons.play_arrow,size: 15,color: Colors.grey
                                .withOpacity(0.3),),
                            new Text('2000.5万',style: TextStyle(fontSize: 12,
                                color: Colors.grey.withOpacity(0.5)),),
                            SizedBox(width: 5,),
                            Icon(Icons.message,size: 15,color: Colors.grey
                                .withOpacity(0.3),),
                            new Text('465',style: TextStyle(fontSize: 12,
                                color: Colors.grey.withOpacity(0.5))),
                            SizedBox(width: 5,),
                            Icon(Icons.access_time,size: 15,color: Colors.grey
                                .withOpacity(0.3),),
                            new Text('09:45',style: TextStyle(fontSize: 12,
                                color: Colors.grey.withOpacity(0.5))),
                            SizedBox(width: 5,),
                            new Text('已播放:27%',style: TextStyle(fontSize: 12,
                                color: Colors.orange),),
                          ],),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(icon: Icon(Icons.file_download,size: 20,color:
                              Colors.grey.withOpacity(0.5),),onPressed: (){
                                print('下载---');
                              },),
                            ),
                          )
                        ],
                      ),
                      new Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Divider(height: 2,color: Colors.grey.withOpacity(0.5),indent:
                        10,),
                      )
                    ],
                  )
              ),
            ]
            ,
          )),
      onTap: (){
        if(!AudioPlayerManager.isPlay) AudioPlayerManager.isPlay = true;
        AudioPlayerManager.getPlayerIndex().then((v){
          Navigator.push(context,
              MaterialPageRoute(builder:(context){
                return LisinterPage(aguments:
                {"playerIndex":v,"isPlay:"
                    "":true});
                //跳转搜索页面
              })
          );
        });
      },
    );
  }

  Widget buildTabBar() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              color: MyColors.textBlack9.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.play_arrow,
                  size: 20,
                  color: !isshow ? Colors.black : Colors.grey.withOpacity(0.5),
                ),
                new Text(
                  '全部播放',
                  style: TextStyle(
                      fontSize: 14,
                      color: !isshow
                          ? Colors.black
                          : Colors.grey.withOpacity(0.5)),
                )
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Row(
            children: <Widget>[
              IconButton(
                  color: Colors.black,
                  disabledColor: Colors.grey.withOpacity(0.5),
                  icon: Icon(Icons.format_list_numbered_rtl, size: 20),
                  onPressed: isshow ? null : () {}),
              IconButton(
                  color: Colors.black,
                  disabledColor: Colors.grey.withOpacity(0.5),
                  icon: Icon(Icons.file_download, size: 20),
                  onPressed: isshow ? null : () {}),
            ],
          ),
          InkWell(
            child: Container(
              child: Row(
                children: <Widget>[
                  new Text(
                    '共999集',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    !isshow
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    size: 25,
                    color: Colors.grey.withOpacity(0.5),
                  )
                ],
              ),
            ),
            onTap: () {
              setState(() {
                isshow = !isshow;
                selectIndex = !isshow ? 0 : 1;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

