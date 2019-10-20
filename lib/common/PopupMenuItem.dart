import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;
/// 菜单item显示数据
class HJPopupMenuItemData {
  String title;
  dynamic value;
  HJPopupMenuItemData({this.title, this.value});
}

/// 下拉菜单容器
class HJPopupMenu extends StatefulWidget {
  final double left; //距离左边位置
  final double top; //距离上面位置
  final dynamic initialValue; //默认值
  final List<HJPopupMenuItemData> items; //
  final Function valueChanged;
  HJPopupMenu(
      {this.left, this.top, this.initialValue, this.items, this.valueChanged});

  @override
  _HJPopupMenuState createState() => _HJPopupMenuState();
}

class _HJPopupMenuState extends State<HJPopupMenu>
    with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin{
  dynamic currentSelectValue;
  Animation<double> animation;
  AnimationController controller;
  static const int ANMATION_DURATION = 250;
  static  double MENU_HEIGHT = 0;
  static  bool isClose = true;
  @override
  void initState() {
    currentSelectValue = widget.initialValue;
    MENU_HEIGHT = ( widget.items.length/4 * 50).toDouble();
    setupShowAnimation();
    super.initState();
  }

  // 设置开始动画
  void setupShowAnimation() {
    controller = new AnimationController(
        duration: const Duration(milliseconds: ANMATION_DURATION), vsync: this);
    animation = new Tween(begin: 0.0, end: MENU_HEIGHT).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  // 设置结束动画
  void setupStopAnimation(VoidCallback completeCallback) {
    controller = new AnimationController(
        duration: const Duration(milliseconds: ANMATION_DURATION), vsync: this);
    animation = new Tween(begin: MENU_HEIGHT, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.status == AnimationStatus.completed) {
            completeCallback();
          }
        });
      });
    controller.forward();
  }

  // 点击菜单选项
  void _menuItemClick(dynamic value) {
    setState(() {
      currentSelectValue = value;
      if (widget.valueChanged != null) {
        widget.valueChanged(currentSelectValue);
      }
      setupStopAnimation(() async {
        controller.reverse();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: GridView.builder(
              //禁用反弹效果 但可以滚动
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: widget.items.length,
                cacheExtent: 50,
                physics:  new NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 2/1
                ),
                itemBuilder: ((BuildContext context,int index){
                  return HJPopupMenuItem(
                      title: widget.items[index].title,
                      value: widget.items[index].value,
                      checked: currentSelectValue == widget.items[index].value,
                      tapOn: (value) {
                        _menuItemClick(value);
                      }
                  );
                })
            ),
          )
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
/// 菜单选项
class HJPopupMenuItem extends StatefulWidget {
  final String title;
  final dynamic value;
  final Function tapOn;
  final bool checked;

  HJPopupMenuItem(
      {@required this.title, @required this.value, this.tapOn, this.checked});
  @override
  _HJPopupMenuItemState createState() => _HJPopupMenuItemState();
}

class _HJPopupMenuItemState extends State<HJPopupMenuItem> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      child: Container(
        alignment: Alignment.center,
        width: 50,
        decoration: BoxDecoration(
            color: widget.checked?Colors.red:Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(3)
        ),
        child: new Text(widget.title,style: TextStyle(fontSize: 12,
            color: widget.checked?Colors.white:Colors.black),
          textAlign: TextAlign.center,),
      ),
      onTap: (){
        if (widget.tapOn != null) {
          widget.tapOn(widget.value);
        }
      },
    );
  }
}

// popup路由
class HJPopupMenuRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  HJPopupMenuRoute({@required this.child});

  @override
  Color get barrierColor => null;//背景色

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}