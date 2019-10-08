import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';

class HomeSearchBarPage extends StatefulWidget {
  final  Map tabModel;
  final  int index;
  HomeSearchBarPage(this.tabModel,this.index);

  @override
  _HomeSearchBarPageState createState() => _HomeSearchBarPageState();
}

class _HomeSearchBarPageState extends State<HomeSearchBarPage> {
  @override
  Widget build(BuildContext context) {
    var sType = widget.tabModel["search_type"];
    if(sType == 2){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15),
            child:widget.index>0?Image.asset(widget
                .tabModel['search_title'][0],width: 20,height: 20,color: CommonUtils.ADColor('#ADADAD'),)
                :Icon(Icons.access_time,size:20,color:Colors.white,)
          ),
          SizedBox(width: 20),
          Container(
            child: widget.index>0?Image.asset(widget
                .tabModel['search_title'][1],width: 20,height: 20,color:
            CommonUtils.ADColor('#ADADAD'),)
                :Icon(Icons.menu,size:20,color:Colors.white,),
          ),
        ],
      );
    } else if(sType == 1){
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: CommonUtils.ADColor('#ADADAD')
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text(widget.tabModel['search_title'][0],style: TextStyle
                (fontSize: 12,
                  color: Colors
                  .white),),
            ),
            SizedBox(width: 5),
            Container(
              child: Text(widget.tabModel['search_title'][1],style: TextStyle
                (fontSize: 12,color: Colors.white),),
            ),
            SizedBox(width: 5),
            Container(
              child: Text('筛选',style: TextStyle(fontSize: 12,color: Colors
                  .white),),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
