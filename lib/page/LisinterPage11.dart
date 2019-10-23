import 'dart:convert';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/common/RoundSliderTrackShape.dart';
import 'package:flutter_ui/common/provide_util.dart';
import 'package:flutter_ui/model/AudioPlayModel.dart';
import 'package:flutter_ui/model/audio_list_model.dart';
import 'package:flutter_ui/model/audio_paly_model.dart';
import 'package:flutter_ui/res/colors.dart';
import 'package:flutter_ui/res/dimens.dart';
import 'package:flutter_ui/service/service_method.dart';
import 'package:flutter_ui/widgets/widget_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LisinterPage1 extends StatefulWidget {
  final aguments;
  LisinterPage1({this.aguments});
  @override
  _LisinterPageState1 createState() => _LisinterPageState1();
}

class _LisinterPageState1 extends State<LisinterPage1> with
    TickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  SharedPreferences sharedPreferences;

  AudioPlayer audioPlayer = new AudioPlayer();
  ScrollController _controller = new ScrollController();
  TabController tabController;
  Color _iconColor = Color.fromARGB(255, 255, 255, 255);
  Color _titleBgColor = Color.fromARGB(0, 255, 255, 255);
  Color _titleTextColor = Color.fromARGB(0, 0, 0, 0);

  AudioPlayModel songModel; // 当前歌曲信息model
  AudioListmodel listmodel; // 所有歌曲model

  List songsResults = []; // 歌曲list数据数组
  String picPremium =
      'https://ww1.sinaimg.cn/large/0073sXn7ly1fze9706gdzj30ae0kqmyw'; // 背景图片, 先给一张图片,省的报警告
  double _value=0;
  int currentIndex = 0; // 当前第几首,默认加载第一首
  // 播放模式: 0 列表 1单曲  2  随机
  bool _isDividerGone = true;
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
  bool _isLoadPlayer = true;

  Future setPlayerIndex(int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('picPremium', 'https://imagev2.xmcdn.com/group47/M00/2B/E1/wKgKm1uEthTz13hxAAROx6fnPZ8302.jpg');
    prefs.setInt('playerIndex', index);
  }

  Future<int> getPlayerIndex() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('playerIndex');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(AudioPlayer.players.length>1){
      AudioPlayer.players.forEach((index,player){
        if(player.playerId != audioPlayer.playerId ){
          print("---${player.playerId}--${audioPlayer.playerId}--");
          player.stop();
        }
      });
    }

    tabController = new TabController(length: 3, vsync: this);
    _controller.addListener(() {
      tabListener(tabController);
    });
    // 播放完成
    audioPlayer.onPlayerCompletion.listen((event) {
      if(playModel == 0){ //列表播放
        if(initPlayer ==0){
          initPlayer+=1;
          currentIndex = initPlayer;
        } else {
          currentIndex += 1;
        }
        _play(currentIndex);
      } else if(playModel == 1){//单一循环
        print("单一循环${currentIndex}");
        if(initPlayer ==0){
          currentIndex = 0;
        }
        _singlePlay();
      } else {//随机播放
        print("随机播放${currentIndex}");
        _circulationPlay();
      }
    });

    // 时间变化
    audioPlayer.onAudioPositionChanged.listen((Duration p) {
      // print('Current position: $p');
      String time = p.toString();
      String newTime = time.substring(2, 7);
      // 计算当前几秒
      double currenTime = p.inSeconds.toDouble();
//       print('当前时间 == ${currenTime}');
//       print('总时间 == ${fileDuration}');
//       print(currenTime/fileDuration);
      if(mounted){ //mounted 挂在后在setState
        setState(() {
//        currenTime = currenTime;
//        startTime = newTime;
          _value = currenTime / fileDuration;
        });
      }
    });

    // 播放状态改变R
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      if(s==AudioPlayerState.PLAYING){
        Future.delayed(Duration(seconds: 2), (){ //延迟一秒1执行
          setState(() {
            _isLoadPlayer = !_isLoadPlayer;
          });
        });
      }
      print('Current player state: $s');
    });

    audioPlayer.onDurationChanged.listen((Duration d) {
//      print('Max duration: $d');
    });

    _getVideoData();
  }

  void tabListener(TabController _controller){
    if (_controller.offset <= 170) {
      setState(() {
        double num = (1 - _controller.offset / 170) * 255;
        _iconColor =
            Color.fromARGB(255, num.toInt(), num.toInt(), num.toInt());
        _titleBgColor = Color.fromARGB(255 - num.toInt(), 255, 255, 255);
        if (_controller.offset > 90) {
          _titleTextColor = Color.fromARGB(255 - num.toInt(), 0, 0, 0);
        } else {
          _titleTextColor = Color.fromARGB(0, 0, 0, 0);
        }
        if (_controller.offset > 160) {
          _isDividerGone = false;
        } else {
          _isDividerGone = true;
        }
      });
    } else {
      setState(() {
        _isDividerGone = false;
        _iconColor = Color.fromARGB(255, 0, 0, 0);
        _titleTextColor = Color.fromARGB(255, 0, 0, 0);
        _titleBgColor = Color.fromARGB(255, 255, 255, 255);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // 获取音频列表数据
  void _getVideoData() async {  //当进入该页面的时候加载（上下一集不触发）

    await get('audioList').then((val) {
      var data = json.decode(val.toString());
      listmodel = AudioListmodel.fromJson(data); // 赋值model
      songsResults.addAll(listmodel.songList);
      currentIndex = listmodel.songList.length - 1;
      // 默认加载第一首
      if(widget.aguments ==null){
        _play(initPlayer);
      } else {
        print("---正在加载播放第${widget.aguments["playerIndex"]}首---");
        if(widget.aguments!=null){
            _play(widget.aguments["playerIndex"]);
        } else {
           _play(getPlayerIndex());
        }
      }
    });
  }
  _formatTime(num time) {
    // 71s -> 01:11
    num min = (time / 60).floor();
    num second = time - min * 60;
    min = min >= 10 ? min : 0 + min;
    second = second >= 10 ? second : 0 + second;
    return min.toString() + ':' + second.toString();
  }
  // 播放歌曲
  _play(index) async {
    setState(() {
      _isLoadPlayer = true;
    });
    String songId = songsResults[index].songId.toString();
    String formdata = '&songid=' + songId;
    await get('audioInfo', formData: formdata).then((val) {
      var data = json.decode(val.toString());
      songModel = AudioPlayModel.fromJson(data);
      num songDuration = songModel.bitrate.fileDuration;
      String endDuration = _formatTime(songDuration);
      setState(() {
        fileDuration = songDuration.toDouble();
        endTime = endDuration;
        picPremium = songModel.songinfo.picPremium;
        songURL = songModel.bitrate.fileLink;
        songName = songModel.songinfo.title + '--' + songModel.songinfo.author;
      });
      if (isPlay == true) {
          audioPlayer.play(songURL);
      }
    });
    setPlayerIndex(index);
  }

  // 随机播放
  _circulationPlay() {
    var random = math.Random();
    currentIndex = random.nextInt(listmodel.songList.length);
    print("--随机播放-${currentIndex}");
    _play(currentIndex);
  }

  // 单曲循环
  _singlePlay() {
    print("--单曲循环-${currentIndex}");
    if(initPlayer ==0){
      currentIndex = initPlayer;
    }
    _play(currentIndex);
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
//        Container(
//          color: Colors.white,
//          margin: EdgeInsets.only(top: Dimens.titleHeight),
//          constraints: BoxConstraints.expand(height: Dimens.titleHeight),
//          child: TabBar(
//              labelColor: Colors.deepOrange,
//              unselectedLabelColor: Colors.black,
//              indicatorColor: Colors.deepOrange,
//              controller: tabController,
//              tabs: [
//                Tab(child: new Text('详情'),),
//                Tab(child: new Text('主播'),),
//                Tab(child: new Text('评论'),)
//              ]),
//        ),
        titleView(),
      ],
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
                    print("-----");
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
              GestureDetector(
                child: isPlayer?Container(
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('images/player.png',width: 20,height:
                  20,color: Colors.white,),
                ),
                onTap: () {
                },
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Offstage(
              offstage: _isDividerGone,
              child: Divider(height: 1, color: MyColors.dividerDarkColor),
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
                this.setState(() {
                  playModel = 0;
                });
              } else {
                this.setState(() {
                  playModel += 1;
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
                  child: new Text(playModel == 0?"顺序播放":playModel ==
                      1?"单一循环":"随机播放",
                    style: TextStyle(color: MyColors.white,fontSize: 12),),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () { //上一集
              setState(() {
                isPlay = true;
                first  = false;
              });
              if (playModel == 2) {
                _circulationPlay();
              } else if (playModel == 1) {
                _singlePlay();
              } else {
                // 如果第一首,就播放第后一首
                if (currentIndex == 0) {
                  currentIndex = listmodel.songList.length - 1;
                  _play(currentIndex);
                } else {
                  currentIndex -= 1;
                  _play(currentIndex);
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
              });
              if (isPlay == true && first == false) {
                audioPlayer.play(songURL);
                setState(() {
                  first = true;
                });
              }
              if (isPlay) {
                // 继续播放
                audioPlayer.resume();
              } else {
                // 暂停
                audioPlayer.pause();
              }
            },
            child: !_isLoadPlayer?Container(
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
                isPlay = true;
                first = false;
              });
              if (playModel == 2) {
                _circulationPlay();
              } else if (playModel == 1) {
                _singlePlay();
              } else {
                // 如果最后一首,就返回播放第一首
                if (currentIndex == listmodel.songList.length - 1) {
                  currentIndex = 0;
                  _play(currentIndex);
                } else {
                  currentIndex += 1;
                  _play(currentIndex);
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
                },
              ).then((val) {
                print(val);
              });
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
        itemCount: listmodel.songList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              currentIndex = index; // 当前第几首
              first = false;
              isPlay = true;
              _play(index);  // 播放
              Navigator.of(context).pop();  // 返回
            },
            child: ListTile(
              title: Text(
                listmodel.songList[index].title,
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
                        inactiveTrackColor: Colors.grey, //进度条滑块右边颜色
                        trackShape: RoundSliderTrackShape(),//进度条形状,这边自定义两头显示圆角
                        thumbColor: Colors.white, //滑块颜色
                        thumbShape: RoundSliderThumbShape(//可继承SliderComponentShape自定义形状
                          disabledThumbRadius: 5, //禁用是滑块大小
                          enabledThumbRadius: 5, //滑块大小
                        ),
                        trackHeight: 2 //进度条宽度

                    ),//进度条宽度
                  child: Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.red,
                    value: _value,
                    onChanged: (newValue) {
                      setState(() {
                        _value = newValue;
                      });
                      // 进度 -> 秒数
                      int sec = (
                          newValue *
                          fileDuration).toInt();
                      audioPlayer.seek(new Duration(seconds: sec));
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
