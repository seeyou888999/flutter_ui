import 'package:flutter/material.dart';
import 'package:flutter_ui/model/FindModel.dart';
import 'package:flutter_ui/page/VideoPage.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class MyFindRecommond extends StatefulWidget {
  @override
  _MyFindRecommondState createState() => _MyFindRecommondState();
}

class _MyFindRecommondState extends State<MyFindRecommond> with AutomaticKeepAliveClientMixin{
  List _imgUrls = ['images/1.png','images/2.jpg','images/3.jpg','images/4'
      '.png','images/5.jpg'];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      primary: true,
      slivers: <Widget>[
          SliverList(delegate: new SliverChildBuilderDelegate(
                  (BuildContext context,int index){
                return loadListView();
              },
              childCount: 1
            )
          ),
          SliverList(delegate: new SliverChildBuilderDelegate(
                  (BuildContext context,int index){
                return loadRecommondListView();
              },
            childCount: 1 )
          )
      ],
    );
  }

  Widget loadListView(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10,bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10,top: 10),
            child: Text('热门话题'),
          ),
          SizedBox(height: 10,),
          Container(
            height: 100,
            child:  ListView.builder(
                shrinkWrap: true,
                primary: true,
                itemCount: _imgUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    height: 50,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                            spreadRadius: -10.0,
                            color: CommonUtils.ADColor('#ADADAD'),
                            offset: Offset(0.0,10.0),//阴影颜色
                            blurRadius: 4.0,//阴影大小
                          ),
                        ]
                    ),
                    child: ClipRRect(
                      borderRadius:BorderRadius.circular(4),
                      child: InkWell(
                        child: Image.asset(_imgUrls[index],fit:
                        BoxFit.cover),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget loadRecommondListView(){
      List<FindModel> list =  new FindModel().getFindModel();
    return   Container(
      color: CommonUtils.ADColor('#F1F2F2'),
      child: ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics:  new NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context,int index){
            return Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(list[index].userIcon)
                        )
                      ),
                    ),
                    title: Text(list[index].userName,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
                    subtitle: Text(list[index].userSubtitle,style:
                    TextStyle(fontSize: 12,color: CommonUtils.ADColor('#ADADAD')),),
                    trailing: Container(
                      padding: EdgeInsets.only(left: 40),
                      width: 130,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width:50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: new Border.all(width: 1.2,color:
                              CommonUtils.ADColor('#ADADAD')),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.add,size: 18,),
                                Text('关注',style: TextStyle(fontSize: 13,
                                    color: CommonUtils.ADColor('#ADADAD')),)
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: CommonUtils.ADColor('#F1F2F2')
                              ),
                            child: Icon(Icons.clear,color: CommonUtils
                                .ADColor('#ADADAD',),size: 15,),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(10),
                    child: Text(list[index].findContent,style: TextStyle
                      (fontSize: 14,fontWeight: FontWeight.w300),maxLines: 5, overflow: TextOverflow.ellipsis),
                  ),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: CommonUtils.ADColor('#F1F2F2'),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: VideoPage(),
                  ),
                  list[index].findQuanzi!=null?
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Text('来自圈子： ',style: TextStyle
                          (color: CommonUtils.ADColor('#ADADAD')),),
                        Text('${list[index].findQuanzi}',style: TextStyle
                          (color: Colors.lightBlue),),
                      ],
                    ),
                  ):Container(),
                  list[index].findTop!=null?
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: CommonUtils.ADColor('#CDCDCD')
                    ),
                    child: ListTile(
                      leading: ClipOval(
                        child: InkWell(
                          child: Image.network(list[index].userIcon,fit: BoxFit
                              .cover,width: 30,height: 30,),
                        ),
                      ),
                      title: Row(
                        children: <Widget>[
                             Expanded(
                               child:  Text(list[index].findTop.userName,style: TextStyle
                                 (fontSize: 12,fontWeight: FontWeight.w300),),
                             ),
                            Container(
                              child: Icon(Icons.thumb_up,color: CommonUtils
                                  .ADColor('#ADADAD',),size: 15,),
                            ),
                            Container(
                              child: Text('${list[index].findTop.userDianzhan}',style:
                              TextStyle(color:CommonUtils.ADColor('#ADADAD',)
                                ,fontSize: 12),),
                            ),
                        ],
                      ),
                      subtitle: Text(list[index].findTop.userContent,style:
                      TextStyle(fontSize: 12,color: CommonUtils.ADColor('#ADADAD')),),
                    ),
                  ):Container(),
                  Container(
                    padding: EdgeInsets.only(left: 10,
                        bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Chip(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              avatar: Icon(Icons.share,size:20,color: CommonUtils.ADColor
                                ('#ADADAD'),),
                              label: Text('${list[index].findFenxiang}'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Chip(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              avatar: Icon(Icons.comment,size:20,color:
                              CommonUtils
                                  .ADColor
                                ('#ADADAD'),),
                              label: Text('${list[index].findHuifu}'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Chip(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              avatar: Icon(Icons.thumb_up,size:20,color: CommonUtils.ADColor
                                ('#ADADAD'),),
                              label: Text('${list[index].findDianzhan}'),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}