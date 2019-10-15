import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/page/SearchAppBar.dart';
import 'package:flutter_ui/model/planmodel.dart';
class HotSearch extends StatefulWidget {
  @override
  _HotSearchState createState() => _HotSearchState();
}

class _HotSearchState extends State<HotSearch> with AutomaticKeepAliveClientMixin{
  List hotList = [
    '有声的紫京','牛大宝','免费有声小说','多人小说剧','魔道祖师','红楼梦'
    ,'恐怖故事','鬼吹灯 | 平台签约主播',
    '百家讲坛 | 百家讲坛官方授权号','鬼故事','鬼谷子','三国演义 | 牛大师倾情演讲','我欲封天','天下霸唱','南派三叔','云天河 | 有声小说',
    '有声的紫京','有声的紫京',
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      primary: true, //即使内容不够高也可以滚动
      slivers: <Widget>[
         SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return getHotList(index,context);
          },childCount: 1)
       )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget getHotList(int index,BuildContext context){
    return  ListView.builder(
         itemCount: hotList.length,
         physics: new NeverScrollableScrollPhysics(),
         shrinkWrap: true,
         itemBuilder: (BuildContext context,int index){
          return GestureDetector(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child:  Container(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Text('${index+1}',style: TextStyle(color: getColors
                                (index),fontSize: 12),overflow: TextOverflow.ellipsis, )
                          )
                    ),
                    Expanded(
                      flex: 7,
                      child:  Container(
                        child: Text("${hotList[index]}",style: TextStyle(fontSize:
                        12),),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: index%3==0?Icon(Icons.arrow_drop_up,size: 24,color:
                          Colors.red,):Icon
                            (Icons
                              .arrow_drop_down,size: 24,color: Colors.green,),
                        )
                    )
                  ],
                ),
              ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:
                  (context){
                return SearchAppBar(augments:{"title":hotList[index],"type"
                    :2});
              })
              );
              Future.delayed(Duration(seconds: 1), (){ //延迟一秒1执行
                Store.value<PlanModel>(context,0).addList(hotList[index]);
              });
            },
          );
     });
  }

  Color getColors(int index){
    switch(index){
      case 0:
        return Colors.red;
        break;
      case 1:
        return Colors.orangeAccent;
        break;
      default:
        return Colors.black38;
        break;
    }
  }

}
