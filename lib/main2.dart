import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_ui/common/PopupMenuItem.dart';
import 'package:flutter_ui/common/global.dart';

void main()=>runApp(DemoPage());
class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {

  final List tabs = ['进行中', '已完成'];

  final List datas = [
    {'title': '选项一', 'value': 1},
    {'title': '选项二', 'value': 2},
    {'title': '选项三', 'value': 3},
    {'title': '选项四', 'value': 4},
    {'title': '选项五', 'value': 5},
    {'title': '选项六', 'value': 6},
    {'title': '选项七', 'value': 7},
    {'title': '选项八', 'value': 8},
    {'title': '选项九', 'value': 9},
  ];

  final Color _bgColor = Color.fromRGBO(83, 94, 104, 1);
  String typeName = '选项一';
  SwiperController _swiperController;
  @override
  void initState() {
    _swiperController = new SwiperController();
    _swiperController.stopAutoplay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: new Text('123'),
        centerTitle: true,
        backgroundColor: _bgColor
        ),
        body: Swiper(
          itemCount: (newTitle.length/2).toInt(),
          autoplay: false,
          loop:false,
          controller: _swiperController,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((c,i){
            print(i);
            return Container(
              child: Column(
                children: [
                  Container(child: new Title(color: Colors.red, child: new 
                  Text('$i')),)
                ],
              ),
            );
          }),
        ),
        )
    );
  }
}