import 'package:flutter/material.dart';
import 'package:flutter_ui/otherpage/bottom_drag_widget.dart';
import 'package:flutter_ui/page/LisinterBuildHotReview.dart';
import 'package:flutter_ui/res/colors.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
import 'package:sticky_headers/sticky_headers.dart';
class LisinterBuildReviewContent extends StatefulWidget {
  final onTap;
  final ScrollController scrollController;
  final List listwidget;
  final int mPage;
  final bool allReview;
  LisinterBuildReviewContent({this.onTap, this.scrollController,
    this.listwidget,this.mPage,this.allReview});

  @override
  _LisinterBuildReviewContentState createState() => _LisinterBuildReviewContentState();
}

class _LisinterBuildReviewContentState extends State<LisinterBuildReviewContent> {
  @override
  Widget build(BuildContext context) {

    return OverscrollNotificationWidget(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new StickyHeader(
                header: new Container(
                  height: 38,
                  color: CommonUtils.ADColor('#F3F4F4'),
                  padding: new EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    widget.allReview?'热门评论 ':'当前回复',
                  ),
                ),
                content: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 10),
                  physics: new NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return widget.allReview ? LisinterBuildHotReview
                      (type: 0,showView: true,onTap: widget.onTap,): LisinterBuildHotReview(type: 0,);
                    //返回数据
                  },
                  itemCount: 3,
                ),
              ),
              new StickyHeader(
                header: new Container(
                  height: 38,
                  color: CommonUtils.ADColor('#F3F4F4'),
                  padding: new EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    widget.allReview?'全部评论 ':'全部回复',
                  ),
                ),
                content:
                Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 30),
                    physics: new NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if(index == widget.listwidget.length){ //最后一条数据
                        if(widget.mPage < 4){
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
                        return widget.allReview ? LisinterBuildHotReview(type: 1,showView: true,onTap: widget.onTap,):
                        LisinterBuildHotReview(type: 1,);
                      }
                    },
                    //分割线构造器
                    separatorBuilder: (context,index){
                      return new Divider(
                          indent: 70, color: MyColors.meBgColor
                          .withOpacity(0.5));
                    },
                    itemCount: widget.listwidget.length+1,
                  ),
                ),
              ),
            ],
          ),
          controller: widget.scrollController,
          physics: new ClampingScrollPhysics(),
        )
    );
  }
}
