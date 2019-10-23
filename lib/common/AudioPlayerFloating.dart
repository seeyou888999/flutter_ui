import 'package:flutter/cupertino.dart';
import 'package:flutter_ui/common/AudioPlayerManager.dart';

class AudioPlayerFloating {
  factory AudioPlayerFloating (BuildContext context) =>_getInstance(context);
  static AudioPlayerFloating _instance;
  static AnimationController controller;
  static Animation animation;
  static AnimationController percentageAnimationController;
  static Animation percentageAnimation;
  static double fileDuration;
  static AudioPlayerFloating _getInstance(BuildContext buildContext) {
    if (_instance == null) {
      _instance = new AudioPlayerFloating(buildContext);
    }
    return _instance;
  }

}