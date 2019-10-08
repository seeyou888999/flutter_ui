import 'package:flutter/material.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/page/SearchAppBar.dart';
import 'package:flutter_ui/model/planmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SearchMain extends StatefulWidget {
  final List<String> list;

  SearchMain({this.list});

  TabController _controller;
  @override
  _SearchMainState createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> with AutomaticKeepAliveClientMixin{
  List searchlist = [
    '有声的紫京','牛大宝','免费有声小说','多人小说剧','魔道祖师','红楼梦'
    ,'恐怖故事','鬼吹灯 | 平台签约主播',
    '百家讲坛 | 百家讲坛官方授权号','鬼故事','鬼谷子','三国演义 | 牛大师倾情演讲','我欲封天','天下霸唱','南派三叔','云天河 | 有声小说',
    '有声的紫京','有声的紫京',
  ];
  List<String> list = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
  save(String key,String mapValue) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    list = prefs.getStringList("keyword");
    list==null?list = new List():
    list.add(mapValue);
    print(list);
    prefs.setStringList(key, list.toSet().toList());
  }
  @override
  Widget build(BuildContext context) {
    print("SearchMain加载");
    return CustomScrollView(
      primary: true,
      shrinkWrap: true,
      slivers: <Widget>[
          Store.connect<PlanModel>(builder: (context,plan,child){
            return SliverList(
                delegate:new SliverChildBuilderDelegate((BuildContext context,int index){
                  return LoadGridSearch();
                },childCount: 1)
            );
          })

      ],
    );
  }
  
  Widget LoadGridSearch(){
    return
        GridView.count(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 5,
          children: getLoadSearch(),
        );

  }

  List<Widget> getLoadSearch(){
      List<Widget> list = new List();
      for(int i = 0; i< searchlist.length;i++){
        list.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(100)
                  )
              ),
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width/2.2,
                  padding: EdgeInsets.only(left: 10),
                  child: Text('${searchlist[i]}',style: TextStyle(color:
                  Colors.black,fontSize:
                  12),overflow: TextOverflow.ellipsis,maxLines: 1,),
                ),
                onTap: (){
                    var aguments = searchlist[i];
                    //添加缓存
                     Navigator.push(context, MaterialPageRoute(builder:
                         (context){
                          return SearchAppBar(augments:{"title":aguments});
                      })
                    );
                    Future.delayed(Duration(seconds: 1), (){ //延迟一秒1执行
                      Store.value<PlanModel>(context).addList(aguments);
                    });
                },
              )
            ],
          )
        );
      }
      return list;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
