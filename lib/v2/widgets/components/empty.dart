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
    fontWeight: FontWeight.w400,
    fontSize: 20.0
  );

  List<Widget> _buildChildren(double height, double pictureHeight) {
    return <Widget>[
      Container(
        margin: EdgeInsets.only(
          top: height / 12, 
          left: height / 16, 
          right: height/ 16
        ),
        
        child: Text(
          message,
          style: titleStyle,
          textAlign: TextAlign.center,
        ),
      ),

      Container(
        margin: EdgeInsets.symmetric(
          vertical: pictureHeight, 
          horizontal: height / 50
        ),
        child: Image.asset(
          pathImage,
          width: 200.0,
          height: 200.0,
          fit: BoxFit.contain,
        ),
      ),

      Container(
        margin: EdgeInsets.symmetric( horizontal: height / 16),
        child: Text(
          fixMessage,
          style: bottomStyle,
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double pictureHeight = height > 600  ? height / 25 : 12.0;
  
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: _buildChildren(height, pictureHeight),
        )
      ),
    );
  }
}