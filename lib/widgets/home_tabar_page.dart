import 'package:flutter/material.dart';
import 'package:flutter_marquee/animation_direction.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_ui/common/FlutterMarquee.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/model/HomeTabBarModel.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class HomeTabrPage extends StatefulWidget {
  @override
  _HomeTabrPageState createState() => _HomeTabrPageState();
}

class _HomeTabrPageState extends State<HomeTabrPage> with
    SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  List _imgUrls = ['images/1.png','images/2.jpg','images/3.jpg','images/4'
      '.png','images/5.jpg'];
  List _imgUrl = ['images/6.png','images/7.png','images/8.png','images/9'
      '.png','images/10.png'];
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
  void initState() {
    super.initState();
  }

  List _titles = ['经典必听','每日必听','助眠解压','精品','爆炸旋律'];
  @override
  Widget build(BuildContext context) {
      return CustomScrollView(
        primary: true,
        shrinkWrap: true,
        slivers: <Widget>[
          Store.connect<HomeTabModel>(
              builder: (context, snapshot, child) {
                return SliverList(delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _getIconTitle(snapshot),
                      ],
                    ),
                  );
                },
                    childCount: 1
                ),);
          }),
          SliverList(delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
                return  _getGridList();
            },childCount: 1),
          ),
          SliverList(delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
            return  _getLoadNews();
             },childCount: 1),),
          SliverList(delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
            return  _CardPage();
          },childCount: 1),),
          SliverList(delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
            return  _listViewMain();
          },childCount: 1),),
          SliverList(delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
            return  _goodsPlay();
          },childCount: 1),),
          SliverList(delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
            return  _listViewMain();
          },childCount: 1),),
        ],
      );
  }

  Widget _goodsPlay(){
    return Container(
      color: Colors.white,
      child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 10,top: 10),
              child: Text('精品',style: TextStyle(fontSize: 14),),
            ),
            Container(
              height: 150,
              child: ListView.builder(
                  itemCount: listViews["news"].length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context,int index){
                    return _playPage(index);
                  }
              ),
            )
          ],
        )
    );
  }

  Widget _playPage(int index){
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.2),
        borderRadius: BorderRadius.circular(3)
      ),
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  width: 80,
                  height: 90,
                  child: Image.network(listViews['news'][index]['image'],fit:
                  BoxFit.cover)
              ),
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Image(
                    fit: BoxFit.cover,width: 30,height: 10,
                    image: new AssetImage('images/100.png'),
                  )
              ),
              Container(
                color: Color.fromRGBO(0, 0, 0, .12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      child: Icon(Icons.play_arrow,size: 20,color: Colors.orange,),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70,left: 5),
                      child: Text('2001.2万',style: TextStyle(fontSize: 10,color:
                      Colors.white70),overflow: TextOverflow.ellipsis,maxLines: 2,),
                    ),
                  ],
                )
              )

            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 3,right: 3),
            child:Text(listViews['news'][index]['titile'],style:
            TextStyle(fontSize: 10,color: Colors.white),textAlign: TextAlign
                .center,maxLines: 2,overflow: TextOverflow.ellipsis,),
          )
        ],
      )
    );
  }

  //获取加载ListView
  Widget _listViewMain(){
    return ListView.builder(
          physics: new NeverScrollableScrollPhysics(),
          itemCount: listViews["news"].length,
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          itemBuilder: (BuildContext context,int index){
            return _getListViewNews(index);
          },
      );
  }
  
  
  Widget _getListViewNews(int index){
      return Container(
          margin: EdgeInsets.only(top: 10,bottom: 10),
          decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: CommonUtils.ADColor("#F1F2F2"),//阴影颜色
              blurRadius: 3.0,//阴影大小
            ),
          ],
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
                margin: EdgeInsets.only(bottom: 10),
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
              )
            ],
          ),
      );
  }

  Widget _getIconTitle(HomeTabModel plan){
    return Stack(
      children: <Widget>[
         AspectRatio(
            aspectRatio: 4.0/1.0,
            child: Container(
              color: CommonUtils.ADColor(
                  plan.getIndex(plan.index)
              ),
            ),
          ),
          Container(
            height: 120,
            child: Swiper(
              itemCount:_imgUrls.length,
              controller:  SwiperController(),
              itemBuilder: (BuildContext context,int index){
                return
                  ClipRRect(
                    borderRadius:BorderRadius.circular(5),
                    child: InkWell(
                      child: Image.asset(_imgUrls[index],fit:
                      BoxFit.cover),
                    ),
                  );
              },
              viewportFraction: 0.97,
              scale: 0.97,
              autoplay: plan.boolPay,
              index:plan.index,
              pagination:  new SwiperPagination(
                  margin: EdgeInsets.only(top: 10),
                  builder: DotSwiperPaginationBuilder(
                    space: 3.0,
                    size: 5,
                    color: Colors.black54,
                    activeColor: Colors.white,
                  )
              ),
              onIndexChanged: (index){
                  plan.setIndex(index);
              },
            ),
          )
      ],
    );
  }

  Widget _CardPage(){
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(left: 10,right: 10),
      elevation: 3,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3))
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5,top: 10),
                  child: Icon(Icons.supervisor_account,size: 16),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5,top: 10),
                  child: Text('猜你喜欢',style: TextStyle(fontSize: 12),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 240,top: 10),
                  child: Icon(Icons.autorenew,size: 16,),
                )
              ],
            ),
          ),
           SizedBox(height: 2),
           Divider(height:5.0,indent:0.0,color: Colors.black26),
          _getGridViewList(),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Icon(Icons.autorenew,size: 14),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text('换一批',style: TextStyle(fontSize: 10),)
                  ),
                ],
              ),
          ),
        ],
      )
    );
  }

  //GridView.builder 构建视图
  Widget _getGridViewList(){
          return GridView.builder(
           shrinkWrap: true,
           physics: new NeverScrollableScrollPhysics(),
           itemCount: _netWorkImage.length,
           padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,//一行的Widget数量
                //纵轴间距
                mainAxisSpacing: 15.0,
               //横轴间距
                crossAxisSpacing: 20.0,
                childAspectRatio: 0.9, //如果不设置等比高度 当GridView里面得元素过多情况下,
             // 会导致高度不够, 比值越小宽度约高
           ),
           itemBuilder: (BuildContext context,int index){
              return _getItemContainer(index);
           }
       );
  }
  Widget _getGridList(){
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:_getPushList()
      ),
      color: Colors.white,
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
          alignment: Alignment.center,
          child: Text(_newTitle[index],style: TextStyle(fontSize: 11),
            overflow:TextOverflow.ellipsis,),
        )
      ],
    );
  }

  List<Widget> _getItems(){ //采用Gridview.count 加载widget 调用该方法返回List<Widget>
    return _netWorkImage.map((item)=>_getItemContainer(item)).toList();
  }

  List <Widget> _getPushList(){
    List<Widget> gridView = new List();
    for(var i=0;i<5;i++){
      gridView.add(
          Container(
            margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
            child:  Column(
              children: <Widget>[
                Container(
                    width: 32,
                    height: 32,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      image: new DecorationImage(
                        image: new ExactAssetImage(_imgUrl[i]),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                          offset: new Offset(0.0, 1.0),
                          blurRadius: 1.0,
                          color: const Color(0xffaaaaaa),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 5),
                Container(
                  child: Text(_titles[i],style: TextStyle(fontSize: 10),overflow:
                TextOverflow.ellipsis,),
                )
              ],
            ),
          )
      );
    }
    return gridView;
  }
  //获取当前头条推送FM
  Widget _getLoadNews(){
    return Container(
      margin: EdgeInsets.only(left: 20,top: 5),
      color: CommonUtils.ADColor("#F1F2F2"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                          offset: Offset(-10.0, 5.0),//偏移量，
                          color:  Colors.white,
                        )
                      ]
                  ),
                  height: 24,
                  margin: EdgeInsets.only(bottom: 10),
                ),
                Container(
                  margin: EdgeInsets.only(left:5,top: 8),
                  child: Icon(Icons.play_circle_filled,
                    size: 20,color:Colors.orange[300],),
                ),
                Store.connect<HomeTabModel>(builder: (context,plan,child){
                  return Container(
                    margin: EdgeInsets.only(right: 130,top:
                    12),
                    child: FlutterMarquee(
                      singleStart: plan.boolPay,
                      autoStart: plan.boolPay,
                      animationDirection: AnimationDirection.b2t,
                      children: <Widget>[
                        Text('大师兄,师傅被妖怪抓走了！！',
                          style: TextStyle(fontSize: 10),
                          overflow: TextOverflow
                              .ellipsis,),
                        Text('大师兄,师傅被妖怪抓走了！！',
                          style: TextStyle(fontSize: 10),
                          overflow: TextOverflow
                              .ellipsis,),
                        Text('大师兄,师傅被妖怪抓走了！！',
                          style: TextStyle(fontSize: 10),
                          overflow: TextOverflow
                              .ellipsis,),
                        Text('大师兄,师傅被妖怪抓走了！！',
                          style: TextStyle(fontSize: 10),
                          overflow: TextOverflow
                              .ellipsis,),
                        Text('大师兄,师傅被妖怪抓走了！！',
                          style: TextStyle(fontSize: 10),
                          overflow: TextOverflow
                              .ellipsis,),
                      ],
                      onChange: (index){

                      },
                    ),
                  );
                }),
                Container(
                  margin: EdgeInsets.only(left: 250,top:
                  10),
                  child: Text('私募听说',style: TextStyle
                    (fontSize: 12),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 300,top:
                  8),
                  child: Icon(Icons.arrow_forward,size: 18,
                      color:
                      Colors.orange),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}