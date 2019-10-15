import 'package:flutter/material.dart';

class GradientDemo extends StatefulWidget {
  GradientDemo({Key key}) : super(key: key);

  _GradientDemoState createState() => _GradientDemoState();
}

const maxOffset=100;
class _GradientDemoState extends State<GradientDemo> {

  double opacityValue=0;

  void _onScrol(offset){
    double alpha=offset/maxOffset;
    if(alpha<0){
      alpha=0;
    }else if(alpha>1){
      alpha=1;
    }

    setState(() {
      opacityValue=alpha;
    });

    //print(offset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: NotificationListener(          //状态监听
                    onNotification: (notification){
                      //如果是滚动更新通知的值并且深度限制为0[就是监听ListView]
                      if(notification is ScrollUpdateNotification && notification.depth==0){
                        //如果是
                        _onScrol(notification.metrics.pixels);
                        return true;
                      } else{
                        return false;
                      }
                    },
                    child: ListView(
                      children: <Widget>[
                        Image.network('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562324532571&di=80a74e17231e47372ad4cacda1926230&imgtype=0&src=http%3A%2F%2Fphotos.tuchong.com%2F414540%2Ff%2F27530238.jpg',height: 180,fit: BoxFit.cover,),
                        Container(
                          height: 500,
                          child: Text(
                            '渐变appBar',
//                            style: Theme.of(context).textTheme.display2
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Opacity(
              opacity: opacityValue,
              child: Container(
                height: 80,
                child: AppBar(
                  backgroundColor: Colors.white,
                  textTheme: TextTheme(
                    title: TextStyle(color: Colors.black87)
                  ),
                  title: Text('渐变AppBar1111111111'),
                  centerTitle: true,
                  leading: Icon(Icons.add,color: Colors.black12,),
                  actions: <Widget>[
                    Icon(Icons.list,color: Colors.black12,)
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
