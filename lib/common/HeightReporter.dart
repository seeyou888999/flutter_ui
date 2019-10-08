import 'package:flutter/material.dart';
class HeightReporter extends StatelessWidget {
  final Widget child;
  final VoidCallback;
  HeightReporter({this.child,this.VoidCallback});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: child,
      onTap: () {
        print('Height is ${context.size.height}');
      },
    );
  }
}