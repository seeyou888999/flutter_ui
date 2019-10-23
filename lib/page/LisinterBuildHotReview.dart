import 'package:flutter/material.dart';
import 'package:flutter_ui/res/colors.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class LisinterBuildHotReview extends StatefulWidget {
  final int type;
  final bool showView;
  final onTap;
  LisinterBuildHotReview({this.type,this.onTap,this.showView});

  @override
  _LisinterBuildHotReviewState createState() => _LisinterBuildHotReviewState();
}

class _LisinterBuildHotReviewState extends State<LisinterBuildHotReview> {
  //加载内容
  @override
  Widget build(BuildContext context) {
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
                  image: NetworkImage(widget.type == 0
                      ? 'https://imagev2.xmcdn.com/group47/M00/2B/E1/wKgKm1uEthTz13hxAAROx6fnPZ8302.jpg'
                      : 'http://imagev2.xmcdn.com/group50/M00/48/C5/wKgKmVvvmKCRMK-JAAF-6QUkwdE602.jpg'),
                )),
          ),
          title: Text(
            widget.type == 0 ? '偷得半生闲' : "锎总今日说",
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
                  widget.type == 0 ? '这声音怎么找不到当初听鬼吹灯的感觉' : "锎总说要赚一个亿！！！",
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
              widget.showView!=null?Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: CommonUtils.ADColor('#F6F6F7'),
                    borderRadius: BorderRadius.circular(2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: buildRColumn(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                            child: new Text('查看全部200条回复 >',style: TextStyle
                              (fontSize: 12,color: Colors.black),),
                            onTap: () async{
                                widget.onTap();
                            }
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ):Container(),
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
