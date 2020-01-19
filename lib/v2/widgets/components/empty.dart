import 'package:flutter/material.dart';

class EmptyStateScreen extends StatelessWidget {

  final String message, pathImage, fixMessage;

  EmptyStateScreen({
    this.message,
    this.pathImage,
    this.fixMessage
  });

  final TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
  );

  final TextStyle bottomStyle = TextStyle(
    color: Colors.white,
    fontFamily: "CircularStd",
    fontSize: 20.0
  );

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
  
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(top: height / 8),
        children: <Widget>[
          
          Container(
            child: Text(
              message,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 25),
          Container(
            child: Image.asset(
              pathImage,
              width: 125.0,
              height: 125.0,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(height: 10),
          Container(
            child: Text(
              fixMessage,
              style: bottomStyle,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: height / 8),
        ],
      )
    );
  }
}
