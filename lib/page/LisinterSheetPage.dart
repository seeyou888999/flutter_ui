import 'package:flutter/material.dart';
class LisinterSheetPage extends StatefulWidget {
  @override
  _LisinterSheetPageState createState() => _LisinterSheetPageState();
}

class _LisinterSheetPageState extends State<LisinterSheetPage> {
  int totalItemCount = 0;
//  List<SectionHeaderModel> sectionHeaderList = List();
  List<int> sectionTotalWidgetCountList = List();
  ScrollController scrollController;
  ListView listView;
  bool insideSetStateFlag = false;


  @override
  Widget build(BuildContext context) {
  }
}
