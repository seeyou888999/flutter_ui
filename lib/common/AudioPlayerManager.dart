import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ui/model/audio_list_model.dart';
import 'package:flutter_ui/model/audio_paly_model.dart';
import 'package:flutter_ui/service/service_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioPlayerManager {

  factory AudioPlayerManager(BuildContext context) =>_getInstance(context);
  static AudioPlayerManager _instance;
  static AudioPlayer audioPlayer;
  static AudioPlayModel songModel; // 当前歌曲信息model
  static AudioListmodel listmodel; // 所有歌曲model
   static BuildContext buildContext;
  static List songsResults = []; // 歌曲list数据数组
  static String picPremium =
      'https://ww1.sinaimg.cn/large/0073sXn7ly1fze9706gdzj30ae0kqmyw'; // 背景图片, 先给一张图片,省的报警告
  static double value=0;
  static int currentIndex = 0; // 当前第几首,默认加载第一首
  // 播放模式: 0 列表 1单曲  2  随机
  static double fileDuration = 1; // 歌曲时长
  static double currenTime = 0; //当前几秒
  static String songURL = ''; // 当前播放url
  static bool isPlay = true; // 播放状态 默认未播放
  static bool first = false; // 是否是首次点击播放按钮
  static String songName = ''; //歌曲名
  static String startTime = '00:00'; // 开始时间
  static String endTime = '00:00'; // 结束时间
  static int playModel = 0; // 播放模式: 0 列表 1单曲  2  随机
  static int initPlayer = 0; //初始化播放
  static bool isPlayer = true;
  static bool isLoadPlayer = true;
  static bool isStop = false;
  static bool isOnePlay = true;
  AudioPlayerManager._internal(BuildContext context) {
    // 初始化
    createPlayerInstance();
  }

  //缓冲文件
  static StreamSubscription onDurationChange(Function temp){
      return audioPlayer.onDurationChanged.listen(temp);
  }
  //播放器时间发生变化
  static StreamSubscription onAudioPositionChanged(Function temp){
    return audioPlayer.onAudioPositionChanged.listen(temp);
  }
  //播放器状态发生变化情况
  static  StreamSubscription onPlayerStateChanged(Function temp){
    return audioPlayer.onPlayerStateChanged.listen(temp);
  }
  //播放器完成的时候
  static StreamSubscription onPlayerCompletionStream(Function temp){
    return audioPlayer.onPlayerCompletion.listen(temp);
  }

  //初始化单例AudioPlayer
  static AudioPlayer createPlayerInstance(){
    if (audioPlayer == null) {
      audioPlayer = new AudioPlayer();
    }
    return audioPlayer;
  }
  // 随机播放
  static circulationPlay() {
    var random = math.Random();
    currentIndex = random.nextInt(listmodel.songList.length);
    print("--随机播放-${currentIndex}");
    play(currentIndex);
  }

  // 单曲循环
  static singlePlay() {
    print("--单曲循环-${currentIndex}");
    if(initPlayer ==0){
      currentIndex = initPlayer;
    }
    play(currentIndex);
  }

  static formatTime(num time) {
    // 71s -> 01:11
    num min = (time / 60).floor();
    num second = time - min * 60;
    min = min >= 10 ? min : 0 + min;
    second = second >= 10 ? second : 0 + second;
    return min.toString() + ':' + second.toString();
  }

  static AudioPlayerManager _getInstance(BuildContext buildContext) {
    if (_instance == null) {
      _instance = new AudioPlayerManager._internal(buildContext);
    }
    return _instance;
  }

 // 获取音频列表数据
 static void getVideoData(final aguments) async {//当进入该页面的时候加载（上下一集不触发）
    await get('audioList').then((val) {
      var data = json.decode(val.toString());
      listmodel = AudioListmodel.fromJson(data); // 赋值model
      songsResults.addAll(listmodel.songList);
      // 默认加载第一首
      if(aguments!=null){
        AudioPlayerManager.currentIndex = aguments["playerIndex"];
        play(aguments["playerIndex"]);
      } else {
        AudioPlayerManager.currentIndex = int.parse(getPlayerIndex().toString());
        play(getPlayerIndex());
      }
    });
  }
   //播放器播放完成切换下一集
  static int onPlayerCompletion(){
     if(playModel == 0){ //列表播放
       if(initPlayer ==0){
         initPlayer+=1;
         currentIndex = initPlayer;
       } else {
         currentIndex==listmodel.songList.length-1?currentIndex = 0:currentIndex += 1;
       }
       print("--列表播放-${currentIndex}-");
       play(currentIndex);
     } else if(playModel == 1){//单一循环
       if(initPlayer ==0){
         currentIndex = 0;
       }
       print("--单一循环-${currentIndex}-");
       singlePlay();
     } else {//随机播放
       print("--随机播放-${currentIndex}-");
       circulationPlay();
     }
     setPlayerIndex(currentIndex);
     return currentIndex;
  }

  static play(index) async {
    print("准备播放索引--${index}");
    String songId = songsResults[index].songId.toString();
    String formdata = '&songid=' + songId;
    await get('audioInfo', formData: formdata).then((val) {
      var data = json.decode(val.toString());
      songModel = AudioPlayModel.fromJson(data);
      num songDuration = songModel.bitrate.fileDuration;
      String endDuration = formatTime(songDuration);
        fileDuration = songDuration.toDouble();
        endTime = endDuration;
        picPremium = songModel.songinfo.picPremium;
        songURL = songModel.bitrate.fileLink;
        songName = songModel.songinfo.title + '--' + songModel.songinfo.author;
      if (isPlay == true) {
        audioPlayer.play(songURL);
      }
      setPlayerIndex(index);
      //onclick();
    });
  }

  static Future setPlayerIndex(int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('picPremium', 'https://imagev2.xmcdn.com/group47/M00/2B/E1/wKgKm1uEthTz13hxAAROx6fnPZ8302.jpg');
    prefs.setInt('playerIndex', index);
  }

  void CancelPlayer(){
//    AudioPlayer.players.forEach((index,player){
//      player.
////      if(player.playerId != audioPlayer.playerId ){
////
////        player.stop();
////      }
//    });
  }

  static Future<int> getPlayerIndex() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('playerIndex');
  }

}