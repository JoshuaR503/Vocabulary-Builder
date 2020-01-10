import 'package:flutter/material.dart';

class CustomWordCard extends StatelessWidget {

  CustomWordCard({
    this.color = 0XFF1D1E33,
    this.width = 170,
    this.child,
    this.function
  });

  final int color;
  final double width;
  final Widget child;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.function,
      child: Container(
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(10.0)
        ),
  
        margin: EdgeInsets.all(10),
        height: 200,
        width: this.width,
        child: child,
      ),
    );
  }
}
