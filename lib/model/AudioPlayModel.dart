import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_ui/common/global.dart';
import 'package:flutter_ui/model/audio_paly_model.dart';
class AudioPlayModelNotifier with ChangeNotifier {

  double _value = 0.0;
  double _fileDuration = 1;
  bool _isPlayState =  true;

  double get value => _value;
  double get fileDuration => _fileDuration;
  bool get isPlayState => _isPlayState;

  void setIsPlayState (bool){
    _isPlayState = bool;
    notifyListeners();
  }

  void setValuePlay(double value){
    _value = value;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }



}