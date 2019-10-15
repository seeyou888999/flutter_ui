import 'package:flutter/material.dart';
import 'package:flutter_ui/res/dimens.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class ListinerTabBar extends StatefulWidget {
  final List<Widget> list;
  final ValueSetter onTap;
  final int currIndex;
  final Color colors;
  final Color selectColors;
  ListinerTabBar({this.list,this.onTap,this.currIndex,this.colors,this.selectColors});

  @override
  _ListinerTabBarState createState() => _ListinerTabBarState();
}

class _ListinerTabBarState extends State<ListinerTabBar> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.colors,
        margin: EdgeInsets.only(top: Dimens.titleHeight),
        constraints: BoxConstraints.expand(height: 50),
        child: Row(
          children: _buildTabBar(),
        )
    );
  }
  
  List<Widget> _buildTabBar(){
    List<Widget> _buildList = new List();
    var forlist = widget.list;
    if(widget.list.length > 0){
      for(var i = 0; i < forlist.length; i ++){
        _buildList.add(
         Expanded(
             child:InkWell(
                child: Center(
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    decoration:  widget.currIndex==i?BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: widget.selectColors
                            )
                        )
                    ):null,
                    child: forlist[i],
                  ),
                ),
               onTap: (){
                 widget.onTap(i);
               },
            ),
          ),
        );
      }
    }
    return _buildList;
  }
  
  
}
