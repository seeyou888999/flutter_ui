import 'package:flutter/cupertino.dart';

class BottomModel with ChangeNotifier{
   int _isshow = 0;
   List _list;

   int get isshow => _isshow;

   List get list => _list;

   void setModelList(List list){
     _list = list;
     notifyListeners();
   }

}