import 'package:flutter/material.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';

class UserCenter extends StatefulWidget {
  @override
  _UserCenterState createState() => _UserCenterState();
}

class _UserCenterState extends State<UserCenter>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("用户中心");
    return Scaffold(
      backgroundColor: CommonUtils.ADColor('#F1F2F2'),
      appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Container(
              child: Stack(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 5.0),
                    child: new Icon(
                      Icons.mail,
                      size: 24,
                      color: CommonUtils.ADColor("#ADADAD"),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.deepOrange),
                    child: Text('15'),
                  )
                ],
              ),
            ),
            elevation: 0.0,
            actions: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                child: Image.asset('images/qr.png',
                    width: 18,
                    height: 18,
                    color: CommonUtils.ADColor("#ADADAD")),
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                child: Icon(Icons.settings,
                    size: 24, color: CommonUtils.ADColor("#ADADAD")),
              )
            ],
          ),
          preferredSize: Size.fromHeight(60)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return _buildUserInfo();
          }, childCount: 1),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildUserView();
                },
                childCount: 1)),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  if(index>MyCenter["center"].length){
                    return null;
                  }
                  return _buildUserList(MyCenter["center"][index+1]);
                },
                childCount: MyCenter["center"].length-1))
      ],
    );
  }

  Widget _buildUserView() {
    //EF8C79
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: GridView.count(
        physics:  new NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        shrinkWrap: true,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 5.0,
        children: _buildUserViewImage(),
      ),
    );
  }

  Widget _buildUserList(Map mapUser){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 20,top: 10),
            child: Text(mapUser['center_name'],style: TextStyle(fontSize:
            14,fontWeight: FontWeight.w500),),
          ),
          Container(
            child: GridView.builder(
                shrinkWrap: true,
                physics:  new NeverScrollableScrollPhysics(),
                itemCount: mapUser['center_list'].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 1.0
                ), itemBuilder: ((BuildContext context,int index){
                   return  _buildUserListItem(mapUser['center_list'][index]);
              })
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUserListItem(Map user){
      return Container (
          child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  child: Image.asset(user["l_img"],width: 30,height:
                  30,color: CommonUtils.ADColor('#787878'),),
                ),
                new Text(user["l_name"],style: TextStyle(fontSize: 12),)
              ]
          ),
      );
  }

  List<Widget> _buildUserViewImage() {
    List<Widget> list = new List();
    List myCenterMap = MyCenter["center"][0]["center_list"];
    for(int i=0;i <myCenterMap.length; i ++){
      list.add(
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: Image.asset(myCenterMap[i]["l_img"],width: 30,height:
              30,color: CommonUtils.ADColor('#EF8C79'),),
            ),
            new Text(myCenterMap[i]["l_name"],style: TextStyle(fontSize: 12),)
          ],
        )
      );
    }
    return list;
  }

  Widget _buildUserInfo() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.fromLTRB(10, 0.0, 10.0, 10),
                child: ClipOval(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: new Image.network(
                        'https://imagev2.xmcdn'
                        '.com/group61/M0A/7C/F3/wKgMZl0wBcnxgorbAABWZX_GLtM979.jpg!strip=1&quality=7&magick=jpg&op_type=5&upload_type=cover&name=web_large&device_type=ios',
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0, 10, 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text('听水友185613480'),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: CommonUtils.ADColor('#ADADAD'),
                                        width: 1))),
                            margin: EdgeInsets.only(right: 5, top: 10),
                            child: Text(
                              '粉丝  0  ',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: CommonUtils.ADColor('#ADADAD')),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5, top: 10),
                            child: Text(
                              '关注  0',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: CommonUtils.ADColor('#ADADAD')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0, 0.0, 50),
                child: Stack(
                  children: <Widget>[
                    Container(
                        child: Image.asset(
                      'images/grade.png',
                      color: Colors.blueAccent,
                      fit: BoxFit.cover,
                      width: 24,
                      height: 24,
                    )),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 20),
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              topRight: Radius.circular(3),
                              bottomRight: Radius.circular(3)),
                          // 半边圆
                          color: Colors.blueAccent),
                      child: Text(
                        '读书部',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0.0, 0.0, 40.0),
                  alignment: Alignment.center,
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.pink, // 底色
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50)) // 半边圆
                      ),
                  child: Text(
                    '+5 积分',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: CommonUtils.ADColor('#FCF4F1'),
            ),
            margin: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Image.asset('images/vip.png', width: 20, height: 20),
                ),
                Expanded(
                  flex: 2,
                  child:
                      new Text('VIP会员', style: TextStyle(color: Colors.brown)),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: <Widget>[
                      new Text(
                        'VIP首月仅6元',
                        style: TextStyle(color: Colors.brown),
                      ),
                      Icon(
                        Icons.navigate_next,
                        size: 20,
                        color: Colors.brown,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
