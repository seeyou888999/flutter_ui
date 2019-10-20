import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/common/AudioPlayerManager.dart';
import 'package:flutter_ui/common/MyPainter.dart';
import 'package:flutter_ui/common/NoSplashFactory.dart';
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/common/provide_util.dart' show Store;
import 'package:flutter_ui/page/FindPage.dart';
import 'package:flutter_ui/page/LisinterPage.dart';
import 'package:flutter_ui/page/meheardpage.dart';
import 'package:flutter_ui/page/minepage.dart';
import 'package:flutter_ui/page/UserCenter.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/AudioPlayModel.dart';
import 'model/HomeTabBarModel.dart';

void main()  {
  runApp(MainPage());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Store.init(
      context: context,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '我听',
        theme: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashFactory: const NoSplashFactory(),
        ),
        home: Builder(builder: (context){
          Store.context = context;
           return MainHome();
        })
      )
    );
  }
}

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}



class _MainHomeState extends State<MainHome> with
    TickerProviderStateMixin<MainHome>,AutomaticKeepAliveClientMixin{

  AnimationController controller;
  Animation _animation;
  AnimationController percentageAnimationController;
  Animation percentageAnimation;
  double fileDuration;
  SharedPreferences sharedPreferences;
  final pageController = PageController();
  var _currIndex = 0;
  static var _tabIcons = [
    Icon(Icons.home,size: 30,),
    Icon(Icons.find_in_page,size: 30,),
    Icon(Icons.calendar_today,size: 20,color: Colors.transparent,),
    Icon(Icons.shopping_cart,size: 30,),
    Icon(Icons.account_box,size: 30,)
  ];
  final bodyList = [
    SafeArea(top:true,child: MinePage()),
    SafeArea(top:true,child: MeHeardPage()),
//    SafeArea(top:true,child: GradientDemo()),
    SafeArea(top:true,child: FindPage()),
    SafeArea(top:true,child: UserCenter())
  ];



  void onTap(int index) {
//    pageController.jumpToPage(index);
    //点击下面tabbar的时候执行动画跳转方法
    pageController.animateToPage(index, duration: new Duration(milliseconds:
    700),curve:new ElasticOutCurve(4));
    index == 0 ? Store.value<HomeTabModel>(context,1).stopPaly(true):
    Store.value<HomeTabModel>(context,1).stopPaly(false);
  }

  void onPageChanged(int index) {
    setState(() {
      _currIndex = index;
    });
  }
  final items = [
    BottomNavigationBarItem(icon: _tabIcons[0],title:getText(0)),
    BottomNavigationBarItem(icon: _tabIcons[1],title:getText(1)),
    BottomNavigationBarItem(icon: _tabIcons[3],title:getText(2)),
    BottomNavigationBarItem(icon: _tabIcons[4],title:getText(3)),
  ];

  static List _bottomBarTitles = ['首页','我听','发现','账号'];

  static Widget getText(int index){
    return Text(_bottomBarTitles[index],style: TextStyle(fontSize: 12),);
  }

//  void test(int index){
//    subSize = 2;
//    double subPageTotal = (newTitle.length / subSize)
//        + ((newTitle.length % subSize > 0) ?1 : 0);
//    List<Widget> list = new List();
//    int fromIndex = index-1 * subSize;
//    int toIndex = ((index == subPageTotal-1) ? newTitle.length : ((index +1)
//        * subSize));
//    for (var i = 0, len = subPageTotal - 1; i <= len; i++) {
//      // 分页计算
//      int fromIndex = i * subSize;
//      int toIndex = ((i == len) ? newTitle.length : ((i + 1) * subSize));
//
//      print('$fromIndex==${toIndex-1}');
//    }
//  }
  @override
  Widget build(BuildContext context) {
    //初始化加载
    return Scaffold(
        key: ObjectKey("MinePage"),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: bodyList,
          physics: NeverScrollableScrollPhysics(), // 禁止滑动
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          iconSize: 36,
          fixedColor: Colors.brown,
          currentIndex: _currIndex,
          onTap: onTap,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white
          ),
          child: GestureDetector(
              child: Container(
                child: Store.connect<AudioPlayModelNotifier>(builder: (context,audio,child){
                  fileDuration = AudioPlayerManager.fileDuration;
                  if(AudioPlayerManager.audioPlayer!=null && audio.isPlayState){
                    startPlay();
                  } else {
                    stopPlay();
                  }
                  return buildFloatButton(audio);
                }),
              ),
            onTap: (){
              if(!AudioPlayerManager.isPlay) AudioPlayerManager.isPlay = true;
              AudioPlayerManager.getPlayerIndex().then((v){
                Navigator.push(context,
                    MaterialPageRoute(builder:(context){
                      return LisinterPage(aguments:
                      {"playerIndex":v,"isPlay:"
                          "":true});
                      //跳转搜索页面
                    })
                );
              });
            },
           ),
        ),
      );
  }

  Widget buildFloatButton(AudioPlayModelNotifier audioplayer){
    return new Center(
        child: new Container(
//        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            height: 100.0,
            width: 100.0,
            child: new CustomPaint(
              foregroundPainter: new MyPainter(
                  lineColor: CommonUtils.ADColor('#E8E8E8'),
                  completeColor: CommonUtils.ADColor('#F76442'),
                  completePercent: audioplayer.value,
                  width: 3.0
              ),
              child:  new RotationTransition(
                  child: new Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage('https://imagev2.xmcdn'
                                  '.com/group47/M00/2B/E1/wKgKm1uEthTz13hxAAROx6fnPZ8302'
                                  '.jpg')
                          )
                      ),
                    ),
                  ),
                  turns: _animation
              ),
            )
        )
    );
  }

  void startPlay(){
    if(!controller.isAnimating){
      Future.delayed(Duration(seconds: 1)).then((value) {
        //移除
        controller.forward();
        percentageAnimationController.forward();
      });
    }

  }

  void stopPlay(){
    if(controller != null) {
      controller.stop();
      percentageAnimationController.stop();
    }
  }
  @override
  void initState() {
    print("----初始化---");
      super.initState();

      controller = AnimationController(duration: const Duration(seconds: 20),
          vsync: this);
      _animation = Tween(begin: 0.0, end: 1.0).animate(controller);
      //画原动画
      percentageAnimationController = new AnimationController(vsync: this,
          duration: new Duration(seconds: 1));
      percentageAnimation = Tween(begin: 0.0, end: 1.0).animate
        (percentageAnimationController);

      percentageAnimation..addStatusListener((status) async{
        AudioPlayerManager.onAudioPositionChanged((p){ //播放器发生变化直接挂在
          if(mounted){ //显示进度条
            String time = p.toString();
            // 计算当前几秒
            double currenTime = p.inSeconds.toDouble();
            currenTime = currenTime;
            var newValue = currenTime / AudioPlayerManager.fileDuration;
            Store.value<AudioPlayModelNotifier>(context, 1).setValuePlay
              (newValue*100);
          }
        });
      });

      _animation..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画从 controller.forward() 正向执行 结束时会回调此方法
          controller.reset();
          //开启
          controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          //动画从 controller.reverse() 反向执行 结束时会回调此方法
        } else if (status == AnimationStatus.forward) {
          //执行 controller.forward() 会回调此状态
        } else if (status == AnimationStatus.reverse) {
          //执行 controller.reverse() 会回调此状态
        }
      });
    }

  @override
  void dispose() {
    print("-------------");
    controller.dispose();
    percentageAnimationController.dispose();
    AudioPlayerManager.audioPlayer.stop();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}





