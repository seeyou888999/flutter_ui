import 'package:flutter/foundation.dart' show ChangeNotifier;
class HomeVipCourseModel with ChangeNotifier {
  int  _currIndex = 0;
  int get currIndex => _currIndex;

  setCurrIndexVip(int index){
    _currIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}