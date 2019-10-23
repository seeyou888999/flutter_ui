import 'package:flutter/material.dart';
import 'package:flutter_ui/res/colors.dart';
class CustomSlider extends StatefulWidget {

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {

  double totalWidth = 200;
  double percentage;
  Color positiverColor;
  Color negetiverColor;
  double initial = 0.0;
//  Color positiverColor = Color(0xFF000000);
//  Color negetiverColor = Color(0xFFFFFFFF);
  final mykey = new GlobalKey();
  double dx = 0.0;
  double dy = 0.0;

  void dragEvent(DragUpdateDetails details){
    double distance = details.globalPosition.dx - initial;
    double precentageAddition = distance / (MediaQuery.of(context).size.width - 30);
    final RenderObject box = context.findRenderObject();
    //  获得自定义Widget的大小，用来计算Widget的中心锚点
    percentage = (percentage + precentageAddition).clamp(0.0, 100.0);
    double dxx = (percentage*2.6).toDouble(); //控制滑块的移动倍率是描点的2.6倍数
    print(percentage);
    setState(() {
      dx  = dxx;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child:
        GestureDetector(
          onHorizontalDragUpdate : dragEvent,
          onHorizontalDragDown: (DragDownDetails details){
            setState(() {
              initial = details.globalPosition.dx;
            });
          },

          child: Stack(
            children: <Widget>[
              Positioned(
                child: buildSlider(),
              ),
              Positioned(
                child: Transform.translate(
                  offset: Offset(dx<0?0:dx, 0),
                  child: Container(
                    height: 18,
                    key: mykey,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: new Text(
                            '00:00/09:10',
                            style:
                            TextStyle(fontSize: 12, color: MyColors.textBlack9),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        )
    );
  }

  Widget buildSlider(){
    return Container(
      width: totalWidth ,
      height: 5,
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: negetiverColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: positiverColor,
              borderRadius: BorderRadius.circular(50),
            ),
            width: (percentage/100*totalWidth).toDouble(),
          ),
        ],
      ),
    );
  }
}

