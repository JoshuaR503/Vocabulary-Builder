import 'package:flutter/material.dart';

class WordDataCard extends StatelessWidget {

  final Widget child;
  final EdgeInsets padding;

  WordDataCard({
    this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
  }) 
    : assert (child != null);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      color: Color(0XFF2b2b2b),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: padding,
        child: child,
      )
    );
  }
}