
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class MyFindFollow extends StatefulWidget {
  @override
  _MyFindFollowState createState() => _MyFindFollowState();
}

class _MyFindFollowState extends State<MyFindFollow> with AutomaticKeepAliveClientMixin{

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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
