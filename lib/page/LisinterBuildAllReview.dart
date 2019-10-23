import 'package:flutter/material.dart';
import 'package:flutter_ui/common/load_view.dart';
import 'package:flutter_ui/page/LisinterBuildReviewContent.dart';
class LisinterBuildAllReview extends StatefulWidget {
  final PageController pageController;
  final onTap;
  final onUpdateTitle;
  LisinterBuildAllReview({this.pageController,this.onTap,this.onUpdateTitle});

  @override
  _LisinterBuildAllReviewState createState() => _LisinterBuildAllReviewState();
}

class _LisinterBuildAllReviewState extends State<LisinterBuildAllReview> implements OnLoadReloadListener{
  LoadStatus _loadStatus = LoadStatus.LOADING;
  List listwidget = new List();
  ScrollController scrollController;
  int _mPage = 0;
  @override
  void initState() {
    getData();
    scrollController = new ScrollController()..addListener((){
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        //如果不是最后一页数据，则生成新的数据添加到list里面
        if(_mPage < 4){
          _retrieveData();
        }
      }
    });
    super.initState();
  }

  //初始化加载数据
  void getData() async {
    await Future.delayed(Duration(milliseconds: 500)).then((e){
      for (int i=0;i<6;i++){
        listwidget.insert(listwidget.length, "这是新加载的第${listwidget.length}条数据");
      }
    });
//    widget.onUpdateTitle('全部共 ${listwidget.length*(_mPage + 1)} 条评论');

    widget.onUpdateTitle({'title':'全部评论（200）条','showTitle':true});
    setState(() {
      _loadStatus = LoadStatus.SUCCESS;
    });
  }

  //上拉加载数据
  void _retrieveData() async {
    _mPage ++;
    await Future.delayed(Duration(milliseconds: 800)).then((e){
      for (int i=0;i<3;i++){
        listwidget.insert(listwidget.length, "这是上拉加载的第${listwidget.length}条数据");
      }
    });
    setState(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    if (_loadStatus == LoadStatus.LOADING) {
      return LoadingView();
    }
    if (_loadStatus == LoadStatus.FAILURE) {
      return FailureView(this);
    }
    return LisinterBuildReviewContent(
      onTap: widget.onTap,
      scrollController: scrollController,
      allReview: true,
      listwidget: listwidget,
      mPage: _mPage,
    );
  }
  @override
  void onReload() {
    getData();
    setState(() {
      _loadStatus = LoadStatus.LOADING;
    });
  }
}
