import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  Button(
    this.name,
    this.onTap,
    this.targetWidth
  ) : assert(name != null),
      assert(targetWidth != null);

  final String name;
  final Function onTap;
  final double targetWidth;
  
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 55.0,
        width: targetWidth / 2.8,
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFFfab407),
          elevation: 7.0,
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 22.0, 
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ),
    );
  }
}