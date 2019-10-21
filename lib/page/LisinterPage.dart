import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/common/AudioPlayerManager.dart';
import 'package:flutter_ui/common/RoundSliderTrackShape.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/model/AudioPlayModel.dart';
import 'package:flutter_ui/page/CustomShape.dart';
import 'package:flutter_ui/page/LisinterContentPage.dart';
import 'package:flutter_ui/page/ListinerTabBar.dart';
import 'package:flutter_ui/res/colors.dart';
import 'package:flutter_ui/res/dimens.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bubble/flutter_bubble.dart';
import 'package:flutter_bubble/bubble_widget.dart';

class LisinterPage extends StatefulWidget {
  final aguments;
  LisinterPage({this.aguments});
  @override
  _LisinterPageState createState() => _LisinterPageState();
}

class _LisinterPageState extends State<LisinterPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  SharedPreferences sharedPreferences;

//  AudioPlayer audioPlayer = new AudioPlayer();
  ScrollController _controller = new ScrollController();
  TabController tabController;
  Color _iconColor = Color.fromARGB(255, 255, 255, 255);
  Color _titleBgColor = Color.fromARGB(0, 255, 255, 255);
  Color _selectBgColor = Color.fromRGBO(0, 255,255,255);
  Color _barBgColor = Color.fromARGB(0, 255, 255, 255);
  Color _barTextBgColor = Color.fromARGB(0, 0, 0, 0);
  int currentIndex = 0;
  double _value = 0;
  StreamSubscription stream;
  StreamSubscription streamOver;
  StreamSubscription streamChange;
  double fileDuration = 1; // 歌曲时长
  double currenTime = 0; //当前几秒
  String songURL = ''; // 当前播放url
  bool isPlay = true; // 播放状态 默认未播放
  bool first = false; // 是否是首次点击播放按钮
  String songName = ''; //歌曲名
  String startTime = '00:00'; // 开始时间
  String endTime = '00:00'; // 结束时间
  int playModel = 0; // 播放模式: 0 列表 1单曲  2  随机
  int initPlayer = 0; //初始化播放
  bool isPlayer = true;
  bool isLoadPlayer = true;
  int _tabIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
    _controller.addListener(() {
      tabListener(_controller);
    });
    //调用播放器单例

//    if(AudioPlayerManager.audioPlayer ==null){  //第一次加载
//      print("----创建audioPlayerManager------");
//      new AudioPlayerManager(context);
//      stream = audioPlayPositionChange();
//      streamChange = audioPlayStartChanged();
//      streamOver = listenPlayer();
//    } else {
//      stream = audioPlayPositionChange();
//      streamChange = audioPlayStartChanged();
//    }
//    currentIndex = widget.aguments['playerIndex'];
//    AudioPlayerManager.getPlayerIndex().then((value){  //是否加载播放数据
//       if(currentIndex!=value){
//          AudioPlayerManager.getVideoData(widget.aguments);
//       } else if(AudioPlayerManager.isOnePlay){
//         AudioPlayerManager.getVideoData(widget.aguments);
//         AudioPlayerManager.isOnePlay = false;
//       } else {
//          if(AudioPlayerManager.isPlayer){
//              AudioPlayerManager.audioPlayer.resume();
//          } else {
//            isLoadPlayer = false;
//          }
//       }
//    });
  }

  StreamSubscription audioPlayStartChanged(){
    return AudioPlayerManager.onPlayerStateChanged((AudioPlayerState s){
      if(s==AudioPlayerState.PLAYING){
        setState(() {
          isLoadPlayer = false;
          currentIndex = AudioPlayerManager.currentIndex;
        });
      }
    });
  }

  StreamSubscription audioPlayPositionChange(){
    return AudioPlayerManager.onAudioPositionChanged((p){ //播放器发生变化直接挂在
      if(mounted){ //显示进度条
        String time = p.toString();
        String newTime = time.substring(2, 7);
        // 计算当前几秒
        double currenTime = p.inSeconds.toDouble();
        var newValue = currenTime / AudioPlayerManager.fileDuration;
        setState(() {
          currenTime = currenTime;
          startTime = newTime;
          _value = newValue;
        });
      }
    });
  }

  StreamSubscription  listenPlayer (){
     return AudioPlayerManager.onPlayerCompletionStream((event){ //播放一首就关闭流再开启流
        var currIndex = AudioPlayerManager.onPlayerCompletion();//完成播放进入切换播放
        if(mounted){  //不在当前页面的话
          print("---播放完成--${currIndex}--");
          setState(() {
            currentIndex = currIndex;
          });
        }
      });
  }

  void tabListener(ScrollController _controller){
    if (_controller.offset <= 100) {
      setState(() {
        double num = (1 - _controller.offset / 170) * 255;
        _iconColor = Color.fromARGB(255, num.toInt(), num.toInt(), num.toInt());
        _titleBgColor = Color.fromARGB(255 - num.toInt(), 255, 255, 255);
      });
    } else if(_controller.offset >= 310){
        setState(() {
          _barBgColor = Color.fromARGB(255, 255, 255, 255);
          _selectBgColor = Color.fromRGBO(255, 0xEE6911,0xEE6911,0xEE6911);
          _barTextBgColor = Color.fromARGB(255, 0xADADAD, 0xADADAD, 0xADADAD);
        });
    } else {
      setState(() {
        _barBgColor = Color.fromARGB(0, 255, 255, 255);
        _selectBgColor = Color.fromRGBO(0, 255,255,255);
        _barTextBgColor = Color.fromARGB(0, 0, 0, 0);
        _iconColor = Color.fromARGB(255, 0, 0, 0);
        _titleBgColor = Color.fromARGB(255, 255, 255, 255);
      });
    }
  }
  void  closeStream(){
    if (streamOver !=null){
      streamOver.cancel();
      streamOver = listenPlayer();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    stream?.cancel(); //销毁把播放流注销
    streamChange?.cancel();
    //streamOver.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: loadView(),
      ),
    );
  }

  Widget loadView(){
    return Stack(
      children: <Widget>[
        contentView(),
        ListinerTabBar(
          selectColors: _selectBgColor,
          colors: _barBgColor,
          list: [
            new Text("详情",style: TextStyle(fontSize: 16,fontWeight: FontWeight
                .w300,color: _barTextBgColor),),
            new Text("主播",style: TextStyle(fontSize: 16,fontWeight: FontWeight
            .w300,color: _barTextBgColor),),
            new Text("评论",style: TextStyle(fontSize: 16,fontWeight: FontWeight
                .w300,color: _barTextBgColor),),
          ],
          onTap: (index){
            setState(() {
              _tabIndex = index;
            });
            index==0?
            _controller.animateTo(170, duration: Duration(milliseconds: 500)
                , curve: Curves.fastOutSlowIn):
            index==1?_controller.animateTo(980, duration: Duration
              (milliseconds: 500)
                , curve: Curves.fastOutSlowIn):_controller.animateTo(1350,
                duration: Duration(milliseconds: 500)
                , curve: Curves.fastOutSlowIn);
          },
          currIndex: _tabIndex,
        ),
        titleView(),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            constraints: BoxConstraints.expand(height: Dimens.titleHeight),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: buildTextField(),
                    margin: EdgeInsets.only(left: 10,right: 10),
                    height:  Dimens.titleHeight-15,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.mode_comment,size: 20,color: Colors.grey,),
                      new Text('1123',style: TextStyle(fontSize: 10,color:
                      Colors.grey),),
                    ],
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite_border,size: 20,color: Colors.grey,),
                      new Text('1123',style: TextStyle(fontSize: 10,color:
                      Colors.grey),),
                    ],
                  ),
                ),
                SizedBox(width: 10,),
              ],
            ),
          )
        )
      ],
    );
  }

  Widget buildTextField() {
    return  TextFormField(
        style: TextStyle(fontSize: 13),
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        onChanged: (value){

        },
        decoration: InputDecoration(
            hintText:'我猜测,此刻你可能有话想说',
            hintStyle: TextStyle(fontSize: 14,color: CommonUtils.ADColor('#999999')),
            contentPadding: EdgeInsets.only(top: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(70)),
            ),
            filled: true,
            fillColor: CommonUtils.ADColor('#EFF1F4'),
            enabledBorder: UnderlineInputBorder(  //设置boder边框色
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
            prefixIcon:  Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.create,color: CommonUtils.ADColor
                    ("#CCCCCC"),size: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    width: 20,
                    height: 3,
                  )
                ],
              ),
            ),
        )
    );
  }

  Widget titleView() {
    return Container(
      color: _titleBgColor,
      constraints: BoxConstraints.expand(height: Dimens.titleHeight),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              left: 0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Store.value<AudioPlayModelNotifier>(context, 1).setIsPlayState(true);
                    Navigator.pop(context);
//                    ToastUtil.dissmiss();
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        Dimens.leftMargin, 0, Dimens.rightMargin, 0),
                    child: Image.asset(
                      'images/icon_title_back.png',
                      color: _iconColor,
                      width: 20,
                      height: Dimens.titleHeight,
                    ),
                  ),
                ),
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isPlay?Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/player.gif'),
                    )
                ):Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('images/player.png',width: 20,height:
                  20,color: Colors.white,),
                ),
              SizedBox(width: 10,),
              new Text('播放中....',style: TextStyle(color: _iconColor),)
            ],
          ),
          Positioned(
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      Dimens.leftMargin, 0, Dimens.rightMargin, 0),
                  child: Image.asset(
                    'images/icon_share.png',
                    color: _iconColor,
                    width: 18,
                    height: Dimens.titleHeight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentView() {
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
            _coverView(),
            LinsterContent()
          ]
      ),
    );
  }

  Widget _coverView(){
      return Container(
        color: MyColors.coverBgColor,
        padding:
        EdgeInsets.fromLTRB(0, 48, 0, 20),
        child: Column(
          children: <Widget>[
            Container(
              alignment:Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: new Text('极品透视保镖-005(免费章节每天晚上七点我听直播间现场直播~)',style:
              TextStyle(fontSize: 16,color: MyColors.white),textAlign: TextAlign.center,),
            ),
            Container(
              height: 140,
              width: 140,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                        spreadRadius: 1,
                        offset: Offset(0, -1),
                        color: CommonUtils.ADColor('#ADADAD'),
                        blurRadius: 2
                    )
                  ],
                  borderRadius: BorderRadius.circular(2),
                  image: DecorationImage(
                      image: NetworkImage('https://imagev2.xmcdn.com/group47/M00/2B/E1/wKgKm1uEthTz13hxAAROx6fnPZ8302.jpg')
                  )
              ),
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Image.asset('images/bubble.png',color: Colors
                        .white,width: 20,height: 20,),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset('images/wifi.png',color: Colors
                            .white,width: 18,height: 18,),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        child: Image.asset('images/player_list.png',color: Colors
                            .white,width: 20,height: 20,),
                      )
                    ],
                  )
                ],
              ),
            ),
            _progressWidget(),
            _controBtnsWidget()
          ],
        ),
      );
  }

  Widget _controBtnsWidget() {
    playModel = AudioPlayerManager.playModel;
    var playBtn = playModel == 0
        ? 'images/circulation.png'
        : playModel == 1
        ? 'images/single.png'
        : 'images/random.png';
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            onTap: () {
              if (playModel == 2) {
                AudioPlayerManager.playModel = 0;
                setState(() {
                  playModel = 0;
                });
              } else {
                AudioPlayerManager.playModel += 1;
                setState(() {
                  playModel+=1;
                });
              }
            },
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    playBtn,
                    fit: BoxFit.fill,
                    width: 30,
                  ),
                ),
                Container(
                  child: new Text(AudioPlayerManager.playModel == 0?"顺序播放":AudioPlayerManager.playModel ==
                      1?"单一循环":"随机播放",
                    style: TextStyle(color: MyColors.white,fontSize: 12),),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () { //上一集
              AudioPlayerManager.isPlay = true;
              AudioPlayerManager.first = false;
              setState(() {
                isPlay = true;
                first  = false;
                isLoadPlayer  = true;
              });
              if (playModel == 2) {
                AudioPlayerManager.circulationPlay();
              } else {
                // 如果第一首,就播放第后一首
                if (currentIndex == 0) {
                  setState(() {
                     currentIndex = AudioPlayerManager.listmodel.songList.length - 1;
                  });
                  AudioPlayerManager.currentIndex =
                      AudioPlayerManager.listmodel.songList.length - 1;
                  AudioPlayerManager.initPlayer = AudioPlayerManager
                      .currentIndex;
                  AudioPlayerManager.play(AudioPlayerManager.currentIndex);
                } else {
                  setState(() {
                    currentIndex -=1;
                  });
                  AudioPlayerManager.currentIndex -= 1;
                  AudioPlayerManager.initPlayer -=1;
                  AudioPlayerManager.play(AudioPlayerManager.currentIndex);
                }
              }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Image.asset('images/previous.png',
                  fit: BoxFit.fill, width: 30),
            )
          ),

          InkWell(//播放暂停
            onTap: () {
              setState(() {
                isPlay = !isPlay;
                isLoadPlayer = true;
              });
              AudioPlayerManager.isPlay = !AudioPlayerManager.isPlay;
              if (isPlay == true && first == false) {
                AudioPlayerManager.audioPlayer.play(AudioPlayerManager.songURL);
                setState(() {
                  first = true;
                });
                AudioPlayerManager.first = true;
              }
              if (isPlay) {
                // 继续播放
                AudioPlayerManager.audioPlayer.resume();
              } else {
                // 暂停
                AudioPlayerManager.audioPlayer.pause();
              }
            },
            child: !isLoadPlayer?Container(
              margin: EdgeInsets.only(bottom: 10),
              child: isPlay
                  ? Image.asset('images/play.png',width: 30,height: 30,color:
              Colors.white,)
                  : Image.asset('images/player.png',width: 30,height: 30,color:
              Colors.white,),
            ):Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/player.gif'),
                )
            ),
          ),
          InkWell(//下一集
            onTap: () {
              setState(() {
                isLoadPlayer = true;
                isPlay = true;
                first = false;
              });
              AudioPlayerManager.isPlay = true;
              AudioPlayerManager.first = false;

              if (playModel == 2) {
                AudioPlayerManager.circulationPlay();
              } else {
                // 如果最后一首,就返回播放第一首
                if (currentIndex == AudioPlayerManager
                    .listmodel.songList
                    .length - 1) {
                  setState(() {
                    currentIndex=0;
                  });
                  AudioPlayerManager.currentIndex = 0;
                  AudioPlayerManager.play(AudioPlayerManager.currentIndex);
                  AudioPlayerManager.initPlayer=0;
                } else {
                  setState(() {
                    currentIndex +=1;
                  });
                  AudioPlayerManager.currentIndex += 1;
                  AudioPlayerManager.initPlayer +=1;
                  AudioPlayerManager.play(AudioPlayerManager.currentIndex);
                }
              }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Image.asset('images/next.png',
                  fit: BoxFit.fill, width: 30),
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return _songsListWidget();
//                    return Container();
                },
              );
            },
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'images/list.png',
                    fit: BoxFit.fill,
                    width: 30,
                  ),
                ),
                Container(
                  child: new Text('播放列表',
                    style: TextStyle(color: MyColors.white,fontSize: 12),),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _songsListWidget() {
    return Container(
      height: 500,
      child: ListView.builder(
        itemCount: AudioPlayerManager
            .listmodel.songList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              setState(() {
                first = false;
                isPlay = true;
                currentIndex = index;
                isLoadPlayer  = true;
              });
              AudioPlayerManager.currentIndex  = index;
              AudioPlayerManager.first = false;
              AudioPlayerManager.isPlay = true;
              AudioPlayerManager.play(AudioPlayerManager.currentIndex);
              Navigator.of(context).pop();  // 返回
            },
            child: ListTile(
              title: Text(
                AudioPlayerManager
                    .listmodel.songList[index].title,
                style: TextStyle(color: index == currentIndex ? Colors.red : Colors.black),
              ),
              leading: Icon(
                Icons.playlist_play,
                color: index == currentIndex ? Colors.red : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }

  //播放进度条
  Widget _progressWidget() {
    if(_value>1){
      _value = 0;
    }
    return Container(
        child: Row(
          children: <Widget>[
//            Text(startTime, style: TextStyle(color: Colors.white)),
            Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white, //进度条滑块左边颜色
                        inactiveTrackColor: Color(0xFF8D8E98), //进度条滑块右边颜色
                        trackShape: RoundSliderTrackShape(radius: 10),//进度条形状,这边自定义两头显示圆角
                        overlayColor: Colors.transparent,
                        thumbColor: Colors.transparent,
                        thumbShape: CustomShape(),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 20.0,
                        ),
                        inactiveTickMarkColor: Colors.black,
                        trackHeight: 2 //进度条宽度
                    ),//进度条宽度
                  child: Slider(
                    value: _value,
                    label: "${startTime} / ${AudioPlayerManager.endTime}",
                    onChanged: (newValue) {
                      setState(() {
                        _value = newValue;
                      });
                      AudioPlayerManager.value = newValue;
                      // 进度 -> 秒数
                      int sec = (
                          newValue *
                              AudioPlayerManager.fileDuration).toInt();
                      AudioPlayerManager.audioPlayer.seek(new Duration
                        (seconds: sec));
                    },
                    onChangeStart: (startValue) {
                      print('onChangeStart:$startValue');
                    },
                    onChangeEnd: (endValue) {
                      print('onChangeEnd:$endValue');
                    },
                    semanticFormatterCallback: (newValue) {
                      return '${newValue.round()} dollars';
                    },
                  ),
                ),
            ),
//            Text(endTime, style: TextStyle(color: Colors.white)),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
