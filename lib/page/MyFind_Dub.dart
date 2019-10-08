import 'package:flutter/material.dart';
import 'package:flutter_ui/model/FindModel.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class MyFindDub extends StatefulWidget {
  @override
  _MyFindDubState createState() => _MyFindDubState();
}

class _MyFindDubState extends State<MyFindDub> with AutomaticKeepAliveClientMixin{
  List _imgUrls = ['images/1.png','images/2.jpg','images/3.jpg','images/4'
      '.png','images/5.jpg'];
  List _netWorkImage = [
    'http://imagev2.xmcdn.com/group63/M06/6B/0D/wKgMaF0u0gXiM7eMAAO'
        '-DPWVpEY919.jpg',
    'http://imagev2.xmcdn.com/group50/M00/48/C5/wKgKmVvvmKCRMK-JAAF-6QUkwdE602.jpg',
    'http://imagev2.xmcdn.com/group52/M05/64/8D/wKgLcFw9mbaDiHvmAAW9wrlMPlU241.jpg',
    'http://imagev2.xmcdn.com/group56/M0B/9F/BF/wKgLgFyipRGBId2FAAHMl2Id15c856.jpg',
    'http://imagev2.xmcdn.com/group59/M0A/AE/A4/wKgLel0_6jSB96guAAQiVnZ8T6o580.jpg',
    'http://imagev2.xmcdn.com/group66/M03/72/CB/wKgMdV14SP7id-bGAAZGnMebqfA215.jpg',
  ];
  List  _newTitle = ['鬼吹灯之天罚','山海密藏','盗墓笔记之猴赛雷xxxxxxxxxx','老九门','仙逆之我欲封天','天启'
      '者'];
  List _titles = ['经典必听','每日必听','助眠解压','精品','爆炸旋律'];

  List<String> nameItems = <String>[
    '微信', '朋友圈', 'QQ', 'QQ空间', '微博', 'FaceBook', '邮件', '链接'
  ];
  List<String> urlItems = [
    'images/wechat.png','images/wechatpy.png','images/qq.png','images/qzone.png',
     'images/weibo.png','images/facebook.png','images/Mail.png','images/link'
        '.png'
  ];

  FindModel findModel = new FindModel();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      primary: true,
      slivers: <Widget>[
        SliverList(
            delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
          return loadListDub();
        },
        childCount: 1 )
        ),
        SliverList(delegate: new SliverChildBuilderDelegate(
                (BuildContext context,int index){
              return loadListView();
            },
            childCount: 1
           )
        ),
        SliverList(
            delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
              return loadListDub();
            },
              childCount: 1 )
        ),
        SliverList(
            delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
              return loadDubDaRen();
            },
                childCount: 1 )
        ),
        SliverList(
            delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
              return loadListDub();
            },
                childCount: 1 )
        ),
      ],
    );
  }

  Widget loadDubDaRen(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10,top: 10),
            child: Text('配音达人',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
          ),
          Container(
            height: 350,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3)
            ),
            child: ListView.builder(
                  shrinkWrap: true,
                  primary: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: findModel.getFindModel().length,
                  itemBuilder: (BuildContext context ,int index){
                  return loadListViewDaRen(index);
              }
            ),
          )
        ],
      )
    );
  }

  Widget loadListViewDaRen(int index){
      return Container(
        margin: EdgeInsets.only(left: 10,top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/timg.jpg')
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        width: 240,
        child: Column(
          children: <Widget>[
             ListTile(
               leading: Container(
                 decoration: BoxDecoration(
                   border: new Border.all(color: Colors.pink, width: 2),
                   gradient: RadialGradient(colors: [Color(0xCCCCCCC0),Color
                     (0xFF00FFFF)],radius: 1, tileMode:
                   TileMode.mirror)
                     ,//环形渲染
                   borderRadius: BorderRadius.circular(50),
                 ),
                  child: ClipOval(
                    child: Image.network('${findModel.getFindModel()[1].userIcon}',
                     width: 40,height: 40,)
                    ),
                ),
               title: Text(findModel.getFindModel()[1].userName,style: TextStyle
                 (fontSize: 16,fontWeight: FontWeight.w400),),
               subtitle: Text('点赞数：${findModel.getFindModel()[1]
                   .findDianzhan}',style: TextStyle(color: Colors.red,
                   fontSize: 12),),
               trailing: Container(
                 alignment: Alignment.center,
                 width: 50,
                 height: 30,
                 decoration: BoxDecoration(
                   color: Colors.pink, // 底色
                   borderRadius: BorderRadius.circular(50),
//                     borderRadius: new BorderRadius.only(topLeft: Radius
//                         .circular(50),bottomLeft: Radius.circular(50))// 半边圆
                 ),
                 child: Text('关注',style: TextStyle(color: Colors.white),),
               ),
             ),
            Container(
              child: Text('代表作品',style: TextStyle(fontSize: 12,color: CommonUtils.ADColor('#ADADAD')),),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(left: 10,right: 10),
              child: ListView.builder(
                  physics:  new NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(_netWorkImage[index])
                          )
                        ),
                      ),
                      title: Container(
                        child: Text(_newTitle[index],style: TextStyle
                          (fontSize: 14,fontWeight: FontWeight.w200,),
                          overflow: TextOverflow.ellipsis,),
                      ),
                      subtitle: Text(_titles[index],style: TextStyle
                        (fontSize: 12,fontWeight: FontWeight.w200,color:
                      CommonUtils.ADColor('#ADADAD')),),
                      trailing: Icon(Icons.keyboard_tab,size: 20,),
                    );
                  }
              ),
            )
          ],
        ),
      );
  }
  
  Widget loadListDub(){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 150,
            child: Text('123'),
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                ClipOval(
                          child: Image.network(findModel.getFindModel()[0].userIcon,fit:
                    BoxFit.cover,width: 20,height: 20,)
                  ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                    child: Text(findModel.getFindModel()[0].userName,
                  style: TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,)),
                Icon(Icons.supervisor_account,size: 20,),
                Expanded(
                  flex: 2,
                  child: Text('${findModel.getFindModel()[0]
                      .findDianzhan}人都在配音',style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,),
                ),
                Expanded(
                  child: GestureDetector(
                    child:  Container(
                      child: Icon(Icons.more_horiz,size: 30,),
                    ),
                    onTap: (){  //弹出分享页面 showModalBottomSheet 内容不限制高度,  打开一个半透明页面占据屏幕一半,点击空白消失
                      // showBottomSheet  Persistent不消失
                      showModalBottomSheet(context: context, builder:
                          (BuildContext context){
                        return  _buildButtomSheet(context);
                      },
                        shape: new BeveledRectangleBorder
                        //修改底部圆角
                          (borderRadius: BorderRadius.only(topLeft: Radius.circular(3),topRight: Radius.circular(3)),
                            side: new
                            BorderSide(
                              style: BorderStyle.none,)
                        ),
                      );
                    },
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtomSheet(BuildContext context){
    return new Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
      ),
      height: 250.0,
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: new Container(
              height: 190.0,
              child: new GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 1.0),
                itemBuilder: (BuildContext context, int index) {
                  return new Column(
                    children: <Widget>[
                      new Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                          child: new Image.asset( urlItems[index], width: 50.0, height: 50.0, fit: BoxFit.fill, ) ),
                      new Text(nameItems[index])
                    ],
                  );
                },
                itemCount: nameItems.length,
              ),
            ),
          ),
          new Container( height: 0.5, color: CommonUtils.ADColor('#ADADAD'), ),
          GestureDetector(
            child: new Center( child: new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                child: new Text( '取  消', style: new TextStyle(fontSize: 18.0,
                    color: Colors.black), ) ), ),
            onTap:(){
              Navigator.of(context).pop();
            },
          )

        ],
      ),
    );
  }

  Widget loadListView(){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10,top: 10),
            child: Text('精选合集',style: TextStyle(fontSize: 16,fontWeight:
            FontWeight.w300),),
          ),
          SizedBox(height: 10,),
          Container(
            height: 150,
            child:  ListView.builder(
                shrinkWrap: true,
                primary: true,
                itemCount: _imgUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints.tightFor(height: 100.0),
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                spreadRadius: -5.0,
                                color: CommonUtils.ADColor('#ADADAD'),
                                offset: Offset(0.0,2.0),//阴影颜色
                                blurRadius: 4.0,//阴影大小
                              ),
                            ]
                          ),
                          padding: EdgeInsets.only(bottom: 10),
                          child: ClipRRect(
                            borderRadius:BorderRadius.circular(4),
                            child: InkWell(
                              child: Image.asset(_imgUrls[index],fit:
                              BoxFit.cover),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10,right: 5),
                          child: Text(findModel.context[index],maxLines: 2,
                            overflow: TextOverflow.ellipsis,style: TextStyle
                              (fontSize: 14),),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}