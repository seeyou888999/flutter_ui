import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_ui/common/real_rich_text.dart';
import 'package:flutter_ui/res/colors.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';

class LisinterPlayerValidity extends StatefulWidget {
  @override
  _LisinterPlayerValidityState createState() => _LisinterPlayerValidityState();
}

class _LisinterPlayerValidityState extends State<LisinterPlayerValidity> {
  List string = ['大大的赞','毫不犹豫就买了','非常感谢','超值推荐','干货满满','觉得买对了','喜欢听'];
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildContent(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: MyColors.textBlack9.withOpacity(0.5),
                        width: 1))),
            child: InkWell(
              child: new Text(
                '查看完整简介',
                style: TextStyle(
                    fontSize: 12, color: MyColors.textBlack9.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
              onTap: () {},
            ),
          ),
          Container(
            height: 14,
            color: MyColors.dividerColor,
          ),
          _buildGoMeView(),
          Container(
            height: 14,
            color: MyColors.dividerColor,
          ),
          _buildHotComment()
        ],
      ),
    );
  }

  Widget _buildHotComment() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('精彩评价 (100条)',style: TextStyle(fontSize: 16,color: Colors.black),),
                InkWell(
                  child: Row(
                    children: <Widget>[
                      Container(child: new Text('我要评价',style: TextStyle(fontSize: 14,color: Colors.orange),),),
                      Icon(Icons.navigate_next,size: 20,color: MyColors.textBlack9.withOpacity(0.5),)
                    ],
                  ),
                  onTap: (){},
                )
              ],
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  '探月',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                ),
                new Text(
                  '2019-09-10',
                  style: TextStyle(fontSize: 12, color: MyColors.textBlack9),
                ),
              ],
            ),
            subtitle:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(child: RatingBar(
                      initialRating: 10,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      glowColor: Colors.deepOrange,
                      unratedColor: Colors.grey,
                      itemSize: 10,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.deepOrange,
                      ),
                    ),),
                    new Text('10.0分',style: TextStyle(fontSize: 12,color: Colors.grey),)
                  ],
                ),
                InkWell(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.thumb_up,size: 15,color: MyColors.textBlack9,),
                      SizedBox(width: 5,),
                      new Text('32',style: TextStyle(fontSize: 12,color:
                      MyColors.textBlack9),)
                    ],
                  ),
                  onTap: (){},
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Wrap(
              verticalDirection: VerticalDirection.down,
              runSpacing: 10,
              spacing: 10,
              children: string.asMap().keys.map((v){
                return Container(
                  decoration: BoxDecoration(
                    color: CommonUtils.ADColor('#FFF4F1'),//CommonUtils.ADColor('#FFF4F1')
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 5,right: 5),
                    padding: EdgeInsets.all(5),
                    child: Text(string[v],style: TextStyle(fontSize: 14,color:
                    CommonUtils.ADColor('#E5B8AD')),textAlign: TextAlign.center,),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 10,right: 10),
            child: new Text('探月大老爷的书必须听,就算不好听也得听，不听也得听就是这么牛掰。。。你咋地。。打我啊！！',),
          ),
          SizedBox(height: 10,),
          Container(
            child: new Divider(color: MyColors.textBlack9.withOpacity(0.5),height: 1,),
          ),
          Container(
            height: 48,
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.3),
            child: new Text('查看更多评论'),
          )
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
              '已经被34.5万人关注',
              style: TextStyle(fontSize: 12, color: MyColors.textBlack6),
            ),
            trailing: Container(
              width: 70,
              height: 50,
              alignment: Alignment.bottomRight,
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.supervisor_account,
                    size: 20,
                    color: Colors.red,
                  ),
                  new Text(
                    '加关注',
                    style: TextStyle(fontSize: 10, color: Colors.red),
                  )
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    '关注探月朋友圈,许愿你喜欢的书和播音,一不小心就会实现啦,快来吧！小伙伴在召集你',
                    style: TextStyle(fontSize: 14),
                  ))),
        ],
      ),
    );
  }

  //内容简介
  Widget _buildContent() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(10),
      child: new RichText(
          text: TextSpan(
              text: '内容简介',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              children: [
            TextSpan(
              text: '【强烈推荐】',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            TextSpan(
              text: '一招不慎,走了穿越的老路子,...还是个已故的和尚??',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            ImageSpan(AssetImage('images/1000.png'),
                imageWidth: MediaQuery.of(context).size.width,
                imageHeight: 140),
            TextSpan(
              text: '内容简介',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            TextSpan(
              text: '白天他是个乞丐,晚上他是个和尚,行走在夜间的和尚,他到底是为了什么呢？',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ])),
    );
  }
}
