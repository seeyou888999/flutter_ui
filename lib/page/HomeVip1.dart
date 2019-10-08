import 'package:flutter/material.dart';

class HomeVip1 extends StatefulWidget {
  @override
  _HomeVip1State createState() => _HomeVip1State();
}

class _HomeVip1State extends State<HomeVip1> with
    AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin{
  List<String> imagelist = [
    "https://imagev2.xmcdn.com/group59/M04/56/7A/wKgLelywO4ui6kAcAA2Dn_a4-Dw097.jpg",

  ];
  @override
  Widget build(BuildContext context) {
    print("======HomeVip1======");
    return Container(

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
