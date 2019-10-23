import 'package:flutter/material.dart';
import 'package:flutter_ui/common/AudioPlayerManager.dart';
import 'package:flutter_ui/common/MyPainter.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/model/AudioPlayModel.dart';
import 'package:flutter_ui/page/LisinterPage.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FloationActionButton extends StatefulWidget {
  @override
  _FloationActionButtonState createState() => _FloationActionButtonState();
}

class _FloationActionButtonState extends State<FloationActionButton> with
    TickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  AnimationController controller;
  Animation _animation;
  AnimationController percentageAnimationController;
  Animation percentageAnimation;
  double fileDuration;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    print('---initState----');
//    if(AudioPlayerManager.audioPlayer!=null) {
      // TODO: implement initState
      controller = AnimationController(duration: const Duration(seconds: 20),
          vsync: this);
      _animation = Tween(begin: 0.0, end: 1.0).animate(controller);
      //画圆动画
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
            Store.value<AudioPlayModelNotifier>(context, 1).setValuePlay(newValue*100);
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
//    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('---注销---');
    controller?.dispose();
    percentageAnimationController?.dispose();
//    AudioPlayerManager.audioPlayer?.stop();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
      ),
      child: GestureDetector(
        child: Container(
          child: Store.connect<AudioPlayModelNotifier>(builder: (context,audio,child){
            fileDuration = AudioPlayerManager.fileDuration;
            if(mounted) {
              if(AudioPlayerManager.audioPlayer!=null && audio.isPlayState){
                startPlay();
              } else {
                stopPlay();
              }
            }
            return buildFloatButton(audio);
          }),
        ),
        onTap: (){
          if(!AudioPlayerManager.isPlay) AudioPlayerManager.isPlay = true;
          AudioPlayerManager.getPlayerIndex().then((v){
            if(v!=null){
              Navigator.push(context,
                  MaterialPageRoute(builder:(context){
                    return LisinterPage(aguments:{"playerIndex":v,"isPlay:":true});
                  })
              );
            }
          });
        },
      ),
    );
  }

  Widget buildFloatButton(AudioPlayModelNotifier audioplayer){
    return new Container(
        height: 100,
        width: 100,
        child:  new CustomPaint(
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
    );
  }

  void startPlay(){
    if(!controller.isAnimating){
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        controller?.forward(); //开启动画
        percentageAnimationController?.forward(); //开启画圆
      });
    }

  }

  void stopPlay(){
    if(controller != null) {
      controller?.stop();
      percentageAnimationController?.stop();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
