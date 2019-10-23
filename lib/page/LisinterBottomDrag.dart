import 'package:flutter/material.dart';
import 'package:flutter_ui/common/ToastShow.dart';
import 'package:flutter_ui/otherpage/bottom_drag_widget.dart';
import 'package:flutter_ui/page/LisinterBuildAllReview.dart';
import 'package:flutter_ui/page/LisinterReadDrag.dart';
import 'package:flutter_ui/res/dimens.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';

class LisinterBottomDrag extends StatefulWidget {
  final initPageView;
  final AnimationController offsetAnimationController;
  LisinterBottomDrag({this.offsetAnimationController,this.initPageView});

  @override
  _LisinterBottomDragState createState() => _LisinterBottomDragState();
}

class _LisinterBottomDragState extends State<LisinterBottomDrag> with
    TickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  double get screenH => MediaQuery.of(context).size.height;
  String topTitle = '';
  bool showTop = false;
  PageController pageController;
  AnimationController animationController;
  static String oneTopTitle ='';
  @override
  void initState() {
    animationController = AnimationController(duration: const Duration
      (milliseconds: 1000), vsync: this);
    pageController =  new PageController(initialPage: widget.initPageView);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.grey.withOpacity(0.5),
        child: BottomDragWidget(
          dragContainer: DragContainer(
            drawer: Container(
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.98),
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: Stack(
                children: <Widget>[
                   PageView(
                    physics: new NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 38),
                        child: LisinterBuildAllReview(pageController:
                          pageController,onTap:onTap,onUpdateTitle: onUpadteTitle,),
                        //加载全部评论
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 38),
                        child: LisinterReadDrag(onUpdateTitle: onUpadteTitle,), //查看个人回复评论
                      ),
                    ],
                  ),
                  _buildSheetTabBar(),
                ],
              ),
            ),
            defaultShowHeight: 0,
            height: screenH,
          ),
      )
    );
  }

  Widget _buildSheetTabBar() {
    return Container(
      height: Dimens.titleHeight,
      color: CommonUtils.ADColor('#F6F6F7'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 10,),
          showTop?InkWell(
            child: Container(
              alignment: Alignment.center,
              child: Icon(Icons.navigate_before,size: 30,color: Colors.black,),
            ),
            onTap: () => onTapPop(),
          ):Container(),
          Expanded(
            child: FadeTransition(
                opacity:animationController,
                child: Container(
                  alignment: Alignment.center,
                  child: new Text(
                    topTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ),
              ),
          ),
          InkWell(
            child: Container(
              child: Icon(
                Icons.close,
                color: Colors.black,
                size: 25,
              ),
            ),
            onTap: () =>pop(),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  void onTap() async {
    setState(() {
      showTop = !showTop;
    });
    pageController.animateToPage(1,
        duration: Duration
          (milliseconds: 500), curve:Curves.ease);
    animationController.reverse();
  }

  void onUpadteTitle(Map show){
    animationController.forward();
    if(show['showTitle']!=null) oneTopTitle = show['title'];
    setState(() {
      topTitle = show['title'];
    });
  }

  void onTapPop() async {
    pageController.animateToPage(0,
        duration: Duration
          (milliseconds: 500), curve:Curves.ease);
    setState(() {
      topTitle = oneTopTitle;
      showTop = !showTop;
    });
  }


  void pop() async{
    widget.offsetAnimationController.reverse();
    await Future.delayed(Duration(milliseconds: 300));
    ToastShow.removeToast();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
