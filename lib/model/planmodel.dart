import 'package:flutter/foundation.dart' show ChangeNotifier;
class PlanModel with ChangeNotifier {

  List _FontAll = ['#000000','#D7BDA6'];
  int _status = 0;
  String _searchTitle = '';
  bool _showAppBar = true;
  List<String> _lists = new List();
  int get status => _status;
  String get searchTitle => _searchTitle;
  bool get showAppBar => _showAppBar;
  List<String> get lists => _lists;
  List get fontAll => _FontAll;

  void setSearchTitle(String  searchTitle){
    _searchTitle = searchTitle;
  }

  void showAppBars(bool Appbar){
    _showAppBar = Appbar;
    notifyListeners();
  }

  void addList(value){
     lists.add(value);
     _lists = lists.toSet().toList();
    notifyListeners();
  }
  void clearList(){
    lists.clear();
    notifyListeners();
  }
  String getFontColor(int index){
    return _FontAll[index];
  }
  @override
  void dispose() {
    super.dispose();
  }
}