///
import 'package:flutter/material.dart';

class SearchClickIcon extends StatefulWidget {
  final augments;
  final Widget wid;
  final VoidCallback onClick;
  SearchClickIcon({this.augments,this.wid,this.onClick,});

  @override
  _SearchClickIconState createState() => _SearchClickIconState();
}

class _SearchClickIconState extends State<SearchClickIcon> {
  @override
  Widget build(BuildContext context) {
    var containerView; //返回视图
    if(widget.augments!=null){

    } else {
      containerView = new Container(
        child: GestureDetector(
          child: widget.wid,
          onTap: (){
            widget.onClick(); //执行回调函数
          },
        )
      );
    }
    return containerView;
  }
}
