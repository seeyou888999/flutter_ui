import 'package:flutter/material.dart';
import 'package:flutter_ui/common/provide_util.dart';
///定义返回widget组件自定义方法
class StoreProvider extends StatefulWidget {
  final Widget widget;
  final Object object;
  StoreProvider({this.widget,this.object});

  @override
  _StoreProviderState createState() => _StoreProviderState();
}

class _StoreProviderState extends State<StoreProvider> {
  var containerView;
  @override
  Widget build(BuildContext context) {

  }
}
