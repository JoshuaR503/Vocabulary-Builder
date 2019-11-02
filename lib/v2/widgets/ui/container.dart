import 'package:flutter/material.dart';

class SimpleContainer extends StatelessWidget {

  SimpleContainer({
    @required this.child
  }) : assert(child != null);

  final Widget child;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;
    final bool isSmall = deviceWidth < 480 && deviceHeight < 200;
    final bool isBig = deviceWidth >= 500.0;

    final double smallWidth = deviceWidth / 30;
    final double bigWidth = deviceWidth / 10;

    final double horizontal = isSmall 
    ? smallWidth : isBig
    ? bigWidth : 6;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: child,
    );
  }
}