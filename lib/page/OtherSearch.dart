import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class OtherSearch extends StatefulWidget {
  final anguments;
  OtherSearch({this.anguments});

  @override
  _OtherSearchState createState() => _OtherSearchState();
}

class _OtherSearchState extends State<OtherSearch> with
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

  @override
  Widget build(BuildContext context) {
     return CustomScrollView(
       primary: true,
       shrinkWrap: true,
       slivers: <Widget>[
            SliverList(
               delegate:new SliverChildBuilderDelegate((BuildContext context,int index){
                 return _listViewMain();
               },childCount: 1)
           ),
           SliverList(
               delegate:new SliverChildBuilderDelegate((BuildContext context,int index){
                 return _otherSearch();
               },childCount: 1)
           ),
           SliverList(
               delegate:new SliverChildBuilderDelegate((BuildContext context,int index){
                 return _listViewMain();
               },childCount: 1)
           ),
       ],
     );
  }
  List<String> _searchlist = ['雷电之神','雷光幻影','晓蕾雷','胸大丹'];
  Widget _otherSearch(){
      return Container(
          color: CommonUtils.ADColor("#F1F2F2"),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Container(
                color: Colors.white,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child: Text('相关搜索',textAlign: TextAlign.left,),
              ),
              Container(
                color: Colors.white,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child:  Wrap(
                    spacing: 10.0,
                    runSpacing: 5.0,
                    children: loadLabel()
                ),
              ),
              SizedBox(height: 10,),
            ],
          ),
      );
  }
  List<Widget> loadLabel(){
    List<Widget> labelList = new List();
    if (_searchlist!=null && _searchlist.length>0){
      Iterable<Widget> listTitles =_searchlist.map((keyword){
        return Container(
          height: 20,
          child: Chip(
            label: Text(keyword),
            padding: EdgeInsets.only(bottom: 10),
            labelStyle: TextStyle(fontSize: 10,color: Colors.black),
          ),
        );
      });
      labelList = listTitles.toList();
    }
    return labelList;
  }

  Widget _listViewMain(){
    int type = widget.anguments["type"]==null?0:widget.anguments["type"];
    if(type!=0){
      return Container(
        child: Column(
          children: <Widget>[
            Container(height: 20),
            _loadCartView(),
            Container(height: 20),
            _loadListView()
          ],
        ),
      );
    } else {
      return _loadListView();
    }
  }
  Widget _loadCartView(){
      return Card(
          color: Colors.white,
          margin: EdgeInsets.only(left: 10,right: 10),
          elevation: 4,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3))
          ),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.network('http://imagev2.xmcdn'
                          '.com/group52/M0B/B6/39/wKgLe1w1axDBWOWJACwzpWA7pjI535.png'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Container(
                          child: Text('有声的紫荆',style: TextStyle(fontSize: 12,
                              fontWeight: FontWeight.w700),),
                        ),
                        Container(
                          height: 20,
                          margin: EdgeInsets.only(left: 10),
                          child: Chip(
                            padding: EdgeInsets.only(bottom: 10),
                            avatar: new Icon(Icons.mic,size: 16,color: Colors
                                .deepPurpleAccent.shade200,),
                            label: Text("VIP18",style: TextStyle(fontWeight:
                            FontWeight.w700,color: Colors.deepPurpleAccent
                                .shade200,fontSize: 12),),
                          ),
                        )
                      ],
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(Icons.live_tv,size: 14,),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('20+万',style: TextStyle(fontSize: 12),),
                        ),
                        Container(width: 20,),
                        Container(
                          child: Icon(Icons.supervisor_account, size: 18,),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('20+万',style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 20,
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: CommonUtils.ADColor('#F1F2F2'),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text('快来一起嗨,朋友们',style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: new Divider(color: CommonUtils.ADColor("#ADADAD"),)
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('TA的专辑',style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w600),),
                        ),
                      ),
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text('更多>>',style: TextStyle(fontSize: 12,
                                color: Colors.black45),),
                          )
                      ),
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      GridView.builder(
                        shrinkWrap: true,
                        physics: new NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2/3
                        ),
                        itemBuilder: (BuildContext context,int index){
                          return _getItemContainer(index);
                      },itemCount: _netWorkImage.length)
                    ],
                  )
                )
              ],
            ),
          ),
      );
  }
  Widget _getItemContainer(int index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            width: 90,
            height: 90,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white,
              image: new DecorationImage(
                image: new NetworkImage(_netWorkImage[index]),
                fit: BoxFit.cover,
              ),
            )
        ),

        Container(
          margin: EdgeInsets.only(left: 10,top: 10,bottom: 5),
          alignment: Alignment.center,
          child: Text(_newTitle[index],style: TextStyle(fontSize: 11),
            overflow:TextOverflow.ellipsis,),
        ),
        Container(
//          margin: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                child: Icon(Icons.local_library,size: 14,),
                margin: EdgeInsets.only(right: 10),
              ),
              Container(
                child: Text('212.8万',style: TextStyle(fontSize: 10,color: Colors.black12),),
              )
            ],
          ),
        )
      ],
    );
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
