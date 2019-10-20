import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;
import 'package:flutter_ui/common/PopupMenuItem.dart';
import 'package:flutter_ui/common/StickSlivers.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/res/colors.dart';
import 'package:flutter_ui/res/dimens.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
class LisinterPlayItem1 extends StatefulWidget {
  final String tabId;

  LisinterPlayItem1(this.tabId);

  @override
  _LisinterPlayItemState1 createState() => _LisinterPlayItemState1();
}

class _LisinterPlayItemState1 extends State<LisinterPlayItem1> with
    AutomaticKeepAliveClientMixin{
  EasyRefreshController  easyRefreshController;
  ScrollController _controller;
  int _listCount = 20;
  int  TYPE_INDEX = 0;
  @override
  void initState() {
    easyRefreshController = new EasyRefreshController();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }

  Widget loadListView(){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _listCount,
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context,int index){
      return Container(height: 20,color: Colors.white30,child: new Text('123'));
    });
  }

  Widget buildTabBar(){
    return Container(

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}