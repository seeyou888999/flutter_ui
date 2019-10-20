import 'package:flutter/material.dart';
import 'package:flutter_ui/common/PopupMenuItem.dart';
import 'package:flutter_ui/common/global.dart';
class LisinterBuildItem extends StatefulWidget {
  final ScrollPhysics physics;
  final int TYPE_INDEX;
  final ValueChanged valueChanged;

  LisinterBuildItem({this.physics, this.TYPE_INDEX, this.valueChanged});

  @override
  _LisinterBuildItemState createState() => _LisinterBuildItemState();
}

class _LisinterBuildItemState extends State<LisinterBuildItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        shrinkWrap: true,
        physics: widget.physics,
        children: <Widget>[
          buildItem(10)
        ],
      ),
    );
  }

  Widget buildItem(double offset){
    return HJPopupMenu(
      top: offset,
      initialValue: widget.TYPE_INDEX,
      items: TYPES.map((e) {
        return HJPopupMenuItemData(
            title: e['title'], value: e['value']);
      }).toList(),
      valueChanged: (value) {
//        setState(() {
//          TYPE_INDEX = value;
//          isshow = !isshow;
//          selectIndex = !isshow ? 0 : 1;
//        });
        widget.valueChanged(value);
      },
    );
  }
}
