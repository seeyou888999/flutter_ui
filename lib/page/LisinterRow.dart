import 'package:flutter/material.dart';
import 'package:flutter_ui/common/global.dart';
class LisinterRow extends StatefulWidget {
  final ValueSetter onTap;
  final List<Widget> listRow;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;

  LisinterRow({this.onTap, this.listRow, this.padding, this.margin,
      this.mainAxisAlignment, this.crossAxisAlignment, this.textDirection});

  @override
  _LisinterRowState createState() => _LisinterRowState();
}

class _LisinterRowState extends State<LisinterRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.widget.padding,
      margin: this.widget.margin,
      child: Row(
        mainAxisAlignment: this.widget.mainAxisAlignment==null?MainAxisAlignment.start:
          this.widget.mainAxisAlignment,
        children: buildRow(),
      ),
    );
  }
  //
  List<Widget> buildRow(){
    print(this.widget.listRow.length);
    subSize = 2;
    double subPageTotal = (this.widget.listRow.length / subSize)
        + ((this.widget.listRow.length % subSize > 0) ?1 : 0);
    List<Widget> list = new List();
    for (var i = 0, len = subPageTotal - 1; i <= len; i++) {
      // 分页计算
      int fromIndex = i * subSize;
      int toIndex = ((i == len) ? this.widget.listRow.length : ((i + 1) * subSize));
      List strings = this.widget.listRow.sublist(fromIndex,toIndex);
      list.add(
        Row(
          crossAxisAlignment: this.widget.crossAxisAlignment,
          children: strings,
        )
      );
    }
    print(list);
    return list;
  }
}

