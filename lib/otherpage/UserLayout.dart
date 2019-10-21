import 'package:flutter/material.dart';
class ULayout extends StatefulWidget {
  final ULayOutEnum ULayOut;
  final List<Widget> children;
  ULayout(this.ULayOut,this.children);

  @override
  _ULayoutState createState() => _ULayoutState();
}
//布局
class _ULayoutState extends State<ULayout> {

  @override
  Widget build(BuildContext context) {
    switch(widget.ULayOut){
      case ULayOutEnum.ULayOut:
        // TODO: Handle this case.
        break;
      case ULayOutEnum.ULayOutHot:
        // TODO: Handle this case.
        break;
      case ULayOutEnum.ANIMATED_MOVEMENT_LCR:
        // TODO: Handle this case.
        break;
      case ULayOutEnum.ANIMATED_MOVEMENT_TWEEN:
        // TODO: Handle this case.
        break;
    }
  }

  Widget _buildULayOut(){
    return Container(
        margin: EdgeInsets.all(10),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.children[0],
            new Expanded(
                child: new Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        widget.children[1],
                        widget.children[2],
                        widget.children[3],
                      ],
                    ),
                    widget.children[4],
                    Row(
                      children: <Widget>[
                        Row(children: <Widget>[
                          SizedBox(width: 20,),
                          Icon(Icons.play_arrow,size: 15,color: Colors.grey
                              .withOpacity(0.3),),
                          new Text('2000.5万',style: TextStyle(fontSize: 12,
                              color: Colors.grey.withOpacity(0.5)),),
                          SizedBox(width: 5,),
                          Icon(Icons.message,size: 15,color: Colors.grey
                              .withOpacity(0.3),),
                          new Text('465',style: TextStyle(fontSize: 12,
                              color: Colors.grey.withOpacity(0.5))),
                          SizedBox(width: 5,),
                          Icon(Icons.access_time,size: 15,color: Colors.grey
                              .withOpacity(0.3),),
                          new Text('09:45',style: TextStyle(fontSize: 12,
                              color: Colors.grey.withOpacity(0.5))),
                          SizedBox(width: 5,),
                          new Text('已播放:27%',style: TextStyle(fontSize: 12,
                              color: Colors.orange),),
                        ],),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(icon: Icon(Icons.file_download,size: 20,color:
                            Colors.grey.withOpacity(0.5),),onPressed: (){
                              print('下载---');
                            },),
                          ),
                        )
                      ],
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Divider(height: 2,color: Colors.grey.withOpacity(0.5),indent:
                      10,),
                    )
                  ],
                )
            ),
          ]
          ,
        )
    );
  }

}

enum ULayOutEnum {
  ULayOut,
  ULayOutHot,
  ANIMATED_MOVEMENT_LCR,
  ANIMATED_MOVEMENT_TWEEN,
}
