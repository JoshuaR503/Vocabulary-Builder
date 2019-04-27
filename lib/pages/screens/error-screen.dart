import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {

  final String message, pathImage, fixMessage;

  ErrorScreen({
    this.message,
    this.pathImage,
    this.fixMessage
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: <Widget>[
          Container(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            
            ),
            margin: EdgeInsets.only(top: 30.0, bottom: 50.0, left: 20, right: 20),
          ),
          Image.asset(
            pathImage,
            width: 200.0,
            height: 200.0,
            fit: BoxFit.contain,
          ),
          Container(
            child: Text(
              fixMessage,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
            ),
            margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          ),
        ],
      ),
    );
  }
}