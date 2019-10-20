import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/model/HomeTabBarModel.dart';
import 'package:flutter_ui/page/HomeVipGridView.dart';
import 'package:flutter_ui/page/HomeVipTabBar.dart';

import 'package:flutter_ui/widgets/widget_utils.dart';
class HomeVip extends StatefulWidget {
  @override
  _HomeVipState createState() => _HomeVipState();
}

class _HomeVipState extends State<HomeVip> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin{
  List _imgUrls = ['images/1.png','images/2.jpg','images/3.jpg','images/4'
      '.png','images/5.jpg'];
  List hotList = [
    '推荐','悬疑小说','言情小说','都市小说','畅销书','幻想小说'
    ,'社科历史','商业管理',
    '其他有声小说',
  ];
  List vipList = [
    '推荐','明星专区','大咖书房','外语学习','艺术生活','财经商业'
    ,'亲子乐园','精品小课',
  ];
  List weekBooks = [
    '小说|虐心! 肖战x王一博还原穷奇道截击','评书|《聊斋》狐精青梅，如何麻雀变凤凰','读书|《钢琴教师》：最争议的经典虐恋',
   
    '穿搭|三位胸模演绎，用内衣显瘦的秘密','亲子|快来学古诗！米小圈教你读《咏鹅》',
  ];
  PageController mPageController = PageController(initialPage: 0);
  PageController mPageController1 = PageController(initialPage: 0);
  ScrollController scrollController = new ScrollController();

  TabController tabController;
  TabController tabController1;
  var isPageCanChanged1 = true;
  var isPageCanChanged = true;
  var ispageCanChangedIndex = 0;
  var ispageCanChangedIndex1 = 0;
  List<Widget> iconlist =[
    Icon(Icons.bookmark,size: 30,
      color:CommonUtils.ADColor('#F3D5B5'),),
    Icon(Icons.person_pin,size: 30,
      color:CommonUtils.ADColor('#F3D5B5'),),
    Icon(Icons.book,size: 30,
      color:CommonUtils.ADColor('#F3D5B5'),),
    Icon(Icons.volume_up,size: 30,
      color:CommonUtils.ADColor('#F3D5B5'),),
    Icon(Icons.vpn_key,size: 30,
      color:CommonUtils.ADColor('#F3D5B5'),),
    Icon(Icons.vpn_lock,size: 30,
      color:CommonUtils.ADColor('#F3D5B5'),),
    Icon(Icons.music_video,size: 30,
      color:CommonUtils.ADColor('#F3D5B5'),)
  ];
  List _vipList = [
    { 'title':'会员有声书',},
    {'title':'会员专栏',},
    { 'title':'我听讲书',},
    { 'title':'去声音广告',},
    { 'title':'专属抢先听',},
    { 'title':'福利折扣卷',},
    {  'title':'尊享标识',},
  ];
  //regin description
  @override
  Widget build(BuildContext context) {
    print("build-----");
   return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      slivers: <Widget>[
        SliverList(
          delegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
            return _getIconTitle();
          }, childCount: 1),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return _buildBody();
                },
                childCount: 1)),
      ],
    );
  }
  //endregion description
  //regin description
  //广告Swiper
  Widget _getIconTitle(){
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 4.0/1.0,
          child: Container(
            color: Colors.black
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
            autoplay: true,
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
              //plan.setIndex(index);
            },
          ),
        )
      ],
    );
  }
  //endregion description

  //加载内容页面
  Widget _buildBody() {
      return Container(
        color: CommonUtils.ADColor('#F1F2F2'),
        child: Column(
          children: <Widget>[
            _buildVipMore(),
            _CardPage(),
            _historyListiner(),
            _vipHot(),
            _vipCourse(),
            _buildVipToo(),
            _buildWeekBook(),
            _buildSellBook(),
          ],
        ),
      );
  }

  Widget _buildSellBook(){
    var item = (newTitle.length~/2).toInt();
    var it = newTitle.length;
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: CommonUtils.ADColor('#FCFDFC'),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(child: Text('10W+高赞故事大集合',),),
                  Container(child: Text('随便一个, 都是好故事',style: TextStyle
                    (fontSize:12,color: Colors.orange),),),
                ],
              ),
              trailing: Container(
                child: Chip(
                  backgroundColor: Colors.white,
                  labelPadding: EdgeInsets.only(left: 10),
                  label: Text('更多',style: TextStyle(fontSize: 12,
                      color: Colors.orange)),
                  deleteIcon: Icon(Icons.navigate_next,size: 15,color: Colors.orange,),
                  onDeleted: (){

                  },
                ),
              ),
            ),
            Container(
                height: 300,
//                width: MediaQuery.of(context).size.width-50,
                child: Swiper.children(
                    autoplay: false,
                    scrollDirection: Axis.horizontal,
                    children: _buildSellBookList()
                  )
            )
          ],
        )
    );
  }

  List<Widget> _buildSellBookList(){
    subSize = 2;
    double subPageTotal = (newTitle.length / subSize)
        + ((newTitle.length % subSize > 0) ?1 : 0);
    List<Widget> list = new List();
    for (var i = 0, len = subPageTotal - 1; i <= len; i++) {
      // 分页计算
      int fromIndex = i * subSize;
      int toIndex = ((i == len) ? newTitle.length : ((i + 1) * subSize));
      list.add(
        Column(
          children: <Widget>[
            _buildSellBookColumn(fromIndex),
            SizedBox(height: 10,),
            _buildSellBookColumn(toIndex-1)
          ],
        )
      );
    }
    return list;
  }

  Widget _buildSellBookColumn(int index){
   return  Container(
     margin: EdgeInsets.only(left: 20),
     child: Row(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
         Container(
           decoration: BoxDecoration(
               image: DecorationImage(
                   image: NetworkImage(netWorkImage[index]),
                   fit: BoxFit.fill
               ),
               borderRadius: BorderRadius.circular(5)
           ),
           width: 100,
           height: 100,
         ),
         Container(
           margin: EdgeInsets.only(left:10),
           height: 100,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Expanded(child: new Text(newTitle[index],style:
               TextStyle(fontSize: 16,fontWeight: FontWeight.w200),)),
               Expanded(child: new Text(newTitle[index],style:
               TextStyle(fontSize: 14,color: CommonUtils.ADColor('#9A9A9A')),)),
               Expanded(
                   child: Container(
                     child: Row(
                       children: <Widget>[
                         Container(child:Image.network
                           (netWorkImage[index],width: 10,height:
                         10,fit: BoxFit.fill,)),
                         Container(
                           child:  Text('中信书院',style: TextStyle(fontSize: 12,color: CommonUtils.ADColor('#9A9A9A')),),
                         ),
                       ],
                     ),
                     alignment: Alignment.bottomRight,
                   )
               )
             ],
           ),
         )
       ],
     ),
   );
  }

  Widget _buildWeekBook() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            spreadRadius: -1,
            color: CommonUtils.ADColor('#F6F6F6'),
            offset: Offset(6, 7.0),
            blurRadius: 1,
          ),

        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: new Text('精选周刊',style: TextStyle(fontSize: 18),),
            trailing: Container(
              child: Chip(
                  backgroundColor: CommonUtils.ADColor('#EABB8D'),
                  avatar: Icon(Icons.play_circle_filled,color:CommonUtils.ADColor('#F3D5B5'),),
                  label: Text('收听全部')
              ),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
                itemCount: weekBooks.length,
                itemExtent: 40.0,
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                      leading: Container(
                          decoration: BoxDecoration(
                            color: CommonUtils.ADColor('#E0E0E0'),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.play_arrow,size: 20,color: 
                          Colors.white,), 
                      ),
                    title: Text(weekBooks[index],style: TextStyle(color: 
                    CommonUtils.ADColor('#666666'),fontSize: 14),overflow:TextOverflow.ellipsis,),
                  );
              })
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 30,
              width: 100,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10,bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1,color: Colors.orange),
              ),
              child: Text('查看全部',style: TextStyle(color: Colors.orange),),
            ),
          )
        ],
      ),
    );
  }

  //构建vip7大特权
   Widget _buildVipToo() {
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildContainer(CommonUtils.ADColor('#F9F3EC'),EdgeInsets
                      .only(right: 5),3,15),
                  buildContainer(CommonUtils.ADColor('#F3D5B5'),EdgeInsets
                      .only(right: 10),3,20),
                  Container(
                    child: Text('会员专属特权',style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w400,color: Colors.orange),),
                  ),
                  buildContainer(CommonUtils.ADColor('#F9F3EC'),EdgeInsets
                      .only(left: 10),3,15),
                  buildContainer(CommonUtils.ADColor('#F3D5B5'),EdgeInsets
                      .only(left: 5),3,20),
                ],
              ),
            ),
           Container(
               margin: EdgeInsets.only(top: 10),
               height: 80,
               child: ListView.builder(
                   shrinkWrap: true,
                   padding: EdgeInsets.only(left: 10),
                   itemCount: _vipList.length,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (BuildContext context, int index){
                   Icon  icon = iconlist[index];
                     return Container(
                     padding: EdgeInsets.only(right: 20), //内部边距
                     child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                       Container(
                         child: icon,
                         decoration: BoxDecoration(
                         color: CommonUtils.ADColor('#FBF5EF'),
                         borderRadius: BorderRadius.circular(50)
                         ),
                       ),
                       Container(
                         child: new Text(_vipList[index]["title"],
                         style: TextStyle(fontWeight: FontWeight.w300,
                         fontSize: 12,
                         color: CommonUtils.ADColor('#9A9A9A')),),
                         margin: EdgeInsets.only(top: 10),
                       ),
                    ],
                   ),
                );
               })
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CommonUtils.ADColor('#EABB8D'),
                borderRadius: BorderRadius.circular(20),
              ),
              child: new Text('加入VIP, 尊享7大特权',style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w300),),
            )
          ],
        ),
      );
   }
   //重构Container斜线
   Widget buildContainer(Color color,EdgeInsets ed,double w,double h){
      return Container(
        margin: ed,
        constraints: BoxConstraints.tightFor(width: w, height: h),
        transform: Matrix4.rotationZ(.3),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)
        ),
      );
   }
  //regin description
  //vip 热门小说
  Widget _vipHot(){
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: CommonUtils.ADColor('#FCFDFC'),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(child: Text('VIP 热门有声书',),),
                  Container(child: Text('幻想悬疑都市言情, 热门小说统统都在这',style: TextStyle
                    (fontSize:12,color: Colors.orange),),),
                ],
              ),
              trailing: Container(
                child: Chip(
                  backgroundColor: Colors.white,
                  labelPadding: EdgeInsets.only(left: 10),
                  label: Text('更多',style: TextStyle(fontSize: 12,
                      color: Colors.orange)),
                  deleteIcon: Icon(Icons.navigate_next,size: 15,color: Colors.orange,),
                  onDeleted: (){

                  },
                ),
              ),
            ),
            _buildVipHotBar(),
            _buildVipHotTabbarView(),
          ],
        )
    );
  }
  //endregion description
  //切换PageView 视图
  //tabbar 点击切换PageView
  onPageChange(int index, PageController p, bool isPageCanChanged) async {
    if (p != null) {//判断是哪一个切换
      isPageCanChanged = false;
      await p.animateToPage(index, duration: Duration
        (milliseconds: 300), curve: Curves.ease);//等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    }
  }
  //初始化vip精选课程视图
  Widget _vipCourse(){
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: CommonUtils.ADColor('#FCFDFC'),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(child: Text('VIP 精选好课',),),
                  Container(child: Text('名家大师亲身授课, 帮你解锁新技能',style: TextStyle
                    (fontSize:12,color: Colors.orange),),),
                ],
              ),
              trailing: Container(
                child: Chip(
                  backgroundColor: Colors.white,
                  labelPadding: EdgeInsets.only(left: 10),
                  label: Text('更多',style: TextStyle(fontSize: 12,
                      color: Colors.orange)),
                  deleteIcon: Icon(Icons.navigate_next,size: 15,color: Colors.orange,),
                  onDeleted: (){

                  },
                ),
              ),
            ),
            _buildVipCourse(),
            _buildVipCourseView(),
          ],
        )
    );
  }
  //构建vip精选Tabbar
  Widget _buildVipCourse(){
    return HomeVipTabBarView(
      aguments: {"_vipList":vipList,"ispageCanChangedIndex"
          :ispageCanChangedIndex1,"tabName":"course"},
      tabController: tabController1,
      onclick: (index){
        onPageChange(index, mPageController1,isPageCanChanged1);
      },
    );
  }
  //构建Vip精选视图
  Widget _buildVipCourseView(){
    return Container(
      height: 380,
      child:  PageView.builder(
          controller: mPageController1,
          itemCount: vipList.length,
          physics: new NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            if (isPageCanChanged1) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,
              // 所以定义一个flag,控制pageview的回调
              onPageChange(index,mPageController1,isPageCanChanged1);
            }
          },
          itemBuilder: (BuildContext context, int index) {
            return HomeVipGridView({"index":index,"netWorkImage":netWorkImage
              ,"newTitle":newTitle1});
          }
      ),
    );
  }

  //构建Vip热门有书Tabbar
  Widget _buildVipHotBar(){
     return HomeVipTabBarView(
       aguments: {"_vipList":hotList,"ispageCanChangedIndex":
                  ispageCanChangedIndex,"tabName":"hot"},
       tabController: tabController,
       onclick: (index){
         onPageChange(index, mPageController,isPageCanChanged);
       },
     );
  }
  //构建Vip热门有书PageView视图
  Widget _buildVipHotTabbarView(){
    return Container(
      height: 380,
      child:  PageView.builder(
          controller: mPageController,
          itemCount: hotList.length,
          physics: new NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            if (isPageCanChanged) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
              onPageChange(index,mPageController,isPageCanChanged);
            }
          },
          itemBuilder: (BuildContext context, int index) {
            return HomeVipGridView({"index":index,"netWorkImage":netWorkImage
              ,"newTitle":newTitle});
          }
      ),
    );
  }
  
  //加载观看历史记录
  //regin description
  Widget _historyListiner(){ //读取最近听取的内容信息
    return Container(
        color: CommonUtils.ADColor('#F1F2F2'),
//        margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: ListTile(
                title: Container(child: Text('最近在听')),
                trailing: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Chip(
                    backgroundColor: Colors.white,
                    labelPadding: EdgeInsets.only(left: 10),
                    label: Text('更多',style: TextStyle(fontSize: 12,
                        color: Colors.orange)),
                    deleteIcon: Icon(Icons.navigate_next,size: 15,color: Colors.orange,),
                    onDeleted: (){

                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 140,
              child: ListView.builder(
                shrinkWrap: true,
                primary: true,
                itemCount: historyLinster.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                return Container(
                      width: 300,
                      margin: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                            spreadRadius: -1,
                            color: CommonUtils.ADColor('#9A9A9A'),
                            offset: Offset(0, 10.0),
                            blurRadius: 10.0,
                          )
                        ]
                      ),
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         ListTile(
                           leading: Image.network
                             (historyLinster[index]["h_url"],width: 40,
                             height: 40,),
                           title: new Text(historyLinster[index]["h_title"],
                             style: TextStyle(fontSize: 14,fontWeight:
                             FontWeight.w300),maxLines: 1,overflow: TextOverflow.ellipsis,),
                           subtitle: new Text
                             (historyLinster[index]["h_subtitle"],style:
                           TextStyle(fontSize: 12,color: CommonUtils.ADColor
                             ('#9A9A9A')),maxLines: 1,overflow: TextOverflow.ellipsis,),
                         ),
                         Container(
                           margin: EdgeInsets.only(left: 10,right: 10),
                           child: Row(
                             children: <Widget>[
                               historyLinster[index]["h_isover"]!=0?Text
                                 ('已更完 > ',style: TextStyle(fontSize: 12,color:
                               Colors.green),):Container(),
                               Expanded(
                                 child: Container(
                                   child: new Text('已收听至${historyLinster[index]["h_youlistine"]}集',style: TextStyle(fontSize: 12,color:
                                   CommonUtils.ADColor('#9A9A9A'))),
                                 ),
                               ),
                               Container(
                                 width:30,
                                 height:30,
                                 decoration: BoxDecoration(
                                     color: CommonUtils.ADColor('#9A9A9A'),
                                     borderRadius: BorderRadius.circular(50)
                                 ),
                                 child: Icon(Icons.play_arrow,size: 30,color: Colors.white,),
                               )
                             ],
                             mainAxisAlignment: MainAxisAlignment.start,
                             textDirection: TextDirection.ltr,
                           ),
                         )
                       ],
                     ),
                   );
              }),
            ),
          ],
        )
    );
  }
  //endregion description

  //regin description
  //加载会员vip权益
  Widget _buildVipMore(){
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            spreadRadius: -10,
            color: CommonUtils.ADColor('#9A9A9A'),
            offset: Offset(0, 10.0),
            blurRadius: 10.0,
          )
        ]
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    textDirection: TextDirection.ltr,
                    fit: StackFit.loose,
                    children: <Widget>[
                      Container(
                        child: ClipOval(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: new Image.network(
                                'https://imagev2.xmcdn'
                                    '.com/group61/M0A/7C/F3/wKgMZl0wBcnxgorbAABWZX_GLtM979.jpg!strip=1&quality=7&magick=jpg&op_type=5&upload_type=cover&name=web_large&device_type=ios',
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        top: 40,
                        child: ClipOval(
                          child: SizedBox(
                            width: 14,
                            height: 14,
                            child: Image.asset('images/vip.png', width: 18,
                            height: 18,fit: BoxFit.fill,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: new Text('加入VIP, 尊享7大特权',style: TextStyle(fontSize: 14,
                        color: CommonUtils.ADColor('#D7BDA6'),fontWeight:
                        FontWeight.w400),),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: CommonUtils.ADColor('#EEC299'),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: new Text('立即加入',style: TextStyle(fontSize: 16,
                      color: CommonUtils.ADColor('#ADADAD'),fontWeight:
                      FontWeight.w400),),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Divider(height: 2.0,indent: 5,color:Colors.orange,),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 80,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 10),
                itemCount: _vipList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  Icon  icon = iconlist[index];
                return Container(
                  padding: EdgeInsets.only(right: 20), //内部边距
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: icon,
                        decoration: BoxDecoration(
                            color: CommonUtils.ADColor('#FBF5EF'),
                            borderRadius: BorderRadius.circular(50)
                        ),
                      ),
                      Container(
                        child: new Text(_vipList[index]["title"],
                          style: TextStyle(fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: CommonUtils.ADColor('#9A9A9A')),),
                        margin: EdgeInsets.only(top: 10),
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
  //endregion description
  
  //regin description
  //猜你喜欢
  Widget _CardPage(){
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      decoration: BoxDecoration(
        color: CommonUtils.ADColor('#FCFDFC'),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              spreadRadius: -10,
              color: CommonUtils.ADColor('#9A9A9A'),
              offset: Offset(0, 10.0),
              blurRadius: 10.0,
            )
          ]
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(child: Text('猜你喜欢',),),
                Container(child: Text('听点喜欢听的',style: TextStyle(fontSize: 12,
                    color: Colors.orange),),),
              ],
            ),
            trailing: Container(
                child: Chip(
                    backgroundColor: Colors.white,
                    labelPadding: EdgeInsets.only(left: 10),
                    label: Text('更多',style: TextStyle(fontSize: 12,
                        color: Colors.orange)),
                    deleteIcon: Icon(Icons.navigate_next,size: 15,color: Colors.orange,),
                    onDeleted: (){

                    },
                ),
              ),
            ),
          _getGridViewList(),
        ],
      )
    );
  }
  //endregion description
  
  //regin description
  //GridView.builder 猜你喜欢构建视图
  Widget _getGridViewList(){
    return GridView.builder(
        primary: true,
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: netWorkImage.length,
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,//一行的Widget数量
          //纵轴间距
          mainAxisSpacing: 20.0,
          //横轴间距
          crossAxisSpacing: 2.0,
          childAspectRatio: 1/1.2, //如果不设置等比高度 当GridView里面得元素过多情况下,
          // 会导致高度不够, 比值越小宽度约高
        ),
        itemBuilder: (BuildContext context,int index){
          return _getItemContainer(index);
        }
    );
  }
  //endregion description

  //regin description  
  //猜你喜欢构建视图
  Widget _getItemContainer(int index){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          new BoxShadow(
            spreadRadius: -10,
            color: CommonUtils.ADColor('#9A9A9A'),
            offset: Offset(0, 10.0),
            blurRadius: 5.0,
          )
        ]
      ),
      child: Column(
        children: <Widget>[
          Container(
              height: 100,
              width: 100,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.white,
                image: new DecorationImage(
                  image: new NetworkImage(netWorkImage[index]),
                  fit: BoxFit.cover,
                ),
              )
          ),

          Container(
            alignment: Alignment.center,
            child: Text(newTitle[index],style: TextStyle(fontSize: 11),
              overflow:TextOverflow.ellipsis,),
          )
        ],
      ),
    );
  }
  //endregion description

  @override
  void initState() {
    // TODO: implement initState
    tabController = new TabController(length: hotList.length,vsync: this);
    tabController1 = new TabController(length: vipList.length,vsync: this);
    scrollController.addListener((){
      print("------------");
      //130
      if (scrollController.offset >= 120) {
        Store.value<HomeTabModel>(context,1).setIsScroll(1);
      } else if(scrollController.offset <= 10){
//        Store.value<HomeTabModel>(context)
        //更换AppBar 背景色 字体色, 以及暂停动画效果
        Store.value<HomeTabModel>(context,1).setIsScroll(0);
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    print("dispose");
    // TODO: implement dispose
    scrollController.dispose();
   tabController.dispose();
   tabController1.dispose();
    super.dispose();
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
