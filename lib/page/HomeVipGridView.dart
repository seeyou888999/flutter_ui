import 'package:flutter/material.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class HomeVipGridView extends StatefulWidget {
  final augments;
  HomeVipGridView(this.augments);

  @override
  _HomeVipGridViewState createState() => _HomeVipGridViewState();
}

class _HomeVipGridViewState extends State<HomeVipGridView> with AutomaticKeepAliveClientMixin{

  //定义数据或者加载数据
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        primary: true,
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: widget.augments["netWorkImage"].length,
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,//一行的Widget数量
          //纵轴间距
          mainAxisSpacing: 20.0,
          //横轴间距
          crossAxisSpacing: 2.0,
          childAspectRatio: 1/1.3, //如果不设置等比高度 当GridView里面得元素过多情况下,
          // 会导致高度不够, 比值越小宽度约高
        ),
        itemBuilder: (BuildContext context,int index){
          return _getItemContainer(index);
        }
    );
  }
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
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5,right: 5),
            child: Text(widget.augments["newTitle"][index],style: TextStyle
              (fontSize: 11),
              overflow:TextOverflow.ellipsis,maxLines: 2,),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
