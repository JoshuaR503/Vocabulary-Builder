


import 'package:flutter/material.dart';

class WordDataCard extends StatelessWidget {

  final Widget child;

  WordDataCard({this.child}) 
    : assert (child != null);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      color: Color(0XFF303030),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: child
    );
  }
}