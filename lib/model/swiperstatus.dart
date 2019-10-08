import 'package:flutter/foundation.dart' show ChangeNotifier;
class SwiperModel extends ChangeNotifier{
  int _swiperIndex;

  int get swiperIndex => _swiperIndex;

  set swiperIndex(int value) {
    _swiperIndex = value;
    notifyListeners();
  }

}