import 'package:flutter/material.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/model/HomeVipCourse.dart';
import 'package:flutter_ui/model/HomeVipModel.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class HomeVipTabBarView extends StatefulWidget {
  final aguments;
  TabController tabController;

  ValueSetter<int> onclick;
  HomeVipTabBarView({this.aguments,this.onclick,this.tabController});

  @override
  _HomeVipTabBarViewState createState() => _HomeVipTabBarViewState();
}

class _HomeVipTabBarViewState extends State<HomeVipTabBarView>{

  @override
  Widget build(BuildContext context) {
    List list = widget.aguments['_vipList'];
    String tabName = widget.aguments['tabName'];
    if(tabName.endsWith('hot')) {
      return Store.connect<HomeVipModel>(builder: (context,vipmodel,child){
          return buildViews(list,0,vipmodel: vipmodel);
      });
    } else {
      return Store.connect<HomeVipCourseModel>(builder: (context,coursemodel,child){
          return buildViews(list,1,coursemodel: coursemodel);
      });
    }
  }

  Widget buildViews(List list,int type,{HomeVipModel vipmodel,
    HomeVipCourseModel  coursemodel}){
    int tabNo = type== 0? vipmodel.currIndex:coursemodel.currIndex;
    return TabBar(
      labelStyle: new TextStyle(fontSize: 12.0,color: Colors.white),
      unselectedLabelStyle: new TextStyle(fontSize: 12.0),
      unselectedLabelColor: Colors.black87,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.white,
      isScrollable: true,
      controller: widget.tabController,
      tabs: list.asMap().keys.map((item) {
        return Container(
          width: 60,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
            //设置四周边框
            gradient: tabNo==item
                ?LinearGradient
              (colors: [
              CommonUtils.ADColor('#575A69'),
              CommonUtils.ADColor('#3E404D'),
              CommonUtils.ADColor('#2B2A36'),
            ], begin: FractionalOffset(0,0), end: FractionalOffset(0,1)
            ):null,
            border: tabNo==item?null:Border.all(color:
            Colors.black87,width: 1),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Tab(
            text: list[item],
          ),
        );
      }).toList(),
      onTap: (index) {
        type == 0 ?vipmodel.setCurrIndexVip(index) : coursemodel.setCurrIndexVip(index);
        widget.onclick(index);
      },
    );
  }

}
