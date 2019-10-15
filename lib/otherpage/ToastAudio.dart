import 'package:flutter/material.dart';

class ToastUtil{
  static  ToastView toastView;
  static show(BuildContext context,String msg,{Widget widget}){
    toastView?._dissmiss();
    var overlayState = Overlay.of(context);

    /*给overlayState添加动画 */
    addAnimation(overlayState);

    OverlayEntry overlayEntry = new OverlayEntry(
        builder: (BuildContext context){
          return ToastWidget(
            opacityAnim1: opacityAnim1,
            opacityAnim2: opacityAnim2,
            offsetAnim: offsetAnim,
            child: buildToastLayout(msg,widget),
          );
        });
    toastView = new ToastView();
    toastView.overlayState = overlayState;
    toastView.overlayEntry = overlayEntry;
    toastView.controllerShowAnim = controllerShowAnim;
    toastView.controllerShowOffset = controllerShowOffset;
    toastView.controllerHide = controllerHide;
    toastView._show();
  }

  static dissmiss(){
    toastView._dissmiss();
  }

  /*构建要显示的toast的view*/
  static LayoutBuilder buildToastLayout(String msg,Widget widget){
    return LayoutBuilder(builder: (context,constraints){

      return IgnorePointer(
        ignoring: false,
        child: Container(
          child: Material(
            child: widget
          )
        )
      );
    });
  }

  static var controllerShowAnim;
  static var controllerShowOffset;
  static var controllerHide;
  static var opacityAnim1,showoffsetAnim,offsetAnim,opacityAnim2;
  static void addAnimation(OverlayState overlayState){
    controllerShowAnim = new AnimationController(vsync: overlayState,duration: Duration(milliseconds: 350));
    controllerShowOffset = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 350),
    );
    controllerHide = new AnimationController(
      vsync: overlayState,
      duration: Duration(milliseconds: 250),
    );

    opacityAnim1 = new Tween(begin: 0.0,end: 1.0).animate(controllerShowAnim);
    showoffsetAnim = new CurvedAnimation(parent: controllerShowOffset, curve: Curves.bounceOut);
    offsetAnim = new Tween(begin: 30.0,end: 0.0).animate(controllerShowOffset);
    opacityAnim2 = new Tween(begin: 1.0, end: 0.0).animate(controllerHide);
  }
}

class ToastWidget extends StatelessWidget {

  final Widget child;
  final Animation<double> opacityAnim1;
  final Animation<double> opacityAnim2;
  final Animation<double> offsetAnim;

  ToastWidget(
      {this.child, this.offsetAnim, this.opacityAnim1, this.opacityAnim2});

  @override
  Widget build(BuildContext context) {

    return new AnimatedBuilder(
        animation: opacityAnim1,
        child: child,
        builder:(BuildContext context, Widget child){
          return Opacity(
            opacity: opacityAnim1.value,
            child:AnimatedBuilder(
                animation: offsetAnim,
                builder: (context,_){
                  return Transform.translate(
                    offset: Offset(0, offsetAnim.value),
                    child: AnimatedBuilder(
                        animation: opacityAnim2,
                        builder: (context,_){
                          return Opacity(
                            opacity: opacityAnim2.value,
                            child: child,
                          );
                        }),);
                }) ,);
        });
  }

}

class ToastView{
  OverlayEntry overlayEntry;
  OverlayState overlayState;
  bool dissmissed = false;

  AnimationController controllerShowAnim;
  AnimationController controllerShowOffset;
  AnimationController controllerHide;

  /*显示 延迟3.5秒 消失*/
  _show() async{
    overlayState.insert(overlayEntry);
    controllerShowAnim.forward();
    controllerShowOffset.forward();
    //await Future.delayed(Duration(seconds: 3));
    //_dissmiss();
  }

  /*消失*/
  _dissmiss() async{
    print(dissmissed);
    if(dissmissed){
      return;
    }
    controllerHide.forward();
    this.dissmissed = true;
    await Future.delayed(Duration(milliseconds: 250));
    overlayEntry.remove();
  }
}