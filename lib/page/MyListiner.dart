import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class MyListiner extends StatefulWidget {
  final anguments;
  MyListiner({this.anguments});

  @override
  _MyListinerState createState() => _MyListinerState();
}

class _MyListinerState extends State<MyListiner> with
    AutomaticKeepAliveClientMixin{

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
  List<String> _searchlist = ['雷电之神','雷光幻影','晓蕾雷','胸大丹'];
  List<List<Map>> data =[
    [
      {"id":'123','title':'重合排序'},
      {"id":'123','title':'最新更新'},
      {"id":'123','title':'播放最多'},
    ],
    [
      {"id":'123','title':'全部'},
      {"id":'123','title':'相声评书'},
      {"id":'123','title':'有声书'},
      {"id":'123','title':'情感生活'},
      {"id":'123','title':'其他'},
      {"id":'123','title':'历史'},
      {"id":'123','title':'人文'},
      {"id":'123','title':'天气'},
      {"id":'123','title':'模仿者'},
    ],
    [
      {"id":'123','title':'不限'},
      {"id":'123','title':'付费'},
      {"id":'123','title':'免费'},
    ],
  ];
  @override
  Widget build(BuildContext context) {
      return SafeArea(
        top: false,
        bottom: false,
        child: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              key: PageStorageKey<String>("123123"),
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                  NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    maxHeight: (data.length * 35).toDouble(),
                    minHeight: (data.length * 35).toDouble(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:Border(bottom:BorderSide(width: 1,color: Color
                            (0xffe5e5e5)),top:BorderSide(width: 1,color: Color
                            (0xffe5e5e5)) )
                      ) ,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: loadMenueList()
                      ),
                    ),
                  ),
                ),
                SliverList(delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
                    return _loadListView();
                },childCount: 1)
                )
              ],
            );
          },
        ),
      );
  }


  List<Widget> loadMenueList() {
      List <Widget> list = new List();
      for (int i = 0; i < data.length; i++) {
        list.add(
            Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: ListView.builder(
                      itemCount: 1,
                      physics: new NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: buidListTitle(data[i]),
                          ),
                        );
                      }),
                )
            )
        );
      }
    return list;
  }

  List<Widget> buidListTitle(List<Map> list){
    List<Widget> widgetlist = new List();
    for(int i=0; i< list.length; i++){
      widgetlist.add(
          Container(
              height: 20,
              margin: EdgeInsets.only(right: 10,top: i==0?0:5),
              child: i==0?Chip(
                  label: Text('${list[i]["title"]}',style: TextStyle
                    (fontSize: 14),),
                  padding: EdgeInsets.only(bottom: 12),
                  labelStyle: TextStyle(fontSize: 12,color: Colors.deepOrange)
              ):Text('${list[i]["title"]}',style: TextStyle(fontSize: 12,
                  color: Colors.black),)
          )
      );
    }
    return widgetlist;
  }


  Widget _loadListView(){
    return ListView.builder(
      physics: new NeverScrollableScrollPhysics(),
      itemCount: listViews["news"].length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context,int index){
        return _getListViewNews(index);
      },
    );
  }

  Widget _getListViewNews(int index){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Container(  //本地圆角图片
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(listViews['news'][index]['image']),
                  )
              ),
            ),
            title: Text(listViews['news'][index]['titile'],style: TextStyle(fontSize: 14),),
            subtitle: Text(listViews['news'][index]['subTitle'],style:
            TextStyle(fontSize: 10),),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10,right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Icon(Icons.play_circle_filled,size: 14,color:
                  Colors.orange,),
                ),
                SizedBox(width: 10,),
                Container(
                    child: Text('232万+',style: TextStyle(fontSize: 10),)
                ),
                SizedBox(width: 10,),
                Container(
                  child: Icon(Icons.add_alert,size: 14,color: Colors
                      .orange,),
                ),
                SizedBox(width: 10,),
                Container(
                    child: Text('20万+',style: TextStyle(fontSize: 10),)
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 80),
              child: new Divider(color: CommonUtils.ADColor("#ADADAD"),)
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}