import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bubble/bubble_widget.dart';
import 'package:flutter_ui/common/RIKeys.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/otherpage/flutter_sheet_tabview.dart';
import 'package:flutter_ui/res/colors.dart';
import 'package:flutter_ui/res/dimens.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';

class LinsterContent extends StatefulWidget {
  @override
  _LinsterContentState createState() => _LinsterContentState();
}

class _LinsterContentState extends State<LinsterContent> {
  List list = [
    '都市',
    '8090',
    '异能',
    '有声小说',
    '爽文',
    '悬疑',
    '仙侠',
    '萌新小说',
    '穿越',
    '金庸古龙'
  ];
  // Each section header height;
  GlobalKey anchorKey = GlobalKey();
  GlobalKey anchorKey1 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildTitle(),
          Container(
            height: 14,
            color: MyColors.dividerColor,
          ),
          _buildMoreListen(),
          Container(
            height: 14,
            color: MyColors.dividerColor,
          ),
          _buildGoMeView(),
          Container(
            height: 14,
            color: MyColors.dividerColor,
          ),
          _buildAnchorTv(),
          Container(
            height: 14,
            color: MyColors.dividerColor,
          ),
          _buildHotReviews(),
          Container(
            height: 14,
            color: MyColors.dividerColor,
          )
        ],
      ),
    );
  }

  //创建内容标题
  Widget _buildTitle() {
    return Container(
      height: 80,
      child: ListTile(
        leading: Container(
          //本地圆角图片
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://imagev2.xmcdn.com/group47/M00/2B/E1/wKgKm1uEthTz13hxAAROx6fnPZ8302.jpg'),
          )),
        ),
        title: Text(
          '极品透视保镖(免费版每日一更)',
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        subtitle: Text(
          '1.7万人订阅',
          style: TextStyle(fontSize: 12, color: MyColors.textBlack6),
        ),
        trailing: Container(
          width: 70,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: CommonUtils.ADColor('#FEECE8')),
          child: new Text(
            '免费订阅',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: CommonUtils.ADColor('#F86442')),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  //创建内容听书更多
  Widget _buildMoreListen() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      height: 420,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: new Text(
              '听了本节目的人也在听',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            child: ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              itemExtent: 80,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: ActionChip(
                    elevation: 2,
                    label: new Text(
                      "${list[index]} > ",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {},
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: GridView.custom(
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3 / 3.9),
            childrenDelegate:
                new SliverChildBuilderDelegate((context, postion) {
              return _playPage(listViews["news"][postion]);
            }, childCount: listViews["news"].length),
          )),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: new Text(
              '查看更多专辑',
              style: TextStyle(color: MyColors.textBlack9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _playPage(Map newMap) {
    return Container(
        width: 100,
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            borderRadius: BorderRadius.circular(3)),
        margin: EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    width: 100,
                    height: 100,
                    child: Image.network(newMap['image'], fit: BoxFit.cover)),
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image(
                      fit: BoxFit.cover,
                      width: 30,
                      height: 10,
                      image: new AssetImage('images/100.png'),
                    )),
                Container(
                    color: Color.fromRGBO(0, 0, 0, .12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 80),
                          child: Icon(
                            Icons.play_arrow,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 80, left: 5),
                          child: Text(
                            '2001.2万',
                            style:
                                TextStyle(fontSize: 10, color: Colors.white70),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 3, right: 3),
              child: Text(
                newMap['titile'],
                style: TextStyle(fontSize: 10, color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ));
  }

  //加载主播详情
  Widget _buildAnchorTv() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: new Text(
              '圈子',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          ListTile(
              leading: Container(
                //本地圆角图片
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://imagev2.xmcdn.com/group47/M00/2B/E1/wKgKm1uEthTz13hxAAROx6fnPZ8302.jpg'),
                    )),
              ),
              title: new Text(
                '探月赢音听书圈',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              ),
              subtitle: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: new Text(
                      '成员 9998',
                      style:
                          TextStyle(fontSize: 10, color: MyColors.textBlack9),
                    ),
                  ),
                  Container(
                    child: new Text(
                      '帖子 98',
                      style:
                          TextStyle(fontSize: 10, color: MyColors.textBlack9),
                    ),
                  ),
                ],
              ),
              trailing: Container(
                  width: 70,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.red)),
                  alignment: Alignment.center,
                  child: new Text(
                    '进入',
                    style: TextStyle(color: Colors.red),
                  ))),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Container(
                  height: 45,
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: MyColors.meBgColor.withOpacity(0.2)),
                  child: Text(
                    '关注探月朋友圈,许愿你喜欢的书和播音,一不小心就会实现啦,快来吧！小伙伴在召集你',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.left,
                  ))),
        ],
      ),
    );
  }

  Widget _buildGoMeView() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: new Text(
              '主播',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          ListTile(
            leading: Container(
              //本地圆角图片
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://imagev2.xmcdn.com/group47/M00/2B/E1/wKgKm1uEthTz13hxAAROx6fnPZ8302.jpg'),
                  )),
            ),
            title: Row(
              children: <Widget>[
                new Text(
                  '探月',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 250, 236, 240),
                      Color.fromARGB(255, 250, 230, 234),
                      Color.fromARGB(255, 249, 210, 215),
                      Color.fromARGB(255, 250, 199, 204),
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 1,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CommonUtils.ADColor('#FAECF0'),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              new BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                  offset: Offset(1.0, 1.0))
                            ]),
                        child: Icon(
                          Icons.mic,
                          color: CommonUtils.ADColor('#F1B9CD'),
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        child: new Text(
                          "LV14",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: CommonUtils.ADColor('#B9374C')),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            subtitle: Text(
              '',
              style: TextStyle(fontSize: 12, color: MyColors.textBlack6),
            ),
            trailing: Container(
              width: 70,
              height: 30,
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  Icon(Icons.supervisor_account),
                  new Text(
                    '加关注',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: BubbleWidget(
                      MediaQuery.of(context).size.width - 20,
                      60.0,
                      MyColors.meBgColor.withOpacity(0.2),
                      BubbleArrowDirection.top,
                      length: 20,
                      radius: 2.0,
                      child: Text(
                        '关注探月朋友圈,许愿你喜欢的书和播音,一不小心就会实现啦,快来吧！小伙伴在召集你',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.left,
                      )))),
        ],
      ),
    );
  }

  //加载热门评论
  Widget _buildHotReviews() {
    return Container(
      margin: EdgeInsets.only(bottom: 48),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                alignment: Alignment.topLeft,
                child: new Text(
                  '热门评论',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(right: 10, top: 10),
                  width: 70,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.red)),
                  child: new Text(
                    '写评论',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            children: <Widget>[
              _buildHotReviewList(1),
              Container(
                child: Divider(
                    indent: 70, color: MyColors.meBgColor.withOpacity(0.5)),
              ),
              _buildHotReviewList(0),
              Container(
                child: Divider(
                    indent: 70, color: MyColors.meBgColor.withOpacity(0.5)),
              ),
            ],
          ),
          Container(
              child: InkWell(
              child: new Text(
                '查看更多评论 >',
                style: TextStyle(color: MyColors.textBlack9),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height-30,
                      child: Stack(
                        children: <Widget>[
                          _buildSheetContext(),
                          _buildSheetTabBar(),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                constraints: BoxConstraints.expand(height: Dimens.titleHeight),
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: buildTextField(),
                                        margin: EdgeInsets.only(left: 10,right: 10),
                                        height:  Dimens.titleHeight-15,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    );
                  },
                isScrollControlled: true,
                shape: new BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3)),
                    side: new BorderSide(
                      style: BorderStyle.none,
                    )),
              );
            },
          ))
        ],
      ),
    );
  }

  Widget buildTextField() {
    return  TextFormField(
        style: TextStyle(fontSize: 13),
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        onChanged: (value){

        },
        decoration: InputDecoration(
          hintText:'我猜测,此刻你可能有话想说',
          hintStyle: TextStyle(fontSize: 14,color: CommonUtils.ADColor('#999999')),
          contentPadding: EdgeInsets.only(top: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(70)),
          ),
          filled: true,
          fillColor: CommonUtils.ADColor('#EFF1F4'),
          enabledBorder: UnderlineInputBorder(  //设置boder边框色
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.7),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.7),
          ),
          prefixIcon:  Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.create,color: CommonUtils.ADColor
                  ("#CCCCCC"),size: 20,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: 20,
                  height: 3,
                )
              ],
            ),
          ),
        )
    );
  }

  Widget _buildSheetTabBar(){
    return Container(
        height: Dimens.titleHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: new Text('全部 300 条评论',style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
              ),
            ),
            InkWell(
              child: Container(
                child: Icon(Icons.close,color: Colors
                    .black,size: 25,),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 10,)
          ],
        ),
      );
  }

  Widget _buildSheetContext(){
    return Container(
      margin: EdgeInsets.only(top: Dimens.titleHeight),
      //FlutterTableView
      child: FlutterSheetTabView(
        shrinkWrap: true,
        sectionCount: 2,
        rowCountAtSection: _rowCountAtSection,
        sectionHeaderBuilder: _sectionHeaderBuilder,
        cellBuilder: _cellBuilder,
        sectionHeaderHeight: _sectionHeaderHeight,
        cellHeight: _cellHeight,
      ),
    );
  }

  double _sectionHeaderHeight(BuildContext context, int section) {
    return 40.0;
  }

  // Each cell item widget height.
  double _cellHeight(BuildContext context, int section, int row) {
    return 200.0;
  }

  int _rowCountAtSection(int section) {
    if (section == 0) {
      return 3;
    } else {
      return 10;
    }
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
                  image: NetworkImage(
                      type==0?'https://imagev2.xmcdn.com/group47/M00/2B/E1/wKgKm1uEthTz13hxAAROx6fnPZ8302.jpg':
                      'http://imagev2.xmcdn.com/group50/M00/48/C5/wKgKmVvvmKCRMK-JAAF-6QUkwdE602.jpg'),
                )),
          ),
          title: Text(
            type==0?'偷得半生闲':"锎总今日说",
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
                  type==0?'这声音怎么找不到当初听鬼吹灯的感觉':"锎总说要赚一个亿！！！",
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
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container();
                                },
//                            isScrollControlled: true,
                                shape: new BeveledRectangleBorder
                                    //修改底部圆角
                                    (
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        topRight: Radius.circular(3)),
                                    side: new BorderSide(
                                      style: BorderStyle.none,
                                    )),
                              );
                            })),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  // Section header widget builder.
  Widget _sectionHeaderBuilder(BuildContext context, int section) {
    return InkWell(
      onTap: () {
//        print('click section header. -> section:$section');
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16.0),
        color: Color.fromRGBO(220, 220, 220, 1),
        height: 40,
        child: Text(section==0?'热评':'全部评论'),
      ),
    );
  }

  // cell item widget builder.
  Widget _cellBuilder(BuildContext context, int section, int row) {
    return InkWell(
      onTap: () {
        print('click cell item. -> section:$section row:$row');
      },
      child: section ==0 ?_buildHotReviewList(0):_buildHotReviewList(1),
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
