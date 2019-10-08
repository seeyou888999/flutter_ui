import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_ui/common/global.dart';
class HomeTabModel with ChangeNotifier {

  List _colorsAll = ['#EE2602','#2F3F25','#C7877B','#0f68B8','#AB2F23','#0000'
      '00'];
  int _index = 0;
  int get index =>_index;
  List get colorsAll => _colorsAll;
  bool _boolPay = true;
  bool get boolPay =>_boolPay;
  int _payIndex = 0;
  int get playIndex => _payIndex;
  int _currIndex = 0;
  int get currIndex => _currIndex;
  int _isScroll = 0;
  int get isScroll => _isScroll;
  void stopPaly(bool play){
    _boolPay = play;
    notifyListeners();
  }
  void setCurrIndex(int index){
    _currIndex = index;
    notifyListeners();
  }
  void setIndex(int index){
    _index = index;
    notifyListeners();  //通知所有监听此方法的widget
  }

  String getIndex(index){
    return  _colorsAll[index];
  }
  Map getMap(int index){
    return Aphome[0]["search"][index];
  }

  void setIsScroll(int index){
    _isScroll = index;
    notifyListeners();
  }


  @override
  void dispose() {
    super.dispose();
  }
}