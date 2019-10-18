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

    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: deviceHeight / 12 * deviceWidth / 400,
        width: targetWidth / 2.8,
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFFfab407),
          elevation: 7.0,
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: deviceHeight / 30 * deviceWidth / 400, 
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ),
    );
  }
}